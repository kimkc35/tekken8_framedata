import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekken8_framedata/drawer.dart';
import 'package:tekken8_framedata/searchScreen.dart';
import 'actionBuilderWidget.dart';
import 'ad_manager.dart';
import 'character_variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'characterWidget.dart';
import 'firebase_options.dart' ;
import 'modules.dart';
import 'tipScreen.dart';
import 'upgradeAlertWidget.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

const bool isPro = true;

bool isFirst = true;

String language = "ko";

late Map<String, dynamic> patchNotes;

List<PlayerInfo> bookmarkedList = [];

const sticks = {"c1" : "↙", "c2" : "↓", "c3" : "↘", "c4" : "←", "c5" : "N", "c6" : "→", "c7" : "↖", "c8" : "↑", "c9" : "↗"};

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await initializeSetting();

  runApp(
     MyApp()
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  refresh(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[FirebaseAnalyticsObserver(analytics: analytics)],
      theme: themeData,
      home: Main(refresh: refresh,),
    );
  }
}

class GetContents { // 리스트 구성

  Character character;

  GetContents(this.character);

    Future<List> getVideoUrlList() async {

    String docsUrl = kDebugMode? "https://docs.google.com/document/d/1vHR19LZT8yKFPYpkfESVukUhxYlxO3ySdEpjzJsh5oo/edit?usp=sharing" : "https://docs.google.com/document/d/1fnSCB7ijrcPDarWyLBMf2S19NHGjwiMxu-FF49mMLR8/edit?usp=sharing";

    final response = await http.get(Uri.parse(docsUrl));

    RegExp regExp = RegExp(r'character:\\n(.*?)(end)'.replaceAll("character", character.name));

    Match? match = regExp.firstMatch(response.body);

    if(match != null){
      RegExp linkRegExp = RegExp(r'https://youtu\.be/.*?\\n');
      Iterable<Match> linkMatches = linkRegExp.allMatches(match.group(1)!);

      List<String> videoUrlList = [];
      for (Match linkMatch in linkMatches) {
        videoUrlList.add(linkMatch.group(0)!.replaceAll("\\n", ""));
      }

      return videoUrlList;
    }

    // debugPrint("${character.name}에서 없음");
    return [];
  }

  Future<void> makeCharacterVideoUrlList() async {
    List urlList = await GetContents(character).getVideoUrlList();
    Map<String, String> videoList = {};

    // 비디오 제목을 가져오는 작업을 비동기로 처리하여 병렬로 실행
    List<Future<void>> futures = urlList.map((url) async {
      String embedUrl = "https://www.youtube.com/oembed?url=$url&format=json";
      try {
        final response = await http.get(Uri.parse(embedUrl));
        final data = json.decode(response.body);
        String currentTitle = data['title'] ?? "제목 오류";
        if (currentTitle != "제목 오류") {
          videoList[currentTitle] = url;
        } else {
          // debugPrint("$url에서 제목 오류");
        }
      } catch (e) {
        debugPrint("$url 에서 비디오 제목 가져오기 실패: $e");
      }
    }).toList();
    // 모든 비디오 제목 가져오기 작업이 완료될 때까지 기다림
    await Future.wait(futures);
    //디버그
    // assert(() {
    //   for(var type in character.types.keys){
    //     debugPrint("${character.name}의 $type에서 : ");
    //     for(var move in character.moveList.firstWhere((element) => element["type"] == type)["contents"]){
    //       String modifiedMoveName = move[0].replaceAll(RegExp(r'\d{1,2}$'), '');
    //       if(videoList[modifiedMoveName] == null){
    //         debugPrint("$modifiedMoveName 영상이 없음");
    //       }
    //     }
    //   }
    //   debugPrint("${character.name}의 잡기 리스트 에서 : ");
    //   for(var move in character.throwList){
    //     String modifiedMoveName = move[0].replaceAll(RegExp(r'\d{1,2}$'), '');
    //     if(videoList[modifiedMoveName] == null){
    //       debugPrint("$modifiedMoveName 영상이 없음");
    //     }
    //   }
    //   debugPrint("${character.name}끝.");
    //   return true;
    // }());
    character.videoList = videoList;
  }
}

ThemeData themeData = ThemeData(
  buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
  textTheme: TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.w900)),
  fontFamily: changeFont ? Font.oneMobile.font : Font.tenada.font,
  useMaterial3: false,
  primarySwatch: Colors.pink,
);

Future<void> initializeSetting() async{

  if(!kIsWeb){
    if(isPro){
      await Hive.initFlutter();
    }else{
      await loadAd();
    }
  }

  for(var character in characterList){
    if(isPro) await Hive.openBox(character.name);
    final Map<String, List<Moves>> moves = {};
    final List<Throws> throws = [];
    var characterJson = jsonDecode(await rootBundle.loadString("assets/json/${character.name}.json"));

    for(var type in character.types.keys){
      moves.addAll({
        type : []
      });
      for(var move in characterJson['moves'][type]){
        moves[type]?.add(
            Moves(name: move['name'], command: move['command'], startFrame: move['start_frame'], guardFrame: move["guard_frame"], hitFrame: move['hit_frame'], counterFrame: move['counter_frame'], range: move['range'], damage: move['damage'], extra: move['extra'])
        );
      }
    }

    for(var moveThrow in characterJson['throws']){
      throws.add(
        Throws(name: moveThrow['name'], command: moveThrow['command'], startFrame: moveThrow['start_frame'], breakCommand: moveThrow['break_command'], afterBreakFrame: moveThrow['after_break_frame'], range: moveThrow['range'], damage: moveThrow['damage'], extra: moveThrow['extra'])
      );
    }

    character.moveList = moves;
    character.throwList = throws;
  }
  characterList.add(empty);

  //초기화
  SharedPreferences prefs = await SharedPreferences.getInstance();
  changeFont = prefs.getBool('changeFont') ?? false;
  language = prefs.getString('language') ?? "ko";
  final list = prefs.getStringList('bookmarkedList');
  if(list != null){
    for(String string in list) {
      bookmarkedList.add(PlayerInfo.fromJson(jsonDecode(string)));
    }
  }

  patchNotes = jsonDecode(await rootBundle.loadString("assets/internal/patch_note.json"));
}

bool changeFont = false;

late TabController tabController;

class Main extends StatefulWidget {
  final Function refresh;

  const Main({super.key, required this.refresh});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    if(!isPro) {
      loadAd();
    }

    tabController = TabController(length: tabList.length, vsync: this);
    tabController.addListener(() {
      setState(() {

      });
    });
  }

  List<Widget> tabList = [
    Container(
      color: const Color(0xff333333),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: SizedBox(
          width: 400,
          height: 3000,
          child: ListView.builder(
              itemCount: characterList.length ~/ 2,
              itemBuilder: (BuildContext ctx, int idx) {
                return Column(
                  children: [
                    CharacterButton(
                        character1: characterList[idx * 2],
                        character2: characterList[idx * 2 + 1]
                    )
                  ],
                );
              }
          ),
        ),
      ),
    ),
    TipPage(),
    SearchPage()
  ];


  @override
  Widget build(BuildContext context) {
    debugPrint("메인 빌드됨.");
    return MyUpgradeAlert(
      child: Scaffold(
        drawer: DrawerWidget(tabController: tabController,),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          elevation: 0.0,
          title: Text("FRAMEDATA"),
          centerTitle: true,
            actions: [
              actionBuilder(context: context, refresh: widget.refresh)
            ],
            backgroundColor: Colors.black,
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: tabList
          ),
          bottomNavigationBar: !isPro ? Container(
            color: Colors.black,
            width: banner.size.width.toDouble(),
            height: banner.size.height.toDouble(),
            child: AdWidget(ad: banner,),
          ) : null
        ),
    );
  }
}

class CharacterButton extends StatefulWidget {

  final Character character1, character2;

  const CharacterButton({super.key, required this.character1, required this.character2});

  @override
  State<CharacterButton> createState() => _CharacterButtonState();
}

class _CharacterButtonState extends State<CharacterButton> {
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          width: 150,
          height: 60,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black), ),
            onPressed: (){
              GetContents(widget.character1).makeCharacterVideoUrlList();
              Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterPage(character: widget.character1,)));
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character1.name.toUpperCase(), textAlign: TextAlign.center, textScaler: const TextScaler.linear(1))
              ],
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: 150,
          height: 60,
          child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black), ),
              onPressed: (){
              widget.character2 != empty ?{
              GetContents(widget.character2).makeCharacterVideoUrlList(),
              Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterPage(character: widget.character2)))
              }
              : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("제작중입니다.")));
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character2.name.toUpperCase(), textAlign: TextAlign.center, textScaler: const TextScaler.linear(1))
              ],
            )
          ),
        ),
      ],
    );
  }
}