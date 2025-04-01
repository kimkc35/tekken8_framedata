import 'dart:convert';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:flutter_radar_chart/flutter_radar_chart.dart';
//import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekken8_framedata/character_variables.dart';
import 'package:tekken8_framedata/main.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'ad_manager.dart';
import 'modules.dart';

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

final BannerAd _banner = loadBannerAd()..load();

class ProfilePage extends StatefulWidget {
  final PlayerInfo playerInfo;
  const ProfilePage({super.key, required this.playerInfo});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{

  late final TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    if(!isPro) interstitialAd?.show();
    tabController = TabController(length: 2, vsync: this);
  }

  final isBookmarkedNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    isBookmarkedNotifier.value = bookmarkedList.contains(widget.playerInfo);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(preferredSize: Size(0, 50), child: TabBar(controller: tabController, tabs: [Tab(text: "profile.tab1".tr(),), Tab(text: "profile.tab2".tr(),)],)),
        title: Row(children: [
          Text(widget.playerInfo.name),
          SizedBox(width: 5,),
          GestureDetector(
            child: ValueListenableBuilder(
            valueListenable: isBookmarkedNotifier,
              builder: (context, value, child){
                return Icon(isBookmarkedNotifier.value? Icons.star : Icons.star_border, size: 24,);
              },
            ),
            onTap: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
                isBookmarkedNotifier.value? bookmarkedList.remove(widget.playerInfo) : bookmarkedList.add(widget.playerInfo);
                isBookmarkedNotifier.value = bookmarkedList.contains(widget.playerInfo);
                final List<String> playerInfoList = [];
                for(PlayerInfo bookmarked in bookmarkedList){
                  playerInfoList.add(jsonEncode(bookmarked.toJson()));
                }
                prefs.setStringList('bookmarkedList', playerInfoList);
            },
          )
        ]),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: TabBarView(controller: tabController, children: [ProfileTab(playerInfo: widget.playerInfo) ,HistoryTab(playerInfo: widget.playerInfo)]),
      bottomNavigationBar: !isPro ? Container(
        color: Colors.black,
        width: _banner.size.width.toDouble(),
        height: _banner.size.height.toDouble(),
        child: AdWidget(ad: _banner,),
      ) : null
    );
  }
}

class ProfileTab extends StatefulWidget {
  final PlayerInfo playerInfo;
  const ProfileTab({super.key, required this.playerInfo});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  Future<PlayerProfile> details()async{
    List<CharacterWinRate> characterWinRateList = [];

    final uri = Uri.https('kekken.com', '/@${widget.playerInfo.polarisId.replaceAll("-", "")}');
    final response = await http.get(uri);
    dom.Document document = parser.parse(response.body);
    final infoList = document.querySelector("div[class='grid grid-cols-6 justify-items-stretch font-medium text-gray-600 divide-y md:divide-y-0 md:divide-x divide-gray-100 border-y border-gray-100 text-center']")!.querySelectorAll("div");
    RegExp regExp = RegExp(r'^[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}$');
    final polarisId = regExp.hasMatch(widget.playerInfo.polarisId) ? widget.playerInfo.polarisId : infoList[0].querySelectorAll('p').last.text.replaceAll('\n', '').trim();
    final winRate = infoList[1].querySelectorAll("p").last.text.replaceAll("\n", "").trim();
    final prowess = infoList[2].querySelectorAll("p").last.text;

    // for (var stat in statList) {
    //   int totalValue = 0;
    //   String statName = stat.querySelector('h2[class=\'text-lg font-semibold mb-2 px-3 py-2\']')!.text.toLowerCase();
    //   final statValues = stat.querySelectorAll('span[class=\'text-gray-300 font-bold\']');
    //   final List<String> valueList = [];
    //   for (var value in statValues){
    //     valueList.add(value.text);
    //     totalValue += int.parse(value.text);
    //   }
    //   statMap.addAll({
    //     statName : valueList
    //   });
    //   statMap[statName]?.insert(0, totalValue.toString());
    // }
    final isBookmarked = bookmarkedList.contains(widget.playerInfo);

    document.querySelectorAll("table[class='min-w-full divide-y divide-gray-200'] > tbody > tr").forEach((element) {
      final info = element.querySelectorAll('td');
      final charImgUrl = "https://kekken.com${info[0].querySelector('a > img')!.attributes['src']!}";
      final char = info[0].querySelector('a > img')!.attributes['alt']!;
      final matches = info[1].text;
      final winRate = info[2].text.replaceAll("\n", "").trim();
      final rankImgUrl = "https://kekken.com${info[3].querySelector('img')!.attributes['src']!}";

      characterWinRateList.add(CharacterWinRate(charImgUrl: charImgUrl, char: char, matches: matches, winRate: winRate, rankImgUrl: rankImgUrl));
    });

    PlayerProfile playerDetails = PlayerProfile(polarisId: polarisId, winRate: winRate,prowess: prowess, isVerified: widget.playerInfo.isVerified, isBookmarked: isBookmarked, characterWinRateList: characterWinRateList);

    return playerDetails;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(future: details(), builder: (context, snapshot) {
      if(snapshot.hasData){
        final data = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("profile.polarisId").tr(),
                        SizedBox(height: 10,),
                        Text(data.polarisId, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("profile.winRate").tr(),
                        SizedBox(height: 10,),
                        Text(data.winRate, style: TextStyle(fontSize: 15, color: double.parse(data.winRate.replaceAll("%", "")) >= 50 ? Colors.green : Colors.red)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("profile.prowess").tr(),
                        SizedBox(height: 10,),
                        Text(data.prowess, style: TextStyle(fontSize: 15),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft ,child: Text("profile.characters", style: TextStyle(fontSize: 25)).tr()),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(color:Color(0xFFE6E6E6), border: Border.symmetric(horizontal: BorderSide(color: Color(0xffD8D8D8)))),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex:3, child: Text("profile.character", textAlign: TextAlign.center).tr()),
                    Expanded(flex:2, child: Text("profile.matches", textAlign: TextAlign.center).tr()),
                    Expanded(flex:2, child: Text("profile.winRate", textAlign: TextAlign.center).tr()),
                    Expanded(flex:2, child: Text("profile.rank", textAlign: TextAlign.center).tr())
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (c, i) {
                      final currentChar = data.characterWinRateList[i];
                      return SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:3,
                              child: Row(
                                children: [
                                  SizedBox(width:40, height:40, child: Image.network(currentChar.charImgUrl, alignment: Alignment.center,)),
                                  SizedBox(width:80, child: Text(currentChar.char, textAlign: TextAlign.center)),
                                ],
                              ),
                            ),
                            Expanded(flex:2, child: Text(currentChar.matches, textAlign: TextAlign.center)),
                            Expanded(flex:2, child: Text(currentChar.winRate, textAlign: TextAlign.center ,style: TextStyle(color: double.parse(currentChar.winRate.replaceAll("%", "")) >= 50 ? Colors.green : Colors.red))),
                            Expanded(flex:2, child: Image.network(currentChar.rankImgUrl, alignment: Alignment.center,))
                          ]
                        ),
                      );
                    },
                    separatorBuilder: (context, i) => Container(),
                    itemCount: data.characterWinRateList.length
                ),
              )
            ]
          ),
        );
      }else if(snapshot.hasError){
        return Center(child: Text("Error! ${snapshot.error}"));
      }
      return Center(child: Text("tip.loading").tr());
    });
    // return FutureBuilder(
    //     future: details(),
    //     builder: (context, snapshot) {
    //       statBar({required String title, required String name, required int index}){
    //         return Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             SizedBox(width: 120, child: Text(name)),
    //             SizedBox(width: 30, child: Text(snapshot.data!.stats[title]![index])),
    //             Expanded(
    //               child: LinearPercentIndicator(
    //                 lineHeight: 10,
    //                 percent: int.parse(snapshot.data!.stats[title]![index]) / 25,
    //                 backgroundColor: Colors.grey,
    //                 linearGradient: LinearGradient(
    //                     begin: Alignment(-1, 0),
    //                     end: Alignment(1, 0),
    //                     colors: [Color(0xFF770033), Color(0xFFff0022)]
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       }
    //
    //       expansionTile(String title, List<String> statNames){
    //         return ExpansionTile(
    //           title: Text("${statNames[0]} : ${snapshot.data!.stats[title]![0]}"),
    //           children: [
    //             statBar(name: statNames[1], index: 1, title: title),
    //             statBar(name: statNames[2], index: 2, title: title),
    //             statBar(name: statNames[3], index: 3, title: title),
    //             statBar(name: statNames[4], index: 4, title: title)
    //           ],
    //         );
    //       }
    //
    //       if(snapshot.hasData){
    //         final totalValues = [int.parse(snapshot.data!.stats["attack"]![0]), int.parse(snapshot.data!.stats["technique"]![0]), int.parse(snapshot.data!.stats["appeal"]![0]), int.parse(snapshot.data!.stats["spirit"]![0]), int.parse(snapshot.data!.stats["defense"]![0])];
    //
    //         return SingleChildScrollView(
    //           child: Padding(
    //             padding: const EdgeInsets.all(10.0),
    //             child: Column(
    //                 children: [
    //                   SizedBox(
    //                     height: 50,
    //                     child: Row(
    //                       children: [
    //                         Image.network(snapshot.data!.imgUrl),
    //                         SizedBox(width: 10,),
    //                         Column(
    //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text("철권력 : ${snapshot.data!.prowess}"),
    //                             Text("랭크 포인트 : ${snapshot.data!.rankPoint}")
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                   expansionTile("attack", ["공격", "타수", "큰 대미지", "적극성", "압도"]),
    //                   expansionTile("defense", ["수비", "가드", "회피", "잡기 풀기", "냉정"]),
    //                   expansionTile("technique", ["기술", "정밀도", "판단력", "받아치기", "스테이지 활용"]),
    //                   expansionTile("spirit", ["정신", "접전", "역경", "투지", "집중력"]),
    //                   expansionTile("appeal", ["매력", "경의", "향상심", "정정당당", "다채로움"]),
    //                   SizedBox(
    //                     height: 450,
    //                     child: RadarChart(
    //                         ticks: [0, 25, 50, 75, 100],
    //                         features: ["공격 ${totalValues[0]}\n", "기술 ${totalValues[1]}", "매력 ${totalValues[2]}", "정신 ${totalValues[3]}", "수비 ${totalValues[4]}"],
    //                         data: [totalValues],
    //                         graphColors: [CustomThemeMode.currentThemeData.value.primaryColor],
    //                         ticksTextStyle: TextStyle(color: Colors.transparent, fontSize: 12),
    //                         featuresTextStyle: TextStyle(color: CustomThemeMode.currentThemeData.value.primaryColor, fontSize: 15),
    //                         sides: 5
    //                     ),
    //                   )
    //                 ]
    //             ),
    //           ),
    //         );
    //       }else if(snapshot.hasError){
    //         return Text(snapshot.error.toString());
    //       }
    //       return Center(child: Text("로딩중..."));
    //     }
    // );
  }
}

// class CharacterTab extends StatefulWidget {
//   final PlayerInfo playerInfo;
//   const CharacterTab({super.key, required this.playerInfo});
//
//   @override
//   State<CharacterTab> createState() => _CharacterTabState();
// }
//
// class _CharacterTabState extends State<CharacterTab> with AutomaticKeepAliveClientMixin{
//
//   Future<List<CharacterWinRate>> searchProfile()async {
//     Map<String, Map<String, int>> winRateList = {};
//     List<CharacterWinRate> characterWinRateList = [];
//
//     const baseUrl = "https://wank.wavu.wiki/player/";
//     final url = "$baseUrl${widget.playerInfo.polarisId.replaceAll('-', '')}";
//     final parse = Uri.parse(url);
//     final response = await http.get(parse);
//     dom.Document document = parser.parse(response.body);
//     final matches = document.querySelector('div[style="overflow-x: auto;"] > table > tbody')!.querySelectorAll('tr');
//
//     for(var match in matches){
//       final character = match.querySelectorAll('td')[5].text;
//       final result = match.querySelectorAll('td')[2].text.contains('WIN') ? 'win' : 'lose';
//       if(result == 'win'){
//         if(winRateList[character] == null) {
//           winRateList.addAll({character: {
//             "timeFaced": 1,
//             "timeWin": 1,
//             "timeLose": 0
//           }});
//         }else{
//           winRateList[character]!["timeWin"] = winRateList[character]!["timeWin"]! + 1;
//           winRateList[character]!["timeFaced"] =  winRateList[character]!["timeFaced"]! + 1;
//         }
//       }else{
//         if(winRateList[character] == null) {
//           winRateList.addAll({character: {
//             "timeFaced": 1,
//             "timeWin": 0,
//             "timeLose": 1
//           }});
//         }else{
//           winRateList[character]!["timeLose"] = winRateList[character]!["timeLose"]! + 1;
//           winRateList[character]!["timeFaced"] =  winRateList[character]!["timeFaced"]! + 1;
//         }
//       }
//     }
//
//     for(var character in winRateList.entries){
//       characterWinRateList.add(
//           CharacterWinRate(oppChar: character.key, timeFaced: character.value["timeFaced"].toString(), timeWin: character.value["timeWin"].toString(), timeLose: character.value["timeLose"].toString(), winRate: (character.value["timeWin"]!/character.value["timeFaced"]! * 100).toStringAsFixed(2))
//       );
//     }
//
//     return characterWinRateList;
//   }
//
//   final TextStyle headingStyle = TextStyle(fontWeight: FontWeight.bold);
//
//   String sort = 'winRate';
//   bool reverseSort = false;
//
//   sortData(List<CharacterWinRate> data, String sortStandard){
//     switch(sortStandard){
//       case('oppChar'):
//         data.sort((a, b) => a.oppChar.compareTo(b.oppChar));
//       case('timeFaced'):
//         data.sort((a, b) => (double.parse(a.timeFaced).ceil() - double.parse(b.timeFaced).ceil()));
//       case('timeWin'):
//         data.sort((a, b) => (double.parse(a.timeWin).ceil() - double.parse(b.timeWin).ceil()));
//       case('timeLose'):
//         data.sort((a, b) => (double.parse(a.timeLose).ceil() - double.parse(b.timeLose).ceil()));
//       case('winRate'):
//         data.sort((a, b) => (double.parse(a.winRate).ceil() - double.parse(b.winRate).ceil()));
//     }
//
//     if(reverseSort){
//       return data;
//     }
//     return List.from(data.reversed);
//   }
//
//   Widget headingBox(double width, String name, String sortStandard){
//     return SizedBox(width: width, child: TextButton(
//       onPressed: (){
//         super.setState(() {
//           sort = sortStandard;
//           if(sort == sortStandard){
//             if(reverseSort){
//               reverseSort = false;
//             }else{
//               reverseSort = true;
//             }
//           }else{
//             reverseSort = false;
//           }
//         });
//       },
//       child: Text(name, textAlign: TextAlign.center, style: headingStyle,),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Padding(
//         padding: EdgeInsets.all(10),
//         child: FutureBuilder(
//           future: searchProfile(),
//           builder: (context, snapshot) {
//             if(snapshot.hasData){
//               final data = sortData(snapshot.data!, sort);
//               debugPrint("현재 상태 : $sort");
//               return Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       headingBox(70, "상대 \n캐릭터", "oppChar"),
//                       headingBox(80, "만난 횟수", "timeFaced"),
//                       headingBox(40, "승", "timeWin"),
//                       headingBox(40, "패", "timeLose"),
//                       headingBox(70, "승률", "winRate"),
//                     ],
//                   ),
//                   SizedBox(height: 5,),
//                   Container(height: 1, color: CustomThemeMode.currentThemeData.value.primaryColor,),
//                   SizedBox(height: 4,),
//                   Expanded(
//                     child: ListView.separated(
//                         itemBuilder: (context, index) {
//                           return SizedBox(
//                             height: 70,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 SizedBox(width: 70, child: Text(data[index].oppChar, textAlign: TextAlign.center)),
//                                 SizedBox(width: 80, child: Text(data[index].timeFaced, textAlign: TextAlign.center)),
//                                 SizedBox(width: 40, child: Text(data[index].timeWin, textAlign: TextAlign.center)),
//                                 SizedBox(width: 40, child: Text(data[index].timeLose, textAlign: TextAlign.center)),
//                                 SizedBox(width: 70, child: Text("${data[index].winRate}%", textAlign: TextAlign.center)),
//                               ],
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) => Container(height: 1, decoration: BoxDecoration(color: CustomThemeMode.currentThemeData.value.primaryColor),),
//                         itemCount: snapshot.data!.length),
//                   ),
//                 ],
//               );
//             }else if(snapshot.hasError){
//               return Center(child: Text(snapshot.error.toString()));
//             }
//             return Center(child: Text("로딩중..."));
//         },),
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }

// class HistoryTab extends StatefulWidget {
//   final PlayerInfo playerInfo;
//   const HistoryTab({super.key, required this.playerInfo});
//
//   @override
//   State<HistoryTab> createState() => _HistoryTabState();
// }
//
// class _HistoryTabState extends State<HistoryTab> with AutomaticKeepAliveClientMixin{
//
//   convertDate(String date){
//     final String currentDate = date.replaceAll("Jan", "01")
//         .replaceAll("Feb", "02 ")
//         .replaceAll("Mar", "03 ")
//         .replaceAll("Apr", "04 ")
//         .replaceAll("May", "05 ")
//         .replaceAll("Jun", "06 ")
//         .replaceAll("Jul", "07 ")
//         .replaceAll("Aug", "08 ")
//         .replaceAll("Sep", "09 ")
//         .replaceAll("Oct", "10 ")
//         .replaceAll("Nov", "11 ")
//         .replaceAll("Dec", "12 ");
//
//     final String forward = currentDate.split(",")[0], backward = currentDate.split(",")[1];
//     final int month = int.parse(forward.split(" ")[0]), day = int.parse(forward.split(" ")[1]);
//     final int year = int.parse(backward.split('@')[0]);
//     final String time = backward.split('@')[1];
//     final int hour = int.parse(time.split(':')[0]), minute = int.parse(time.split(':')[1]);
//
//     final convertedDate = DateFormat("yyyy년 MM월 dd일 k:mm").format(DateTime(year, month, day, hour, minute).add(Duration(hours: 9)));
//
//     return convertedDate;
//   }
//
//   String convertScore(String score){
//     final currentScore = score.replaceAll("\n", "").replaceAll(" ", "");
//     return currentScore.replaceFirstMapped(RegExp(r'(\d)([A-Za-z])'), (Match m) => '${m[1]}\n${m[2]}');
//   }
//
//   Future<List<PlayHistory>> historyFuture()async{
//     List<PlayHistory> historyList = [];
//
//     final uri = Uri.https('kekken.com', '/@${widget.playerInfo.polarisId.replaceAll("-", "")}');
//     final response = await http.get(uri);
//     final dom.Document document = parser.parse(response.body);
//     final characterList = document.querySelector("div[class='rounded-lg overflow-hidden']")?.nextElementSibling?.nextElementSibling?.querySelectorAll("tr[class='border border-zinc-800 hover:bg-zinc-800/75']");
//
//     for (var element in characterList!) {
//       final date = convertDate(element.querySelector("td[class='px-4 py-2']")!.text.replaceAll(' ', '').replaceAll('\n', ''));
//       final list = element.querySelectorAll("td[class=p-3]");
//
//       historyList.add(
//         PlayHistory(player: widget.playerInfo.name, date: date, playerChar: list[0].text, oppName: list[1].text.replaceAll("\n", "").replaceAll(" ", ""), oppChar: list[2].text, score: convertScore(list[3].text), type: list[4].text.replaceAll("Ranked", "랭크 매치").replaceAll("Quick", "퀵 매치").replaceAll("Player", "플레이어 매치"))
//       );
//     }
//
//     return historyList;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: FutureBuilder(
//           future: historyFuture(),
//           builder: (context, snapshot) {
//             if(snapshot.hasData){
//               final data = snapshot.data!;
//               return ListView.separated(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return SizedBox(
//                     height: 150,
//                     child: Stack(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image(image: CachedNetworkImageProvider(characterImageUrls[data[index].playerChar.toLowerCase()] ?? "")),
//                             Transform(alignment: Alignment.center,transform: Matrix4.rotationY(math.pi),child: Image(image: CachedNetworkImageProvider(characterImageUrls[data[index].oppChar.toLowerCase()] ?? ""))),
//                           ],
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Align(alignment: Alignment.centerLeft, child: Text(data[index].date, textAlign: TextAlign.start,)),
//                             Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(width: 100, child: Text("${data[index].player}\n${data[index].playerChar}", textAlign: TextAlign.center, style: TextStyle(height: 1.8),)),
//                                   SizedBox(width: 80, child: Text(data[index].score, textAlign: TextAlign.center,)),
//                                   SizedBox(width: 100, child: Text("${data[index].oppName}\n${data[index].oppChar}", textAlign: TextAlign.center, style: TextStyle(height: 1.8),)),
//                                 ]
//                             ),
//                             Text(data[index].type, textAlign: TextAlign.center,),
//                           ],
//                         )
//                       ],
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return Container(height: 1, decoration: BoxDecoration(color: CustomThemeMode.currentThemeData.value.primaryColor),);
//                 },
//               );
//             }else if(snapshot.hasError){
//               return Text(snapshot.error.toString());
//             }
//             return Center(child: Text("tip.loading".tr()));
//           },
//       ),
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }

class HistoryTab extends StatefulWidget {
  final PlayerInfo playerInfo;
  const HistoryTab({super.key, required this.playerInfo});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with AutomaticKeepAliveClientMixin{

  int currentPage = 1;
  int? lastPage;

  Future<List<MatchHistory>> getMatchHistory()async{
    List<MatchHistory> matchHistoryList = [];

    final uri = Uri.https('kekken.com', '/@${widget.playerInfo.polarisId.replaceAll("-", "")}', {"page": currentPage.toString()});
    debugPrint("uri : $uri");
    final response = await http.get(uri);
    final dom.Document document = parser.parse(response.body);
    lastPage = int.parse(document.querySelectorAll('nav[class="pagination"] > a').last.text);
    final pageMatchHistoryList = document.querySelectorAll("table[class='min-w-full mb-8 divide-y divide-gray-200'] > tbody > tr");

    for (var matchHistory in pageMatchHistoryList) {
      final info = matchHistory.querySelectorAll("td");

      final dateString = info[0].querySelectorAll("span").last.attributes["title"]!;
      List<int> dateList = dateString.split(RegExp(r'[- :]+')).map((e) => int.parse(e)).toList();
      final date = DateTime(dateList[0], dateList[1], dateList[2], dateList[3], dateList[4]);

      final stage = info[1].text.replaceAll("\n", "".trim());

      final outcomeInfo = info[2].querySelectorAll('div > div');

      final player = outcomeInfo[0].querySelector('a')!.text;
      final playerChar = outcomeInfo[0].querySelectorAll('a').last.attributes['href']!.replaceAll("/", "");
      final playerCharImgUrl = "https://kekken.com${outcomeInfo[0].querySelectorAll('a').last.querySelector('img')!.attributes['src']!}";

      final outcome = outcomeInfo[1].text.replaceAll("\n", '').trim();

      final oppName = outcomeInfo[2].querySelectorAll('a').last.text;
      final oppChar = outcomeInfo[2].querySelector('a')!.attributes['href']!.replaceAll("/", "");
      final oppPolarisId = outcomeInfo[2].querySelectorAll('a').last.attributes['href']!.replaceAll('/@', '');
      final oppCharImgUrl = "https://kekken.com${outcomeInfo[2].querySelector('a > img')!.attributes['src']!}";

      matchHistoryList.add(
          MatchHistory(date: date, stage: stage, player: player, playerChar: playerChar, playerCharImgUrl: playerCharImgUrl, oppName: oppName, oppChar: oppChar, oppPolarisId: oppPolarisId, oppCharImgUrl: oppCharImgUrl, outcome: outcome)
      );
    }

    return matchHistoryList;
  }

  bool isWin(String input) {
    RegExp regExp = RegExp(r'(\d+)\s*-\s*(\d+)');
    Match? match = regExp.firstMatch(input);
    if (match != null) {
      int num1 = int.parse(match.group(1)!);
      int num2 = int.parse(match.group(2)!);
      return num1 >= num2;
    } else {
      throw ArgumentError('Input does not match the required format');
    }
  }

  Widget outLinedText(String string, Color innerColor, Color outerColor){
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          string,
          style: TextStyle(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = outerColor,
          ),
        ),
        // Solid text as fill.
        Text(
          string,
          style: TextStyle(
            color: innerColor,
          ),
        ),
      ],
    );
  }

  final TextEditingController pageTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(!isPro) interstitialAd?.show();
    return Padding(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(
        future: getMatchHistory(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              final data = snapshot.data!;
              return Stack(
                children: [
                  ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 150,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image(image: CachedNetworkImageProvider(characterImageUrls[data[index].playerChar.toLowerCase()] ?? data[index].playerChar, errorListener: (o) => debugPrint("이미지 오류 : $o}"))),
                                Transform(alignment: Alignment.center,transform: Matrix4.rotationY(math.pi),child: Image(image: CachedNetworkImageProvider(characterImageUrls[data[index].oppChar.toLowerCase()] ?? ""))),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(alignment: Alignment.centerLeft, child: Text(context.locale.languageCode == "en" ? DateFormat('yyyy-MM-dd HH:mm').format(data[index].date) : DateFormat('yyyy-MM-dd HH:mm').format(data[index].date.add(Duration(hours: 9))), textAlign: TextAlign.start,)),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(flex: 3, child: SizedBox()),
                                            Expanded(flex: 5, child: Align(alignment: Alignment.centerRight, child: outLinedText(data[index].player, Colors.black, CustomThemeMode.currentThemeData.value.canvasColor)),),
                                            Expanded(flex: 4, child: Text(data[index].outcome, textAlign: TextAlign.center, style: TextStyle(color: isWin(data[index].outcome) ? Colors.green : Colors.red))),
                                            Expanded(flex: 5, child:
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(playerInfo: PlayerInfo(polarisId: data[index].oppPolarisId, name: data[index].oppName, isVerified: false))));
                                              },
                                              child: Align(alignment: Alignment.centerLeft, child: outLinedText(data[index].oppName, CustomThemeMode.currentThemeData.value.primaryColor, CustomThemeMode.currentThemeData.value.canvasColor)),
                                            )
                                            ),
                                            Expanded(flex: 3, child: SizedBox()),
                                          ]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: 1, decoration: BoxDecoration(color: CustomThemeMode.currentThemeData.value.primaryColor),);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(onPressed: (){
                      setState(() {
                        currentPage > 1 ?currentPage--
                            : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("profile.firstPageError").tr(),
                            )
                        );
                      });
                      }, icon: Icon(Icons.arrow_circle_left, size: 34, color: CustomThemeMode.currentThemeData.value.primaryColor,)),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      width: 80,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "profile.matchHistory.hintText".tr()
                        ),
                        style: TextStyle(
                          fontSize: 12
                        ),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RangeTextInputFormatter(min:1, max:lastPage!)
                        ],
                        controller: pageTextEditingController,
                        onEditingComplete: () {
                          setState(() {
                            currentPage = int.parse(pageTextEditingController.text);
                            pageTextEditingController.text = "";
                          });
                        },
                      ),
                    )
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(onPressed: (){
                        setState(() {
                          currentPage < lastPage! ?currentPage++
                              : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("profile.lastPageError").tr(),
                              )
                          );
                        });
                      }, icon: Icon(Icons.arrow_circle_right_rounded, size: 34, color: CustomThemeMode.currentThemeData.value.primaryColor),)
                  )
                ],
              );
            }else{
              return Text(snapshot.error.toString());
            }
          }
          return Center(child: Text("tip.loading".tr()));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final int value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(
        text: min.toString(),
        selection: TextSelection.collapsed(offset: min.toString().length),
      );
    } else if (value > max) {
      return TextEditingValue(
        text: max.toString(),
        selection: TextSelection.collapsed(offset: max.toString().length),
      );
    }
    return newValue;
  }
}
