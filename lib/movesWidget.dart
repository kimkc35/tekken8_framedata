import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'actionBuilderWidget.dart';
import 'ad_manager.dart';
import 'default_system.dart';
import 'main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:math_expressions/math_expressions.dart';
import 'modules.dart';

final BannerAd _banner = loadBannerAd()..load();

String _searchText = "";

final TextEditingController _searchController = TextEditingController();

class CharacterPage extends StatefulWidget {

  final Character character;

  CharacterPage({super.key, required this.character});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> with SingleTickerProviderStateMixin{
  final TextScaler keyboardFontSize = TextScaler.linear(0.85);

  late final TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  //키보드 버튼 제작 함수
  Widget keyboardButton(String content, {String inputText = ""}){
    if(content == "delete"){
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 40,
            child: TextButton(style: ButtonStyle(side: WidgetStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
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
            child: TextButton(style: ButtonStyle(side: WidgetStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
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
            child: TextButton(style: ButtonStyle(side: WidgetStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
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
          child: TextButton(style: ButtonStyle(side: WidgetStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.pink))),onPressed: (){
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
      onPopInvokedWithResult: (b, r) {
        _searchText = "";
        _searchController.text = "";
        if(!isPro) interstitialAd?.show();
      },
      child: Scaffold(
          appBar: AppBar(
            // title: Text(widget.character.name.toUpperCase()),
            title:!kDebugMode? Text(widget.character.name.toUpperCase()) : TextButton(
              child:  Text(widget.character.name.toUpperCase()),
              onPressed: () {
                showDialog(context: context, builder: (context) => AlertDialog(title: Text("moves"), content: SingleChildScrollView(child: Text(widget.character.moveInfoList.toString()),),),);
              },
            ),
            centerTitle: true,
            leadingWidth: 80,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: (
                    Text("FRAME\nDATA")
                ),
              ),
            ),
            actions: [
              actionBuilder(context: context, character: widget.character.name)
            ],
            backgroundColor: Colors.black,
            bottom: PreferredSize(
              preferredSize: Size(0, tabController.index == 0 ? 100 : 50),
              child: Column(
                children: [
                  TabBar(
                    onTap: (index){
                      setState(() {
                      });
                    },
                    controller: tabController,
                    automaticIndicatorColorAdjustment: true,
                    tabs: [
                      Tab(text: "Move List"),
                      Tab(text: "Throw")
                    ],
                  ),
                  tabController.index == 0 ? Padding(
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
                  ) : Container()
                ],
              ),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
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
      )
    );
  }

  IconButton keyBoard(BuildContext context) {
    return IconButton(onPressed: (){
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
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

  final ValueNotifier<bool> isHeatSystemMenuOpen = ValueNotifier(true);

  final TextEditingController _startFrameController = TextEditingController();
  final TextEditingController _guardFrameController = TextEditingController();
  final TextEditingController _hitFrameController = TextEditingController();
  final TextEditingController _counterFrameController = TextEditingController();
  final TextEditingController _damageController = TextEditingController();
  final TextEditingController _extraController = TextEditingController();

  late final ComparisonHeader startComparisonHeader = ComparisonHeader(name: "moves.headers.2".tr(), controller: _startFrameController, state: ComparisonState.greater);
  late final ComparisonHeader guardComparisonHeader = ComparisonHeader(name: "moves.headers.3".tr(), controller: _guardFrameController, state: ComparisonState.greater);
  late final ComparisonHeader hitComparisonHeader = ComparisonHeader(name: "moves.headers.4".tr(), controller: _hitFrameController, state: ComparisonState.greater);
  late final ComparisonHeader counterComparisonHeader = ComparisonHeader(name: "moves.headers.5".tr(), controller: _counterFrameController, state: ComparisonState.greater);
  late final ComparisonHeader damageComparisonHeader = ComparisonHeader(name: "moves.headers.7".tr(), controller: _damageController, state: ComparisonState.greater);

  bool _high = false;
  bool _middle = false;
  bool _low = false;
  bool _unblockable = false;

  LinkedScrollControllerGroup horizonControllerGroup = LinkedScrollControllerGroup();
  ScrollController headerHorizonController = ScrollController();
  ScrollController dataTableHorizonController = ScrollController();
  late Map<String, List<MoveInfo>> filtered;

  void filter(){
    filtered = widget.character.getMoveList();
    setState(() {
      for (var type in widget.character.types.keys) {
        filtered[type] = filtered[type]!.where((item){
          if(item.name.contains(_searchText)) return true;
          if(item.command.contains(_searchText)) return true;
          if(item.range.contains(_searchText)) return true;
          if(item.damage.contains(_searchText)) return true;
          if(item.extra.contains(_searchText)) return true;
          return false;
        }).toList();
      }

      _damageController.value.text.isNotEmpty? headerFilter(_damageController) : null;
      _extraController.value.text.isNotEmpty? headerFilter(_extraController) : null;
      rangeFilter();
      comparisonFilter();
    });
  }

  void headerFilter(TextEditingController controller){
    setState(() {
      for (var type in widget.character.types.keys) {
        filtered[type] = filtered[type]!.where((item){
          if(item.name.contains(_searchText)) return true;
          if(item.command.contains(_searchText)) return true;
          if(item.range.contains(_searchText)) return true;
          if(item.damage.contains(_searchText)) return true;
          if(item.extra.contains(_searchText)) return true;
          return false;
        }).toList();
      }
    });
  }

  void rangeFilter(){
    setState(() {
      for (var type in widget.character.types.keys) {
        filtered[type] = filtered[type]!.where((item) {
          if(_high && item.range.contains("moves.range.high".tr()) || _middle && item.range.contains("moves.range.mid".tr()) || _low && item.range.contains("moves.range.low".tr()) || _unblockable && item.range.contains("moves.range.unblockabe".tr())){
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

  void comparisonFilter(){

    bool comparisionFunction(String itemString, ComparisonHeader comparisonHeader) {
      try {
        int.parse(comparisonHeader.controller.text);
        if(itemString.contains("(")){
          final int value1 = int.parse(itemString.split("(")[0]);
          final int value2 = int.parse(itemString.split("(")[1].replaceAll(")", ""));
          return comparison(value1.toString(), comparisonHeader) || comparison(value2.toString(), comparisonHeader);
        }
        return comparison(itemString, comparisonHeader);
      } on FormatException {
        return itemString.toLowerCase().contains(comparisonHeader.controller.text.toLowerCase());
      }
    }

    setState(() {
      for (var type in widget.character.types.keys) {
        if(startComparisonHeader.controller.text.isNotEmpty) {
          filtered[type] = filtered[type]!.where((item) {
            return comparisionFunction(item.startFrame, startComparisonHeader);
          }).toList();
        }
        if(guardComparisonHeader.controller.text.isNotEmpty) {
          filtered[type] = filtered[type]!.where((item) {
            return comparisionFunction(item.guardFrame, guardComparisonHeader);
          }).toList();
        }
        if(hitComparisonHeader.controller.text.isNotEmpty) {
          filtered[type] = filtered[type]!.where((item) {
            return comparisionFunction(item.hitFrame, hitComparisonHeader);
          }).toList();
        }
        if(counterComparisonHeader.controller.text.isNotEmpty) {
          filtered[type] = filtered[type]!.where((item) {
            return comparisionFunction(item.counterFrame, counterComparisonHeader);
          }).toList();
        }
        if(damageComparisonHeader.controller.text.isNotEmpty){
          filtered[type] = filtered[type]!.where((item) {
            int damage = 0;
            int damage2 = 0;
            item.damage.split(",").forEach((element) {
              try{
                damage += int.parse(element);
                damage2 += int.parse(element);
              } on FormatException {
                if(element.contains("x")){
                  final n = element.replaceAll("x", "*");
                  final p = Parser();
                  damage += int.parse(p.parse(n).evaluate(EvaluationType.REAL, ContextModel()).toInt().toString());
                  damage2 += int.parse(p.parse(n).evaluate(EvaluationType.REAL, ContextModel()).toInt().toString());
                }else if(element.contains("(")){
                  final split = element.split("(");
                  damage += int.parse(split[0]);
                  damage2 += int.parse(split[1].replaceAll(")", ""));
                }else{
                  damage += 0;
                }
              }
            });
            return comparison(damage.toString(), damageComparisonHeader) || comparison(damage2.toString(), damageComparisonHeader);
          }).toList();
        }
      }
    });
  }


  bool comparison(String itemText, ComparisonHeader comparisonHeader){
    itemText = itemText.replaceAll("g", "");
    switch(comparisonHeader.state){
      case ComparisonState.greater:
        try {
          if(int.parse(itemText) > int.parse(comparisonHeader.controller.text)){
            return true;
          }
        } on FormatException{
          try {
            if(int.parse(itemText.split("(")[0]) > int.parse(comparisonHeader.controller.text) || int.parse(itemText.split("(")[1].replaceAll(")", "")) > int.parse(comparisonHeader.controller.text)){
              return true;
            }
          } on FormatException {
            return false;
          }
        }
      case ComparisonState.lesser:
        try {
          if(int.parse(itemText) < int.parse(comparisonHeader.controller.text)){
            return true;
          }
        } on FormatException{
          try {
            if(int.parse(itemText.split("(")[0]) < int.parse(comparisonHeader.controller.text) || int.parse(itemText.split("(")[1].replaceAll(")", "")) < int.parse(comparisonHeader.controller.text)){
              return true;
            }
          } on FormatException {
            return false;
          }
        }
      case ComparisonState.equal:
        try {
          if(int.parse(itemText) == int.parse(comparisonHeader.controller.text)){
            return true;
          }
        } on FormatException{
          try {
            if(int.parse(itemText.split("(")[0]) == int.parse(comparisonHeader.controller.text) || int.parse(itemText.split("(")[1].replaceAll(")", "")) == int.parse(comparisonHeader.controller.text)){
              return true;
            }
          } on FormatException {
            return false;
          }
        }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    filtered = widget.character.getMoveList();
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

    Widget comparisonHeaderMenuAnchor(ComparisonHeader comparisonHeader){
      return MenuAnchor(
        alignmentOffset: Offset(-20, 0),
        menuChildren: [
          SizedBox(
            width: 90,
            child: Row(
              children: [
                SizedBox(
                  width: 45,
                  child: TextFormField(
                    controller: comparisonHeader.controller,
                    decoration: InputDecoration(
                      counter: SizedBox.shrink()
                    ),
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 45,
                  child: TextButton(
                      onPressed: (){
                        setState(() {
                        });
                        comparisonHeader.changeState();
                      }, child: Text(comparisonHeader.state.state)
                  ),
                )
              ],
            ),
          )
        ],
        builder: (context, controller, child) => TextButton(onPressed: (){
            controller.isOpen ? controller.close() : controller.open();
          },
            child: Text(comparisonHeader.name,textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
      );
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

    ValueListenableBuilder heatSystemContexts(List<String> addition){
      return ValueListenableBuilder(
        valueListenable: isHeatSystemMenuOpen,
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("1. 모든 공격에 가드 대미지 효과가 붙음 (공통)", style: contextStyle),
                Text("2. 콤보나 공격의 기점이 되는 히트 대시 발동 가능(발동 후 히트 상태 종료) (공통)", style: contextStyle),
                Text("3. 대미지가 높은 큰 기술 히트 스매시 발동 가능(발동 후 히트 상태 종료) (공통)", style: contextStyle),
                for(var i = 0; i < addition.length; i++)...[
                  Text("${i + 4}. ${addition[i]}", style: contextStyle,)
                ]
              ],
            ),
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: isHeatSystemMenuOpen,
            builder: (context, value, child) {
              return TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                  ),
                  onPressed: (){
                    setState(() {
                      isHeatSystemMenuOpen.value = !isHeatSystemMenuOpen.value;
                      debugPrint("상태 $isHeatSystemMenuOpen");
                    });
                  }, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("히트 시스템"),
                    Icon(isHeatSystemMenuOpen.value? Icons.arrow_drop_up : Icons.arrow_drop_down)
                  ]
                )
              );
            },
          ),
          if(isHeatSystemMenuOpen.value) // 히트 시스템 설명
            heatSystemContexts(widget.character.heatSystem),
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
                              }, closeOnActivate: false, child: Text(context.locale.languageCode == "ko"? widget.character.typesKo[type.key]! : generateTypes(type.key))),
                            ],
                          ],
                          builder: (context, controller, child)=> TextButton(onPressed: () {
                            controller.isOpen? controller.close() : controller.open();
                          }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("moves.headers.1".tr(), style: headerStyle, textScaler: headerScale, textAlign: TextAlign.center),
                              Icon(Icons.arrow_drop_down, color: Colors.black,),
                            ],
                          ),),
                        ),
                      ),
                      line(),
                      Container(width: 30 + 10, child: comparisonHeaderMenuAnchor(startComparisonHeader)),
                      line(),
                      Container(width: listWidth + 10, child: comparisonHeaderMenuAnchor(guardComparisonHeader)),
                      line(),
                      Container(width: listWidth + 10, child: comparisonHeaderMenuAnchor(hitComparisonHeader)),
                      line(),
                      Container(width: listWidth + 10, child: comparisonHeaderMenuAnchor(counterComparisonHeader)),
                      line(),
                      Container(width: 30 + 10, child: MenuAnchor( // 커맨드 체크박스
                        alignmentOffset: const Offset(20, 0),
                        menuChildren: [
                          CheckboxMenuButton(value: _high, onChanged: (value){
                            setState(() {
                              _high = value!;
                            });
                          }, closeOnActivate: false, child: Text("moves.range.high".tr())),
                          CheckboxMenuButton(value: _middle, onChanged: (value){
                            setState(() {
                              _middle = value!;
                            });
                          }, closeOnActivate: false, child: Text("moves.range.mid".tr())),
                          CheckboxMenuButton(value: _low, onChanged: (value){
                            setState(() {
                              _low = value!;
                            });
                          }, closeOnActivate: false, child: Text("moves.range.low".tr())),
                          CheckboxMenuButton(value: _unblockable, onChanged: (value){
                            setState(() {
                              _unblockable = value!;
                            });
                          }, closeOnActivate: false, child: Text("moves.range.unblockable".tr()))
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
                            Text("moves.headers.6".tr(), style: headerStyle, textScaler: headerScale, textAlign: TextAlign.center),
                          ],
                        ),),
                      ),),
                      line(),
                      Container(width: 50 + 10, child: comparisonHeaderMenuAnchor(damageComparisonHeader)),
                      line(),
                      Container(width: 450, child: headerMenuAnchor(450, _extraController, "moves.headers.8".tr())),
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
                      const DataColumn(label: SizedBox(width: 450)),
                    ],
                    rows: [
                      if(_searchText.isEmpty || widget.character.rageArts.toString().toLowerCase().contains(_searchText.toLowerCase()))
                        DataRow(color: WidgetStateColor.resolveWith((states) => const Color(0xffd5d5d5)) ,cells : (createMove(context, widget.character, widget.character.rageArts))), //레이지 아츠
                      for(String type in widget.character.types.keys)...[
                        if(widget.character.types[type] == true || widget.character.types.values.every((element) => element == false))...[
                          for(MoveInfo data in filtered[type]!)...[
                            if(data.color == null || !cellColors.containsKey(data.color))...[
                              if(listLength % 2 == 1)...[
                                DataRow(cells : (createMove(context, widget.character, data)), color: WidgetStateColor.resolveWith((states) =>
                                cellColors["grey"]!))
                              ]else if(listLength % 2 == 0)...[
                                DataRow(cells : (createMove(context, widget.character, data)))
                              ]
                            ]else...[
                              DataRow(cells : (createMove(context, widget.character, data)), color: WidgetStateColor.resolveWith((states) =>
                              cellColors[data.color]!))
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
                  SizedBox(width: 150 + 5,child: Text('moves.throwHeaders.1'.tr(),textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 30 + 10,child: Text('moves.throwHeaders.2'.tr(),textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 40 + 10,child: Text('moves.throwHeaders.3'.tr(),textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 30 + 10,child: Text('moves.throwHeaders.4'.tr(),textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 50 + 10,child: Text('moves.throwHeaders.5'.tr(),textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  SizedBox(width: 30 + 10,child: Text('moves.throwHeaders.6'.tr(),textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
                  line(),
                  Expanded(child: Text('moves.throwHeaders.7'.tr(),textAlign: TextAlign.center, style: headerStyle, textScaler: headerScale)),
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
                for(int i = 0; i < widget.character.throwInfoList.length; i++)...[
                  if(i % 2 == 0)...[
                    DataRow(cells: createThrow(context, widget.character, widget.character.throwInfoList[i]), color: WidgetStateColor.resolveWith((states) => const Color(0xffd5d5d5)))
                  ]else...[
                    DataRow(cells: createThrow(context, widget.character, widget.character.throwInfoList[i]))
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

