import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'actionBuilderWidget.dart';
import 'character_variables.dart';
import 'default_system.dart';
import 'main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:deepcopy/deepcopy.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

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

bool heatSystemMenu = true;

String _searchText = "";

final TextEditingController _searchController = TextEditingController();

class CharacterPage extends StatefulWidget {

  final Character character;

  CharacterPage({super.key, required this.character});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  TextScaler keyboardFontSize = TextScaler.linear(0.85);
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
            }, child: Text(content, style: const TextStyle(color: Colors.white), textScaler: keyboardFontSize,)),
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
            }, child: Text(content, style: const TextStyle(color: Colors.white), textScaler: keyboardFontSize,)),
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
          }, child: Text(content, style: const TextStyle(color: Colors.white), textScaler: keyboardFontSize,)),
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
        if(!isPro) interstitialAd?.show();
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              // title: Text(widget.character.name.toUpperCase()),
              title:!kDebugMode? Text(widget.character.name.toUpperCase()) : TextButton(
                child:  Text(widget.character.name.toUpperCase()),
                onPressed: () {
                  showDialog(context: context, builder: (context) => AlertDialog(title: Text("moves"), content: SingleChildScrollView(child: Text(widget.character.moveList.toString()),),),);
                },
              ),
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

              actions: [
                actionBuilder(context, widget.character.name, true)
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
                          keyBoard(context)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                MoveList(character: widget.character),
                ThrowList(character: widget.character)
              ],
            ),
            bottomNavigationBar: isPro?null:Container(
              color: Colors.black,
              width: _banner.size.width.toDouble(),
              height: _banner.size.height.toDouble(),
              child: AdWidget(ad: _banner,),
            )
        ),
      )
    );
  }

  IconButton keyBoard(BuildContext context) {
    return IconButton(onPressed: (){
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
                              );}, icon: const Icon(Icons.keyboard_alt_outlined), color: Colors.white, iconSize: 30,);
  }
}

class MoveList extends StatefulWidget {

  final Character character;

  MoveList({super.key, required this.character});

  @override
  State<MoveList> createState() => _MoveListState();
}

class _MoveListState extends State<MoveList>{

  final TextEditingController _startFrameController = TextEditingController();
  final TextEditingController _guardFrameController = TextEditingController();
  final TextEditingController _hitFrameController = TextEditingController();
  final TextEditingController _counterFrameController = TextEditingController();
  final TextEditingController _damageController = TextEditingController();
  final TextEditingController _extraController = TextEditingController();

  bool _high = false;
  bool _middle = false;
  bool _low = false;
  bool _unblockable = false;

  LinkedScrollControllerGroup horizonControllerGroup = LinkedScrollControllerGroup();
  ScrollController headerHorizonController = ScrollController();
  ScrollController dataTableHorizonController = ScrollController();
  late List filtered;

  void filter(){
    setState(() {
      filtered = widget.character.moveList.deepcopy();
      for (int i = 0; i < widget.character.types.length; i++) {
        filtered[i]["contents"] = filtered[i]["contents"].where((item) => item.toString().toLowerCase().contains(_searchText.toLowerCase())).toList();
      }

      _startFrameController.value.text.isNotEmpty? headerFilter(2, _startFrameController) : null;
      _guardFrameController.value.text.isNotEmpty? headerFilter(3, _guardFrameController) : null;
      _hitFrameController.value.text.isNotEmpty? headerFilter(4, _hitFrameController) : null;
      _counterFrameController.value.text.isNotEmpty? headerFilter(5, _counterFrameController) : null;
      _damageController.value.text.isNotEmpty? headerFilter(7, _damageController) : null;
      _extraController.value.text.isNotEmpty? headerFilter(8, _extraController) : null;
      rangeFilter();
    });
  }

  void headerFilter(int number, TextEditingController controller){
    setState(() {
      for (int i = 0; i < widget.character.types.length; i++) {
        filtered[i]["contents"] = filtered[i]["contents"].where((item) => item[number].toString().contains(controller.value.text)).toList();
      }
    });
  }

  void rangeFilter(){
    setState(() {
      for (int i = 0; i < widget.character.types.length; i++) {
        filtered[i]["contents"] = filtered[i]["contents"].where((item) {
          if(_high && item[6].toString().contains("상단") || _middle && item[6].toString().contains("중단") || _low && item[6].toString().contains("하단") || _unblockable && item[6].toString().contains("가불")){
            return true;
          }else if(!_high && !_middle && !_low && !_unblockable) {
            return true;
          }else{
            return false;
          }
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    filtered = widget.character.moveList.deepcopy();
    headerHorizonController = horizonControllerGroup.addAndGet();
    dataTableHorizonController = horizonControllerGroup.addAndGet();
  }

  @override
  Widget build(BuildContext context) {

    listLength = 1;

    filter();

    Widget line(){
      return Container(width: 0, height: 50, decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black, width: 0.5), left: BorderSide(color: Colors.black, width: 0.5))));
    }

    Widget headerMenuAnchor(double width, TextEditingController controller, String name){
      return MenuAnchor(
        menuChildren: [
          SizedBox(
            width: width,
            child: TextFormField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                });
              },
            ),
          )
        ],
        builder: (context, controller, child) => TextButton(onPressed: (){
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        }, child: Text(name,textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 111.5,
            child: TextButton(onPressed: (){
              setState(() {
                heatSystemMenu == true? heatSystemMenu = false : heatSystemMenu = true;
              });
            }, child: Row(children: [Text("히트 시스템"), Icon(heatSystemMenu? Icons.arrow_drop_up : Icons.arrow_drop_down)])),
          ),
          if(heatSystemMenu == true) // 히트 시스템 설명
            heatSystemContexts(widget.character.heatSystem), //변경해야될것
          Container(
            width: 848,
            child: StickyHeader(
              header: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: headerHorizonController,
                child: Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black)), color: Color(0xfffafafa)),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150 + 5,
                        child: MenuAnchor( // 커맨드 체크박스
                          alignmentOffset: const Offset(20, 0),
                          menuChildren: [
                            for(MapEntry<String, bool> type in widget.character.types.entries)...[
                              CheckboxMenuButton(value: widget.character.types[type.key], onChanged: (value) {
                                setState(() {
                                  widget.character.types[type.key] = value!;
                                });
                              }, closeOnActivate: false, child: Text(language == "ko"? widget.character.typesKo[type.key]! : type.key)),
                            ],
                          ],
                          builder: (context, controller, child)=> TextButton(onPressed: () {
                            controller.isOpen? controller.close() : controller.open();
                          }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("기술명\n커맨드", style: headerStyle, textScaler: headerScale, textAlign: TextAlign.center),
                              Icon(Icons.arrow_drop_down, color: Colors.black,),
                            ],
                          ),),
                        ),
                      ),
                      line(),
                      Container(width: 30 + 10, child: headerMenuAnchor(40, _startFrameController, "발생")),
                      line(),
                      Container(width: listWidth + 10, child: headerMenuAnchor(45, _guardFrameController, "가드")),
                      line(),
                      Container(width: listWidth + 10, child: headerMenuAnchor(45, _hitFrameController, "히트")),
                      line(),
                      Container(width: listWidth + 10, child: headerMenuAnchor(45, _counterFrameController, "카운터")),
                      line(),
                      Container(width: 30 + 10, child: MenuAnchor( // 커맨드 체크박스
                        alignmentOffset: const Offset(20, 0),
                        menuChildren: [
                          CheckboxMenuButton(value: _high, onChanged: (value){
                            setState(() {
                              _high = value!;
                            });
                          }, closeOnActivate: false, child: Text("상단")),
                          CheckboxMenuButton(value: _middle, onChanged: (value){
                            setState(() {
                              _middle = value!;
                            });
                          }, closeOnActivate: false, child: Text("중단")),
                          CheckboxMenuButton(value: _low, onChanged: (value){
                            setState(() {
                              _low = value!;
                            });
                          }, closeOnActivate: false, child: Text("하단")),
                          CheckboxMenuButton(value: _unblockable, onChanged: (value){
                            setState(() {
                              _unblockable = value!;
                            });
                          }, closeOnActivate: false, child: Text("가불"))
                        ],
                        builder: (context, controller, child)=> TextButton(onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("판정", style: headerStyle, textScaler: headerScale, textAlign: TextAlign.center),
                          ],
                        ),),
                      ),),
                      line(),
                      Container(width: 50 + 10, child: headerMenuAnchor(60, _damageController, "대미지")),
                      line(),
                      Container(width: 412, child: headerMenuAnchor(412, _extraController, "비고")),
                    ],
                  ),
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: dataTableHorizonController,
                child: DataTable(
                    headingRowHeight: 0,
                    headingTextStyle: headerStyle,
                    dataRowMaxHeight: double.infinity,
                    dataRowMinHeight: 48,
                    border: TableBorder.symmetric(inside: const BorderSide(color: Colors.black)),
                    horizontalMargin: 0,
                    columnSpacing: 10,
                    columns: [
                      const DataColumn(label: SizedBox(width: 150)),
                      const DataColumn(label: SizedBox(width: 30)),
                      const DataColumn(label: SizedBox(width: listWidth)),
                      const DataColumn(label: SizedBox(width: listWidth)),
                      const DataColumn(label: SizedBox(width: listWidth)),
                      const DataColumn(label: SizedBox(width: 30)),
                      const DataColumn(label: SizedBox(width: 50)),
                      const DataColumn(label: SizedBox(width: 412)),
                    ],
                    rows: [
                      if(_searchText.isEmpty || widget.character.rageArts.toString().toLowerCase().contains(_searchText.toLowerCase()))
                        DataRow(color: MaterialStateColor.resolveWith((states) => const Color(0xffd5d5d5)) ,cells : (createMove(context, widget.character, widget.character.rageArts[0], widget.character.rageArts[1], widget.character.rageArts[2], widget.character.rageArts[3], widget.character.rageArts[4], widget.character.rageArts[5], widget.character.rageArts[6], widget.character.rageArts[7], widget.character.rageArts[8]))), //레이지 아츠
                      for(String type in widget.character.types.keys)...[
                        if(widget.character.types[type] == true || widget.character.types.values.every((element) => element == false))...[
                          for(List data in filtered.firstWhere((element) => element["type"] == type)["contents"])...[
                            if(listLength % 2 == 1)...[
                              DataRow(cells : (createMove(context, widget.character, data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8].replaceAll(RegExp(r'\[.*?\]'), ""))), color: MaterialStateColor.resolveWith((states) =>
                              const Color(0xffd5d5d5)))
                            ]else if(listLength % 2 == 0)...[
                              DataRow(cells : (createMove(context, widget.character, data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8].replaceAll(RegExp(r'\[.*?\]'), ""))))
                            ]
                          ],
                        ],
                      ]
                    ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThrowList extends StatefulWidget {

  final Character character;

  const ThrowList({super.key, required this.character});

  @override
  State<ThrowList> createState() => _ThrowListState();
}

class _ThrowListState extends State<ThrowList>{

  Widget line(){
    return Container(width: 0, height: 50, decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black, width: 0.5), left: BorderSide(color: Colors.black, width: 0.5))));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          width: 600,
          child: StickyHeader(
            header: Container(
              height: 50,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black)), color: Color(0xfffafafa)),
              child: Row(
                children: [
                  SizedBox(width: 150 + 5,child: Text('기술명\n커맨드',textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 30 + 10,child: Text('발생',textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 40 + 10,child: Text('풀기',textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 30 + 10,child: Text('풀기\n후 F',textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 50 + 10,child: Text('대미지',textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 30 + 10,child: Text('판정',textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  Expanded(child: Text('비고',textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                ],
              ),
            ),
            content: DataTable(
              headingRowHeight: 0,
              dataRowMaxHeight: double.infinity,
              dataRowMinHeight: 48,
              border: TableBorder.symmetric(inside: const BorderSide(color: Colors.black)),
              horizontalMargin: 0,
              columnSpacing: 10,
              columns: [
                const DataColumn(label: SizedBox(width: 150)),
                const DataColumn(label: SizedBox(width: 30)),
                const DataColumn(label: SizedBox(width: 40)),
                const DataColumn(label: SizedBox(width: 30)),
                const DataColumn(label: SizedBox(width: 50)),
                const DataColumn(label: SizedBox(width: 30)),
                const DataColumn(label: SizedBox(width: 210)),
              ],
              rows: [
                for(int i = 0; i < widget.character.throwList.length; i++)...[
                  if(i % 2 == 0)...[
                    DataRow(cells: createThrow(context, widget.character, widget.character.throwList[i][0], widget.character.throwList[i][1], widget.character.throwList[i][2], widget.character.throwList[i][3], widget.character.throwList[i][4], widget.character.throwList[i][5], widget.character.throwList[i][6], widget.character.throwList[i][7]), color: MaterialStateColor.resolveWith((states) => const Color(0xffd5d5d5)))
                  ]else...[
                    DataRow(cells: createThrow(context, widget.character, widget.character.throwList[i][0], widget.character.throwList[i][1], widget.character.throwList[i][2], widget.character.throwList[i][3], widget.character.throwList[i][4], widget.character.throwList[i][5], widget.character.throwList[i][6], widget.character.throwList[i][7]))
                  ]
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

