import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'default_system.dart';
import 'main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:deepcopy/deepcopy.dart';

final BannerAd _banner = BannerAd(
    adUnitId: 'ca-app-pub-3256415400287290/4169383092',
    size: AdSize.banner,
    request: const AdRequest(),
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
final List rageArts = ["Semper Avarus Eget", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"];

//paul extra list
List<Map<String, String>> extraInitials = [ //변경해야될것,
  {"name" : "guardDamage", "guardDamage" : "가드 대미지"},
  {"name" : "powerCrash", "powerCrash" : "파워 크래시"},
  {"name" : "tornado", "tornado" : "토네이도"},
  {"name" : "homing", "homing" : "호밍기"},
  {"name" : "charge", "charge" : "효과 지속 중에는 가드할 수 없음\n자동 카운터 히트"},
  {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}
];

List<String> heatSystem = ["아자젤의 힘(체력 소비 기술)이 발동했을 때 체력을 소비하지 않음", "아자젤의 힘에 의한 큰 기술이 파워 크래시가 됨"];

const character = "zafina"; //변경해야될것

List types = [ //변경해야될것
  {"heat" : true}, {"general" : true}, {"sit" : true}, {"scarecrow stance" : true}, {"tarantula stance" : true}, {"mantis stance" : true}
];

Map<String, String> typesKo = {
  "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "scarecrow stance" : "스케어크로 자세", "tarantula stance" : "타란튤라 자세", "mantis stance" : "맨티스 자세"
};

bool heatSystemMenu = true;

String _searchText = "";

final TextEditingController _searchController = TextEditingController();

class Main extends StatefulWidget {

  final moves, throws;

  const Main({super.key, required this.moves, required this.throws});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  //키보드 버튼 제작 함수
  Widget keyboardButton(String content, {String inputText = ""}){
    if(content == "delete"){
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 40,
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                _searchController.text = _searchController.text.substring(0, _searchController.text.length - 1);
                _searchText = _searchController.text;
              });
            }, child: const Icon(CupertinoIcons.arrow_left_to_line, size: 20, color: Colors.white,), ),
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
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                _searchController.text = _searchController.text + inputText;
                _searchText = _searchController.text;
              });
            }, child: Text(content, style: const TextStyle(color: Colors.white, fontSize: keyboardFontSize),)),
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
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                _searchController.text = "";
                _searchText = _searchController.text;
              });
            }, child: Text(content, style: const TextStyle(color: Colors.white, fontSize: keyboardFontSize),)),
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
          child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
            setState(() {
              _searchController.text = _searchController.text + content;
              _searchText = _searchController.text;
            });
          }, child: Text(content, style: const TextStyle(color: Colors.white, fontSize: keyboardFontSize),)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(isPro){
      return PopScope(
        onPopInvoked: (didPop) {
          _searchText = "";
          _searchController.text = "";
        },
        child: DefaultTabController(
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
                        const ButtonBar(
                          children: [
                            Text("FRAME\nDATA")
                          ],
                        )
                    ),
                  ),
                  actionsIconTheme: const IconThemeData(size: 40),
                  actions: [
                    actionBuilder(context)
                  ],
                  backgroundColor: Colors.black,
                  bottom: PreferredSize(
                    preferredSize: const Size(0, 100),
                    child: Column(
                      children: [
                        const TabBar(
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
                                child: TextFormField(controller: _searchController, decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white), label: Text("검색"), border: OutlineInputBorder()
                                ), style: const TextStyle(color: Colors.white), onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(), onChanged: (value) {
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
                                );}, icon: const Icon(Icons.keyboard_alt_outlined), color: Colors.white, iconSize: 30,)
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
              ),
            )
      );
    }
    return PopScope(
      onPopInvoked: (didPop) {
        _searchText = "";
        _searchController.text = "";
        interstitialAd?.show();
      },
      child: DefaultTabController(
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
                        const ButtonBar(
                          children: [
                            Text("FRAME\nDATA")
                          ],
                        )
                    ),
                  ),
                  actionsIconTheme: const IconThemeData(size: 40),
                  actions: [
                    actionBuilder(context)
                  ],
                  backgroundColor: Colors.black,
                  bottom: PreferredSize(
                    preferredSize: const Size(0, 100),
                    child: Column(
                      children: [
                        const TabBar(
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
                                child: TextFormField(controller: _searchController, decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white), label: Text("검색"), border: OutlineInputBorder()
                                ), style: const TextStyle(color: Colors.white), onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(), onChanged: (value) {
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
                                );}, icon: const Icon(Icons.keyboard_alt_outlined), color: Colors.white, iconSize: 30,)
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
    );
  }
}

class MoveList extends StatefulWidget {

  final List moves;

  const MoveList({super.key, required this.moves});

  @override
  State<MoveList> createState() => _MoveListState();
}

class _MoveListState extends State<MoveList> {

  late List filtered;

  void filter(String text){
    setState(() {
      filtered = widget.moves.deepcopy();
      for (int i = 0; i < types.length; i++) {
        filtered[i]["contents"] = filtered[i]["contents"].where((item) => item.toString().toLowerCase().contains(text.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    listLength = 1;

    if(_searchText.isNotEmpty) {
      filter(_searchText); //필터링
    }else{
      setState(() {
        filtered = widget.moves.deepcopy(); //초기화
      });
    }

    return SingleChildScrollView(
      child: Column(
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
          }, child: const Text("히트 시스템")),
          if(heatSystemMenu == true) // 히트 시스템 설명
            SizedBox(child: heatSystemContexts(heatSystem)), //변경해야될것
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                headingRowHeight: 50,
                headingTextStyle: headingStyle,
                dataRowMaxHeight: double.infinity,
                dataRowMinHeight: 48,
                border: TableBorder.symmetric(inside: const BorderSide(color: Colors.black)),
                horizontalMargin: 0,
                columnSpacing: 10,
                columns: [
                  DataColumn(label: SizedBox(
                    width: 150,
                    height: 100,
                    child: MenuAnchor( // 커맨드 체크박스
                      alignmentOffset: const Offset(20, 0),
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
                  const DataColumn(label: SizedBox(width: 30, child: Text('발생',textAlign: TextAlign.center,))),
                  const DataColumn(label: SizedBox(width: listWidth, child: Text('가드',textAlign: TextAlign.center))),
                  const DataColumn(label: SizedBox(width: listWidth, child: Text('히트',textAlign: TextAlign.center))),
                  const DataColumn(label: SizedBox(width: listWidth, child: Text('카운터',textAlign: TextAlign.center))),
                  const DataColumn(label: SizedBox(width: 30, child: Text('판정',textAlign: TextAlign.center))),
                  const DataColumn(label: SizedBox(width: 50, child: Text('대미지',textAlign: TextAlign.center))),
                  const DataColumn(label: Expanded(child: Text('비고',textAlign: TextAlign.center))),
                ],
                rows: [
                  if(_searchText.isEmpty || rageArts.toString().toLowerCase().contains(_searchText.toLowerCase()))
                    DataRow(color: MaterialStateColor.resolveWith((states) => const Color(0xffd5d5d5)) ,cells : (createMove(context, character, rageArts[0], rageArts[1], rageArts[2], rageArts[3], rageArts[4], rageArts[5], rageArts[6], rageArts[7], rageArts[8]))), //레이지 아츠
                  for(int i = 0; i < types.length; i++)...[
                    if(types[i][filtered[i]["type"]] == true)...[
                      for(int j = 0; j < filtered[i]["contents"].length; j ++)...[
                        if(listLength % 2 == 1)...[
                          DataRow(cells : (createMove(context, character, filtered[i]["contents"][j][0], filtered[i]["contents"][j][1], filtered[i]["contents"][j][2], filtered[i]["contents"][j][3], filtered[i]["contents"][j][4], filtered[i]["contents"][j][5], filtered[i]["contents"][j][6], filtered[i]["contents"][j][7], filtered[i]["contents"][j][8])), color: MaterialStateColor.resolveWith((states) =>
                              const Color(0xffd5d5d5)))
                        ]else if(listLength % 2 == 0)...[
                          DataRow(cells : (createMove(context, character, filtered[i]["contents"][j][0], filtered[i]["contents"][j][1], filtered[i]["contents"][j][2], filtered[i]["contents"][j][3], filtered[i]["contents"][j][4], filtered[i]["contents"][j][5], filtered[i]["contents"][j][6], filtered[i]["contents"][j][7], filtered[i]["contents"][j][8])))
                        ]
                      ],
                    ],
                  ]
                ]
            ),
          ),
        ],
      ),
    );
  }
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: 50,
          headingTextStyle: headingStyle,
          dataRowMaxHeight: double.infinity,
          dataRowMinHeight: 48,
          border: TableBorder.symmetric(inside: const BorderSide(color: Colors.black)),
          horizontalMargin: 0,
          columnSpacing: 10,
          columns: [
            const DataColumn(label: SizedBox(width: 150,child: Text('기술명\n커맨드',textAlign: TextAlign.center,))),
            const DataColumn(label: SizedBox(width: 30,child: Text('발생',textAlign: TextAlign.center))),
            const DataColumn(label: SizedBox(width: 40,child: Text('풀기',textAlign: TextAlign.center))),
            const DataColumn(label: SizedBox(width: 30,child: Text('풀기\n후 F',textAlign: TextAlign.center))),
            const DataColumn(label: SizedBox(width: 50,child: Text('대미지',textAlign: TextAlign.center))),
            const DataColumn(label: SizedBox(width: 30,child: Text('판정',textAlign: TextAlign.center))),
            const DataColumn(label: Expanded(child: Text('비고',textAlign: TextAlign.center))),
          ],
          rows: [
            for(int i = 0; i < widget.throws.length; i++)...[
              if(i % 2 == 0)...[
                DataRow(cells: createThrow(context, character, widget.throws[i][0], widget.throws[i][1], widget.throws[i][2], widget.throws[i][3], widget.throws[i][4], widget.throws[i][5], widget.throws[i][6], widget.throws[i][7]), color: MaterialStateColor.resolveWith((states) => const Color(0xffd5d5d5)))
              ]else...[
                DataRow(cells: createThrow(context, character, widget.throws[i][0], widget.throws[i][1], widget.throws[i][2], widget.throws[i][3], widget.throws[i][4], widget.throws[i][5], widget.throws[i][6], widget.throws[i][7]))
              ]
            ]
          ],
        ),
      ),
    );
  }
}

