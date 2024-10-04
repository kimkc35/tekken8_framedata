import 'dart:convert';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekken8_framedata/character_variables.dart';
import 'package:tekken8_framedata/main.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'modules.dart';

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

class PlayerDetailsPage extends StatefulWidget {
  final PlayerInfo playerInfo;
  const PlayerDetailsPage({super.key, required this.playerInfo});

  @override
  State<PlayerDetailsPage> createState() => _PlayerDetailsPageState();
}
class _PlayerDetailsPageState extends State<PlayerDetailsPage> with SingleTickerProviderStateMixin{

  late final TabController tabController;
  late bool isBookmarked;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    isBookmarked = bookmarkedList.any((element) => element.polarisId == widget.playerInfo.polarisId);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(preferredSize: Size(0, 50), child: TabBar(controller: tabController, tabs: [Tab(text: "스탯",), Tab(text: "캐릭터별 승률"), Tab(text: "전적",)],)),
        title: Row(children: [
          Text(widget.playerInfo.name),
          SizedBox(width: 5,),
          GestureDetector(child: Icon(isBookmarked? Icons.star : Icons.star_border, size: 24,), onTap: ()async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            super.setState(() {
              isBookmarked? bookmarkedList.remove(widget.playerInfo) : bookmarkedList.add(widget.playerInfo);
              isBookmarked = bookmarkedList.contains(widget.playerInfo);
              final List<String> playerInfoList = [];
              for(PlayerInfo bookmarked in bookmarkedList){
                playerInfoList.add(jsonEncode(bookmarked.toJson()));
              }
              prefs.setStringList('bookmarkedList', playerInfoList);
            });
          },)
        ]),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: TabBarView(controller: tabController, children: [StatTab(playerInfo: widget.playerInfo), CharacterTab(playerInfo: widget.playerInfo,) ,HistoryTab(playerInfo: widget.playerInfo)]),
    );
  }
}

class StatTab extends StatefulWidget {
  final PlayerInfo playerInfo;
  const StatTab({super.key, required this.playerInfo});

  @override
  State<StatTab> createState() => _StatTabState();
}

class _StatTabState extends State<StatTab> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  Future<PlayerDetails> details()async{
    Map<String, List<String>> statMap = {};

    final uri = Uri.https('tekkenstats.gg', '/player/${widget.playerInfo.number}');
    final response = await http.get(uri);
    dom.Document document = parser.parse(response.body);
    final prowess = document.querySelectorAll('div[class=font-bold]')[0].text;
    final rankPoint = document.querySelectorAll('div[class=font-bold]')[1].text;
    final statList = document.querySelectorAll('div[class=\'border border-zinc-800 rounded-lg\']');
    final imgUrl = document.querySelector('div[class=p-4]')?.querySelector('img')?.attributes["src"];

    for (var stat in statList) {
      int totalValue = 0;
      String statName = stat.querySelector('h2[class=\'text-lg font-semibold mb-2 px-3 py-2\']')!.text.toLowerCase();
      final statValues = stat.querySelectorAll('span[class=\'text-gray-300 font-bold\']');
      final List<String> valueList = [];
      for (var value in statValues){
        valueList.add(value.text);
        totalValue += int.parse(value.text);
      }
      statMap.addAll({
        statName : valueList
      });
      statMap[statName]?.insert(0, totalValue.toString());
    }
    final isBookmarked = bookmarkedList.contains(widget.playerInfo);

    PlayerDetails playerDetails = PlayerDetails(stats: statMap, prowess: prowess, imgUrl: imgUrl.toString(), rankPoint: rankPoint, isBookmarked: isBookmarked);

    return playerDetails;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: details(),
        builder: (context, snapshot) {
          statBar({required String title, required String name, required int index}){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 120, child: Text(name)),
                SizedBox(width: 30, child: Text(snapshot.data!.stats[title]![index])),
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 10,
                    percent: int.parse(snapshot.data!.stats[title]![index]) / 25,
                    backgroundColor: Colors.grey,
                    linearGradient: LinearGradient(
                        begin: Alignment(-1, 0),
                        end: Alignment(1, 0),
                        colors: [Color(0xFF770033), Color(0xFFff0022)]
                    ),
                  ),
                ),
              ],
            );
          }

          expansionTile(String title, List<String> statNames){
            return ExpansionTile(
              title: Text("${statNames[0]} : ${snapshot.data!.stats[title]![0]}"),
              children: [
                statBar(name: statNames[1], index: 1, title: title),
                statBar(name: statNames[2], index: 2, title: title),
                statBar(name: statNames[3], index: 3, title: title),
                statBar(name: statNames[4], index: 4, title: title)
              ],
            );
          }

          if(snapshot.hasData){
            final totalValues = [int.parse(snapshot.data!.stats["attack"]![0]), int.parse(snapshot.data!.stats["technique"]![0]), int.parse(snapshot.data!.stats["appeal"]![0]), int.parse(snapshot.data!.stats["spirit"]![0]), int.parse(snapshot.data!.stats["defense"]![0])];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Image.network(snapshot.data!.imgUrl),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("철권력 : ${snapshot.data!.prowess}"),
                                Text("랭크 포인트 : ${snapshot.data!.rankPoint}")
                              ],
                            )
                          ],
                        ),
                      ),
                      expansionTile("attack", ["공격", "타수", "큰 대미지", "적극성", "압도"]),
                      expansionTile("defense", ["수비", "가드", "회피", "잡기 풀기", "냉정"]),
                      expansionTile("technique", ["기술", "정밀도", "판단력", "받아치기", "스테이지 활용"]),
                      expansionTile("spirit", ["정신", "접전", "역경", "투지", "집중력"]),
                      expansionTile("appeal", ["매력", "경의", "향상심", "정정당당", "다채로움"]),
                      SizedBox(
                        height: 450,
                        child: RadarChart(
                            ticks: [0, 25, 50, 75, 100],
                            features: ["공격 ${totalValues[0]}\n", "기술 ${totalValues[1]}", "매력 ${totalValues[2]}", "정신 ${totalValues[3]}", "수비 ${totalValues[4]}"],
                            data: [totalValues],
                            graphColors: [CustomThemeMode.currentThemeData.value.primaryColor],
                            ticksTextStyle: TextStyle(color: Colors.transparent, fontSize: 12),
                            featuresTextStyle: TextStyle(color: CustomThemeMode.currentThemeData.value.primaryColor, fontSize: 15),
                            sides: 5
                        ),
                      )
                    ]
                ),
              ),
            );
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return Center(child: Text("로딩중..."));
        }
    );
  }
}

class CharacterTab extends StatefulWidget {
  final PlayerInfo playerInfo;
  const CharacterTab({super.key, required this.playerInfo});

  @override
  State<CharacterTab> createState() => _CharacterTabState();
}

class _CharacterTabState extends State<CharacterTab> with AutomaticKeepAliveClientMixin{

  Future<List<CharacterWinRate>> searchPlayer()async {
    Map<String, Map<String, int>> winRateList = {};
    List<CharacterWinRate> characterWinRateList = [];

    const baseUrl = "https://wank.wavu.wiki/player/";
    final url = "$baseUrl${widget.playerInfo.polarisId.replaceAll('-', '')}";
    final parse = Uri.parse(url);
    final response = await http.get(parse);
    dom.Document document = parser.parse(response.body);
    final matches = document.querySelector('div[style="overflow-x: auto;"] > table > tbody')!.querySelectorAll('tr');

    for(var match in matches){
      final character = match.querySelectorAll('td')[5].text;
      final result = match.querySelectorAll('td')[2].text.contains('WIN') ? 'win' : 'lose';
      if(result == 'win'){
        if(winRateList[character] == null) {
          winRateList.addAll({character: {
            "timeFaced": 1,
            "timeWin": 1,
            "timeLose": 0
          }});
        }else{
          winRateList[character]!["timeWin"] = winRateList[character]!["timeWin"]! + 1;
          winRateList[character]!["timeFaced"] =  winRateList[character]!["timeFaced"]! + 1;
        }
      }else{
        if(winRateList[character] == null) {
          winRateList.addAll({character: {
            "timeFaced": 1,
            "timeWin": 0,
            "timeLose": 1
          }});
        }else{
          winRateList[character]!["timeLose"] = winRateList[character]!["timeLose"]! + 1;
          winRateList[character]!["timeFaced"] =  winRateList[character]!["timeFaced"]! + 1;
        }
      }
    }

    for(var character in winRateList.entries){
      characterWinRateList.add(
          CharacterWinRate(oppChar: character.key, timeFaced: character.value["timeFaced"].toString(), timeWin: character.value["timeWin"].toString(), timeLose: character.value["timeLose"].toString(), winRate: (character.value["timeWin"]!/character.value["timeFaced"]! * 100).toStringAsFixed(2))
      );
    }

    return characterWinRateList;
  }

  final TextStyle headingStyle = TextStyle(fontWeight: FontWeight.bold);

  String sort = 'winRate';
  bool reverseSort = false;

  sortData(List<CharacterWinRate> data, String sortStandard){
    switch(sortStandard){
      case('oppChar'):
        data.sort((a, b) => a.oppChar.compareTo(b.oppChar));
      case('timeFaced'):
        data.sort((a, b) => (double.parse(a.timeFaced).ceil() - double.parse(b.timeFaced).ceil()));
      case('timeWin'):
        data.sort((a, b) => (double.parse(a.timeWin).ceil() - double.parse(b.timeWin).ceil()));
      case('timeLose'):
        data.sort((a, b) => (double.parse(a.timeLose).ceil() - double.parse(b.timeLose).ceil()));
      case('winRate'):
        data.sort((a, b) => (double.parse(a.winRate).ceil() - double.parse(b.winRate).ceil()));
    }

    if(reverseSort){
      return data;
    }
    return List.from(data.reversed);
  }

  Widget headingBox(double width, String name, String sortStandard){
    return SizedBox(width: width, child: TextButton(
      onPressed: (){
        super.setState(() {
          sort = sortStandard;
          if(sort == sortStandard){
            if(reverseSort){
              reverseSort = false;
            }else{
              reverseSort = true;
            }
          }else{
            reverseSort = false;
          }
        });
      },
      child: Text(name, textAlign: TextAlign.center, style: headingStyle,),
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: searchPlayer(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final data = sortData(snapshot.data!, sort);
              debugPrint("현재 상태 : $sort");
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      headingBox(70, "상대 \n캐릭터", "oppChar"),
                      headingBox(80, "만난 횟수", "timeFaced"),
                      headingBox(40, "승", "timeWin"),
                      headingBox(40, "패", "timeLose"),
                      headingBox(70, "승률", "winRate"),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(height: 1, color: CustomThemeMode.currentThemeData.value.primaryColor,),
                  SizedBox(height: 4,),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 70, child: Text(data[index].oppChar, textAlign: TextAlign.center)),
                                SizedBox(width: 80, child: Text(data[index].timeFaced, textAlign: TextAlign.center)),
                                SizedBox(width: 40, child: Text(data[index].timeWin, textAlign: TextAlign.center)),
                                SizedBox(width: 40, child: Text(data[index].timeLose, textAlign: TextAlign.center)),
                                SizedBox(width: 70, child: Text("${data[index].winRate}%", textAlign: TextAlign.center)),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(height: 1, decoration: BoxDecoration(color: CustomThemeMode.currentThemeData.value.primaryColor),),
                        itemCount: snapshot.data!.length),
                  ),
                ],
              );
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            return Center(child: Text("로딩중..."));
        },),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HistoryTab extends StatefulWidget {
  final PlayerInfo playerInfo;
  const HistoryTab({super.key, required this.playerInfo});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with AutomaticKeepAliveClientMixin{

  convertDate(String date){
    final String currentDate = date.replaceAll("Jan", "01")
        .replaceAll("Feb", "02 ")
        .replaceAll("Mar", "03 ")
        .replaceAll("Apr", "04 ")
        .replaceAll("May", "05 ")
        .replaceAll("Jun", "06 ")
        .replaceAll("Jul", "07 ")
        .replaceAll("Aug", "08 ")
        .replaceAll("Sep", "09 ")
        .replaceAll("Oct", "10 ")
        .replaceAll("Nov", "11 ")
        .replaceAll("Dec", "12 ");

    final String forward = currentDate.split(",")[0], backward = currentDate.split(",")[1];
    final int month = int.parse(forward.split(" ")[0]), day = int.parse(forward.split(" ")[1]);
    final int year = int.parse(backward.split('@')[0]);
    final String time = backward.split('@')[1];
    final int hour = int.parse(time.split(':')[0]), minute = int.parse(time.split(':')[1]);

    final convertedDate = DateFormat("yyyy년 MM월 dd일 k:mm").format(DateTime(year, month, day, hour, minute).add(Duration(hours: 9)));

    return convertedDate;
  }

  String convertScore(String score){
    final currentScore = score.replaceAll("\n", "").replaceAll(" ", "");
    return currentScore.replaceFirstMapped(RegExp(r'(\d)([A-Za-z])'), (Match m) => '${m[1]}\n${m[2]}');
  }

  Future<List<PlayHistory>> historyFuture()async{
    List<PlayHistory> historyList = [];

    final uri = Uri.https('tekkenstats.gg', '/player/${widget.playerInfo.number}');
    final response = await http.get(uri);
    final dom.Document document = parser.parse(response.body);
    final characterList = document.querySelector("div[class='rounded-lg overflow-hidden']")?.nextElementSibling?.nextElementSibling?.querySelectorAll("tr[class='border border-zinc-800 hover:bg-zinc-800/75']");

    for (var element in characterList!) {
      final date = convertDate(element.querySelector("td[class='px-4 py-2']")!.text.replaceAll(' ', '').replaceAll('\n', ''));
      final list = element.querySelectorAll("td[class=p-3]");

      historyList.add(
        PlayHistory(player: widget.playerInfo.name, date: date, playerChar: list[0].text, oppName: list[1].text.replaceAll("\n", "").replaceAll(" ", ""), oppChar: list[2].text, score: convertScore(list[3].text), type: list[4].text.replaceAll("Ranked", "랭크 매치").replaceAll("Quick", "퀵 매치").replaceAll("Player", "플레이어 매치"))
      );
    }

    return historyList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(
          future: historyFuture(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final data = snapshot.data!;
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(image: CachedNetworkImageProvider(characterImageUrls[data[index].playerChar.toLowerCase()] ?? "")),
                            Transform(alignment: Alignment.center,transform: Matrix4.rotationY(math.pi),child: Image(image: CachedNetworkImageProvider(characterImageUrls[data[index].oppChar.toLowerCase()] ?? ""))),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Align(alignment: Alignment.centerLeft, child: Text(data[index].date, textAlign: TextAlign.start,)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 100, child: Text("${data[index].player}\n${data[index].playerChar}", textAlign: TextAlign.center, style: TextStyle(height: 1.8),)),
                                  SizedBox(width: 80, child: Text(data[index].score, textAlign: TextAlign.center,)),
                                  SizedBox(width: 100, child: Text("${data[index].oppName}\n${data[index].oppChar}", textAlign: TextAlign.center, style: TextStyle(height: 1.8),)),
                                ]
                            ),
                            Text(data[index].type, textAlign: TextAlign.center,),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(height: 1, decoration: BoxDecoration(color: CustomThemeMode.currentThemeData.value.primaryColor),);
                },
              );
            }else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            return Center(child: Text("로딩중..."));
          },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

