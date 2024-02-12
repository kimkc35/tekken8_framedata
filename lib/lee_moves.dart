import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'default_heat_system.dart';
import 'dart:async';
import 'main.dart' as main;
import 'package:string_validator/string_validator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const double listWidth = 35;

final BannerAd _banner = BannerAd(
    adUnitId: 'ca-app-pub-3256415400287290/4169383092',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    )
)..load();

//변경해야될것 : 리스트, 캐릭터, 타입, 히트 시스템, 레이지아츠

//레이지 아츠
final List rageArts = ["The Marvelous Rose", "레이지 상태에서 ${main.sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n혹은 레이지 상태에서 Hitman 도중 ${main.sticks["c3"]}AP\n히트 시 상대의 회복 가능 게이지를 없앰"];

//paul extra list
List<Map<String, String>> extraInitials = [ //변경해야될것,
  {"name" : "guardDamage", "guardDamage" : "가드 대미지"},
  {"name" : "powerCrash", "powerCrash" : "파워 크래시"},
  {"name" : "tornado", "tornado" : "토네이도"},
  {"name" : "homing", "homing" : "호밍기"},
  {"name" : "charge", "charge" : "효과 지속 중에는 가드할 수 없음\n자동 카운터 히트"},
  {"name" : "heatJust", "heatJust" : "히트 상태 지속 중에는 저스트 입력 불필요(히트 상태의 남은 시간을 소비,저스트 성공으로 남은 시간 회복)"},
  {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
];

List<String> heatSystem = ["저스트 입력이 아니더라도 저스트 입력 기술 사용 가능", "저스트 입력 성공 시, 히트 상태의 남은 시간 회복"];

const character = "lee"; //변경해야될것

List moveFiles = [
  "move_names", "move_commands", "move_start_frames", "move_guard_frames", "move_hit_frames", "move_counter_frames", "move_ranges", "move_damages", "move_extras"
];

List throwFiles = [
  "throw_names", "throw_commands", "throw_start_frames", "throw_break_commands", "throw_after_break_frames", "throw_damages", "throw_ranges", "throw_extras"
];

List types = [ //변경해야될것
  {"heat" : true}, {"general" : true}, {"sit" : true}, {"mist step" : true}, {"hitman" : true}
];

Map<String, String> typesKo = {
  "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "mist step" : "미스트 스텝", "hitman" : "히트맨"
};

bool heatSystemMenu = true;

String _searchText = "";

final TextEditingController _searchController = TextEditingController();

class GetContents { // 리스트 구성

  Future _loadFile(fileName) async {
    return await rootBundle.loadString("assets/$character/$fileName.txt");
  }

  Future<List> _loadList(fileName) async {
    final String text = await _loadFile(fileName);
    return text.split(" | ");
  }

  Future<List> getMoveList() async {
    var list = [];
    var temp;
    for(int j = 0; j < types.length; j++) {
      list.addAll(
          {
            {
              "type": types[j].keys.firstWhere(
                      (k) => types[j][k] == true || types[j][k] == false),
              "contents": []
            }
          }
      );
      for (int i = 0; i < moveFiles.length; i++) {
        await _loadList(moveFiles[i]).then((value) =>
        {
          print("$character, ${moveFiles[i]}, ${types[j]} : ${value[j].toString().split(", ").length}"), //디버그
          for(int k = 0; k < value[j].toString().replaceAll("${types[j].keys.firstWhere((k) => types[j][k] == true || types[j][k] == false)} : ", "").split(", ").length; k++){
            if (i == 0){
              list[j]["contents"].add([(value[j].toString().replaceAll("${types[j].keys.firstWhere((k) => types[j][k] == true || types[j][k] == false)} : ", "").split(", ")[k])]),
            }else if (i == 1 || i == 8){
              temp = value[j],
              for (int l = 1; l < 10; l++)
                temp = temp.toString().replaceAll("$l ", "${main.sticks["c$l"]}").replaceAll("${types[j].keys.firstWhere((k) => types[j][k] == true || types[j][k] == false)} : ", ""),
              if (i == 8){
                for (int l = 0; l < extraInitials.length; l++)
                  temp = temp.toString().replaceAll(extraInitials[l]["name"].toString(), extraInitials[l][extraInitials[l]["name"]].toString()),
                temp = temp.toString().replaceAll("/", "\n"),
                temp = temp.toString().replaceAll("-", "")
              },
              list[j]["contents"][k].add(temp.split(", ")[k]),
            }else{
              list[j]["contents"][k].add(value[j].toString().replaceAll("${types[j].keys.firstWhere((k) => types[j][k] == true || types[j][k] == false)} : ", "").split(", ")[k]),
            },
          }
        });
      }
    }
    return list;
  }

  Future<List> getThrowList() async {
    List<List<String>> throwList = [];
    for (int i = 0; i < throwFiles.length; i++){
      String value = await _loadFile(throwFiles[i]);
      List valueToList = value.split(", ");
      print("잡기 ${throwFiles[i]} : ${valueToList.length}"); //디버그
      List temp = List.from(valueToList);
      for (int l = 1; l < 10; l++) {
        temp = temp
            .toString()
            .replaceAll("$l ", "${main.sticks["c$l"]}").replaceAll("[", "").replaceAll("]", "").split(", ");
      }
      for (int j = 0; j < valueToList.length; j++){
        if (i == 0){
          throwList.addAll([[temp[j]]]);
        }else{
          throwList[j].add(temp[j]);
        }
      }
    }
    return throwList;
  }
}



//변경해야될것
class LEE extends StatefulWidget {

  final moves, throws;

  const LEE({super.key, required this.moves, required this.throws});

  @override
  State<LEE> createState() => _LEEState();
}

class _LEEState extends State<LEE> {

  final themeData = ThemeData(
      buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      fontFamily: 'Tenada',
      useMaterial3: false,
      primarySwatch: Colors.pink
  );

  //키보드 버튼 제작 함수
  Widget keyboardButton(String content, {String inputText = ""}){
    if(content == "delete"){
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 40,
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                _searchController.text = _searchController.text.substring(0, _searchController.text.length - 1);
                _searchText = _searchController.text;
              });
            }, child: Icon(CupertinoIcons.arrow_left_to_line, size: 20, color: Colors.white,), ),
          ),
        ),
      );
    }else if(inputText != ""){
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 40,
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                _searchController.text = _searchController.text + inputText;
                _searchText = _searchController.text;
              });
            }, child: Text(content, style: TextStyle(color: Colors.white, fontSize: main.keyboardFontSize),)),
          ),
        ),
      );
    }else if(content == "AC"){
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 40,
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                _searchController.text = "";
                _searchText = _searchController.text;
              });
            }, child: Text(content, style: TextStyle(color: Colors.white, fontSize: main.keyboardFontSize),)),
          ),
        ),
      );
    }
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 40,
          child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
            setState(() {
              _searchController.text = _searchController.text + content;
              _searchText = _searchController.text;
            });
          }, child: Text(content, style: TextStyle(color: Colors.white, fontSize: main.keyboardFontSize),)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        _searchText = "";
        _searchController.text = "";
      },
      child: MaterialApp(
          theme: themeData,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(character.toUpperCase()),
                  centerTitle: true,
                  leadingWidth: 80,
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: (
                        ButtonBar(
                          children: [
                            Text("FRAME\nDATA")
                          ],
                        )
                    ),
                  ),
                  actionsIconTheme: IconThemeData(size: 40),
                  actions: [
                    GestureDetector(
                      onTap: () => showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(title: Text("설명", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: TextStyle(fontFamily: "Tenada", height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: TextStyle(fontFamily: "Tenada", color: Colors.black),
                        content: Text(main.description),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('닫기'))
                        ],
                      )),
                      child: Icon(Icons.abc),
                    ),
                    GestureDetector(
                      onTap: () => showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(title: Text("1.01.04V 패치노트", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: TextStyle(fontFamily: "Tenada", height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: TextStyle(fontFamily: "Tenada", color: Colors.black),
                        content: SingleChildScrollView(child: Text(main.patchNote)),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('닫기'))
                        ],
                      )),
                      child: Icon(Icons.article),
                    ),
                  ],
                  backgroundColor: Colors.black,
                  bottom: PreferredSize(
                    preferredSize: Size(0, 100),
                    child: Column(
                      children: [
                        TabBar(
                          automaticIndicatorColorAdjustment: true,
                          isScrollable: false,
                          tabs: [
                            Tab(text: "Move List"),
                            Tab(text: "Throw")
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0), //검색기능
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(controller: _searchController, decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white), label: Text("검색"), border: OutlineInputBorder()
                                ), style: TextStyle(color: Colors.white), onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(), onChanged: (value) {
                                  setState((){
                                    _searchText = _searchController.text;
                                  });
                                },),
                              ),
                              //키보드
                              IconButton(onPressed: (){
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Theme(
                                      data: themeData,
                                      child: Container(
                                        height: 288,
                                        color: Colors.black,
                                        child: Center(
                                            child: Column(
                                              children: [
                                                Row( //1번째 줄
                                                  children: [
                                                    keyboardButton("↖"),
                                                    keyboardButton("↑"),
                                                    keyboardButton("↗"),
                                                    keyboardButton("LP"),
                                                    keyboardButton("RP"),
                                                    keyboardButton("AP"),
                                                    keyboardButton("delete"),
                                                  ],
                                                ),
                                                Row( //2번째 줄
                                                  children: [
                                                    keyboardButton("←"),
                                                    keyboardButton("N"),
                                                    keyboardButton("→"),
                                                    keyboardButton("LK"),
                                                    keyboardButton("RK"),
                                                    keyboardButton("AK"),
                                                    keyboardButton("토네\n이도", inputText: "토네이도"),
                                                  ],
                                                ),
                                                Row( //3번째 줄
                                                  children: [
                                                    keyboardButton("↙"),
                                                    keyboardButton("↓"),
                                                    keyboardButton("↘"),
                                                    keyboardButton("AL"),
                                                    keyboardButton("AR"),
                                                    keyboardButton("~"),
                                                    keyboardButton("가댐", inputText: "가드 대미지"),
                                                  ],
                                                ),
                                                Row( //4번째 줄
                                                  children: [
                                                    keyboardButton("상단"),
                                                    keyboardButton("중단"),
                                                    keyboardButton("하단"),
                                                    keyboardButton("D"),
                                                    keyboardButton("A"),
                                                    keyboardButton("T"),
                                                    keyboardButton("파크", inputText: "파워 크래시"),
                                                  ],
                                                ),
                                                Row( //5번째 줄
                                                  children: [
                                                    keyboardButton("+"),
                                                    keyboardButton("1"),
                                                    keyboardButton("2"),
                                                    keyboardButton("3"),
                                                    keyboardButton("4"),
                                                    keyboardButton("5"),
                                                    keyboardButton("호밍기"),
                                                  ],
                                                ),
                                                Row( //6번째 줄
                                                  children: [
                                                    keyboardButton("-"),
                                                    keyboardButton("6"),
                                                    keyboardButton("7"),
                                                    keyboardButton("8"),
                                                    keyboardButton("9"),
                                                    keyboardButton("0"),
                                                    keyboardButton("AC"),
                                                  ],
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    );
                                  },
                                );}, icon: Icon(Icons.keyboard_alt_outlined), color: Colors.white, iconSize: 30,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    MoveList(moves: widget.moves),
                    ThrowList(throws: widget.throws)
                  ],
                ),
                bottomNavigationBar: Container(
                  color: Colors.black,
                  width: _banner.size.width.toDouble(),
                  height: _banner.size.height.toDouble(),
                  child: AdWidget(ad: _banner,),
                )
            ),
          )
      ),
    );
  }
}

const TextScaler scale = TextScaler.linear(0.8);
int listLength = 1;

TextStyle commandStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
    commandStylePlus = TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.green),
    commandStyleMinus = TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xff1a74b2)),
    commandStylePunish = TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.red);

//무브 리스트 생성
List<DataCell> createCommand(String name, command, start, guard, hit, counter, range, damage, extra){
  listLength = listLength - 1;
  return [
    DataCell(SizedBox(width: 150, child: Text("$name\n$command", textAlign: TextAlign.center, textScaler: scale, style: commandStyle,))), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(start,textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //발생
    if(guard.contains("+") && guard.contains("-") && guard != "-")...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(guard.contains("-") && guard != "-")...[
      if(isFloat(guard) && int.parse(guard) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(guard.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    if(hit.contains("+") && hit.contains("-") && hit != "-")...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(hit.contains("-") && hit != "-")...[
      if(isFloat(hit) && int.parse(hit) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(hit.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    if(counter.contains("+") && counter.contains("-") && counter != "-")...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(counter.contains("-") && counter != "-")...[
      if(isFloat(counter) && int.parse(counter) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(counter.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    DataCell(SizedBox(width: 30, child: Text(range,textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //판정
    DataCell(SizedBox(width: 50, child: Text(damage,textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //대미지
    DataCell(Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(child: Text(extra,textAlign: TextAlign.start, textScaler: scale, style: commandStyle)),
    )), //비고
  ];
}

const TextStyle headingStyle = TextStyle(color: Colors.black, fontFamily: "Tenada", fontSize: 12);

class MoveList extends StatefulWidget {

  final moves;

  const MoveList({super.key, required this.moves});

  @override
  State<MoveList> createState() => _MoveListState();
}


class _MoveListState extends State<MoveList> {

  var filtered;

  List<Map<String, dynamic>> deepCopyList(List source) {
    return source.map((item) {
      return Map<String, dynamic>.from(item);
    }).toList();
  }

  @override
  void initState() {
    setState(() {
      filtered = deepCopyList(widget.moves);
    });
    super.initState();
  }

  void resetLength(){
    listLength = 1;
  }

  void filter(String text){
    setState(() {
      resetLength();
      filtered = deepCopyList(widget.moves);
      for (int i = 0; i < types.length; i++) {
        if (types[i][filtered[i]["type"]] == true) {
          for (int j = 0; j < filtered[i]["contents"].length; j++) {
            filtered[i]["contents"] = List.from(filtered[i]["contents"].where((item) => item.toString().toLowerCase().contains(text.toLowerCase())).toList());
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if(_searchText.isNotEmpty) {
      filter(_searchText); //필터링
    }else{
      setState(() {
        resetLength();
        filtered = deepCopyList(widget.moves); //초기화
      });
    }

    return ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(onPressed: (){
                setState(() {
                  if(heatSystemMenu == true){
                    heatSystemMenu = false;
                  } else if (heatSystemMenu == false){
                    heatSystemMenu = true;
                  }
                });
              }, child: Text("히트 시스템")),
              if(heatSystemMenu == true) // 히트 시스템 설명
                SizedBox(child: heatSystemContexts(heatSystem)), //변경해야될것
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    headingRowHeight: 50,
                    headingTextStyle: headingStyle,
                    dataRowMaxHeight: double.infinity,
                    dataRowMinHeight: 48,
                    border: TableBorder.symmetric(inside: BorderSide(color: Colors.black)),
                    horizontalMargin: 0,
                    columnSpacing: 10,
                    columns: [
                      DataColumn(label: SizedBox(
                        width: 150,
                        height: 100,
                        child: MenuAnchor( // 커맨드 체크박스
                          alignmentOffset: Offset(20, 0),
                          menuChildren: [
                            for(int i = 0; i < types.length; i++)...[
                              CheckboxMenuButton(value: types[i][types[i].keys.firstWhere((k) => types[i][k] == true || types[i][k] == false)], onChanged: (value) {
                                setState(() {
                                  if (types[i][types[i].keys.firstWhere((k) => types[i][k] == true || types[i][k] == false)] == true){
                                    types[i][types[i].keys.firstWhere((k) => types[i][k] == true || types[i][k] == false)] = false;
                                  }else{
                                    types[i][types[i].keys.firstWhere((k) => types[i][k] == true || types[i][k] == false)] = true;
                                  }
                                });
                              }, closeOnActivate: false, child: Text(typesKo[types[i].keys.firstWhere((k) => types[i][k] == true || types[i][k] == false).toString()]!)),
                            ],
                          ],
                          builder: (BuildContext context, MenuController controller, Widget? child)=> TextButton(onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.arrow_drop_down, color: Colors.black,),
                              Text("기술명\n커맨드", style: headingStyle, textAlign: TextAlign.center,),
                            ],
                          ),),
                        ),
                      )), // 헤딩
                      DataColumn(label: SizedBox(width: 30, child: Text('발생',textAlign: TextAlign.center,))),
                      DataColumn(label: SizedBox(width: listWidth, child: Text('가드',textAlign: TextAlign.center))),
                      DataColumn(label: SizedBox(width: listWidth, child: Text('히트',textAlign: TextAlign.center))),
                      DataColumn(label: SizedBox(width: listWidth, child: Text('카운터',textAlign: TextAlign.center))),
                      DataColumn(label: SizedBox(width: 30, child: Text('판정',textAlign: TextAlign.center))),
                      DataColumn(label: SizedBox(width: 50, child: Text('대미지',textAlign: TextAlign.center))),
                      DataColumn(label: Expanded(child: Text('비고',textAlign: TextAlign.center))),
                    ],
                    rows: [
                      if(_searchText.isEmpty || rageArts.toString().toLowerCase().contains(_searchText.toLowerCase()))
                        DataRow(color: MaterialStateColor.resolveWith((states) => Color(0xffd5d5d5)) ,cells : (createCommand(rageArts[0], rageArts[1], rageArts[2], rageArts[3], rageArts[4], rageArts[5], rageArts[6], rageArts[7], rageArts[8]))), //레이지 아츠
                      for(int i = 0; i < types.length; i++)...[
                        if(types[i][filtered[i]["type"]] == true)...[
                          for(int j = 0; j < filtered[i]["contents"].length; j ++)...[
                            if(listLength % 2 == 1)...[
                              DataRow(cells : (createCommand(filtered[i]["contents"][j][0], filtered[i]["contents"][j][1], filtered[i]["contents"][j][2], filtered[i]["contents"][j][3], filtered[i]["contents"][j][4], filtered[i]["contents"][j][5], filtered[i]["contents"][j][6], filtered[i]["contents"][j][7], filtered[i]["contents"][j][8])), color: MaterialStateColor.resolveWith((states) =>
                                  Color(0xffd5d5d5)))
                            ]else if(listLength % 2 == 0)...[
                              DataRow(cells : (createCommand(filtered[i]["contents"][j][0], filtered[i]["contents"][j][1], filtered[i]["contents"][j][2], filtered[i]["contents"][j][3], filtered[i]["contents"][j][4], filtered[i]["contents"][j][5], filtered[i]["contents"][j][6], filtered[i]["contents"][j][7], filtered[i]["contents"][j][8])))
                            ]
                          ],
                        ],
                      ]
                    ]
                ),
              ),
            ],
          ),
        ]
    );
  }
}

List<DataCell> createThrow(String name, command, start, breakThrow, frameAfterBreak, damage, range, extra){
  return [
    DataCell(SizedBox(width: 150, child: Text("$name\n$command", textAlign: TextAlign.center, textScaler: scale, style: commandStyle,))), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(start, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //발생
    DataCell(SizedBox(width: 40, child: Text(breakThrow, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //풀기
    if(frameAfterBreak.contains("+") && frameAfterBreak.contains("-") && frameAfterBreak != "-")...[ //풀기 후 F
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(frameAfterBreak.contains("-") && frameAfterBreak != "-")...[
      if(isFloat(frameAfterBreak) && int.parse(frameAfterBreak) <= -10)...[
        DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(frameAfterBreak.contains("+"))...[
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    DataCell(SizedBox(width: 50, child: Text(damage, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //대미지
    DataCell(SizedBox(width: 30, child: Text(range, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //판정
    DataCell(Text(extra.toString().replaceAll("-", "").replaceAll("/", "\n"), textAlign: TextAlign.start, textScaler: scale, style: commandStyle)), //비고
  ];
}

class ThrowList extends StatefulWidget {

  final throws;

  const ThrowList({super.key, required this.throws});

  @override
  State<ThrowList> createState() => _ThrowListState();
}

class _ThrowListState extends State<ThrowList>{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 50,
                headingTextStyle: headingStyle,
                dataRowMaxHeight: double.infinity,
                dataRowMinHeight: 48,
                border: TableBorder.symmetric(inside: BorderSide(color: Colors.black)),
                horizontalMargin: 0,
                columnSpacing: 10,
                columns: [
                  DataColumn(label: SizedBox(width: 150,child: Text('기술명\n커맨드',textAlign: TextAlign.center,))),
                  DataColumn(label: SizedBox(width: 30,child: Text('발생',textAlign: TextAlign.center))),
                  DataColumn(label: SizedBox(width: 40,child: Text('풀기',textAlign: TextAlign.center))),
                  DataColumn(label: SizedBox(width: 30,child: Text('풀기\n후 F',textAlign: TextAlign.center))),
                  DataColumn(label: SizedBox(width: 50,child: Text('대미지',textAlign: TextAlign.center))),
                  DataColumn(label: SizedBox(width: 30,child: Text('판정',textAlign: TextAlign.center))),
                  DataColumn(label: Expanded(child: Text('비고',textAlign: TextAlign.center))),
                ],
                rows: [
                  for(int i = 0; i < widget.throws.length; i++)...[
                    if(i % 2 == 0)...[
                      DataRow(cells: createThrow(widget.throws[i][0], widget.throws[i][1], widget.throws[i][2], widget.throws[i][3], widget.throws[i][4], widget.throws[i][5], widget.throws[i][6], widget.throws[i][7]), color: MaterialStateColor.resolveWith((states) => Color(0xffd5d5d5)))
                    ]else...[
                      DataRow(cells: createThrow(widget.throws[i][0], widget.throws[i][1], widget.throws[i][2], widget.throws[i][3], widget.throws[i][4], widget.throws[i][5], widget.throws[i][6], widget.throws[i][7]))
                    ]
                  ]
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

