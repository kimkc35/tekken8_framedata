// import 'dart:developer';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
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
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;
import 'dart:convert';
import 'characterWidget.dart';
import 'firebase_options.dart' ;
import 'modules.dart';
import 'tipScreen.dart';
import 'upgradeAlertWidget.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

const bool isPro = false;

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

  @override
  Widget build(BuildContext context) {
    CustomThemeMode.instance;
    return ValueListenableBuilder(
      valueListenable: CustomThemeMode.currentThemeData,
      builder: (context, value, child) {
        return MaterialApp(
          navigatorObservers: <NavigatorObserver>[FirebaseAnalyticsObserver(analytics: analytics)],
          theme: value,
          home: Main(),
        );
      },
    );
  }
}

class CustomThemeMode {
  static final CustomThemeMode instance = CustomThemeMode._internal();
  static ValueNotifier<bool> fontChanged = ValueNotifier(true);
  static ValueNotifier<ThemeData> currentThemeData = ValueNotifier(CustomThemeData.oneMobile);
  factory CustomThemeMode() => instance;

  static void initSetting() {
    currentThemeData.value = fontChanged.value ? CustomThemeData.oneMobile : CustomThemeData.tenada;
  }

  static void changeFont() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    switch (fontChanged.value) {
      case false:
        fontChanged.value = true;
        currentThemeData.value = CustomThemeData.oneMobile;
        preferences.setBool("changeFont", fontChanged.value);
        break;
      case true:
        fontChanged.value = false;
        currentThemeData.value = CustomThemeData.tenada;
        preferences.setBool("changeFont", fontChanged.value);
        break;
      default:
    }
  }

  CustomThemeMode._internal();
}

class CustomThemeData {
  static final ThemeData oneMobile = ThemeData(
    buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
    fontFamily: Font.oneMobile.font,
    useMaterial3: false,
    primarySwatch: Colors.pink,
  );

  static final ThemeData tenada = ThemeData(
    buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
    fontFamily: Font.tenada.font,
    useMaterial3: false,
    primarySwatch: Colors.pink,
  );
}

Future<void> initializeSetting() async{

  for(String url in characterImageUrls.values){
    CachedNetworkImageProvider(url);
  }

  if(!kIsWeb){
    if(isPro){
      await Hive.initFlutter();
    }else{
      await loadAd();
    }
  }

  for(var character in characterList){

    if(isPro && !kIsWeb) await Hive.openBox(character.name);
    final Map<String, List<MoveInfo>> moveInfoList = {};
    final List<ThrowInfo> throwInfoList = [];
    var characterJson = jsonDecode(await rootBundle.loadString("assets/json/${character.name}.json"));

    for(var type in character.types.keys){
      moveInfoList.addAll({
        type : []
      });
      for(var moveJson in characterJson['moves'][type]){
        try {
          moveInfoList[type]!.add(
              MoveInfo(name: moveJson['name'], command: moveJson['command'], startFrame: moveJson['start_frame'], guardFrame: moveJson["guard_frame"], hitFrame: moveJson['hit_frame'], counterFrame: moveJson['counter_frame'], range: moveJson['range'], damage: moveJson['damage'], extra: moveJson['extra'], startAt: moveJson['startAt'] ?? 0, endAt: moveJson['endAt'])
          );
        } catch(e) {
          debugPrint("$moveJson에서 오류, $e");
        }
      }
    }

    for(var throwJson in characterJson['throws']){
      try {
        throwInfoList.add(
          ThrowInfo(name: throwJson['name'], command: throwJson['command'], startFrame: throwJson['start_frame'], breakCommand: throwJson['break_command'], afterBreakFrame: throwJson['after_break_frame'], range: throwJson['range'], damage: throwJson['damage'], extra: throwJson['extra'], startAt: throwJson['startAt'] ?? 0, endAt: throwJson['endAt'])
        );
      } catch(e) {
        debugPrint("$throwJson에서 오류, $e");
      }
    }

    character.moveInfoList = moveInfoList;
    character.throwInfoList = throwInfoList;
  }
  characterList.add(empty);

  //초기화
  SharedPreferences prefs = await SharedPreferences.getInstance();
  CustomThemeMode.fontChanged.value = prefs.getBool("changeFont") ?? false;
  CustomThemeMode.initSetting();
  language = prefs.getString('language') ?? "ko";
  final initialBookmarkedList = prefs.getStringList('bookmarkedList');

  if (initialBookmarkedList != null) {
    for(int i = 0; i < initialBookmarkedList.length; i++){
      if(initialBookmarkedList[i].contains("url")){
        initialBookmarkedList[i] = initialBookmarkedList[i].replaceAll("url", "number");
        prefs.setStringList('bookmarkedList', initialBookmarkedList);
      }
    }
  }

  if(initialBookmarkedList != null){
    for(String string in initialBookmarkedList) {
      bookmarkedList.add(PlayerInfo.fromJson(jsonDecode(string)));
    }
  }

  patchNotes = jsonDecode(await rootBundle.loadString("assets/internal/patch_note.json"));
}

late TabController tabController;

class Main extends StatefulWidget {

  const Main({super.key});

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
              actionBuilder(context: context)
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

class PentagonPainter extends CustomPainter
{
  const PentagonPainter();

  @override
  void paint(Canvas canvas, Size size) {

    getPath(double x, double y){
      Path path = Path()
          ..moveTo(x/2, 0)
          ..lineTo(x, 0)
          ..lineTo(0, y)
          ..lineTo(0, y/2)
          ..lineTo(x/2, 0)
          ..close();

      return path;
    }

    Paint paint = Paint()
      ..color = CustomThemeMode.currentThemeData.value.primaryColor
      ..strokeWidth = 3
    ..style = PaintingStyle.stroke;


    // rotate the canvas
    const degrees = 45;
    const radians = degrees * math.pi / 180;
    canvas.rotate(radians);

    canvas.drawPath(getPath(200, 200), paint);

    // draw the text
    final textSpan = TextSpan(text: 'S1');
    TextPainter(text: textSpan, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: size.width)
      ..paint(canvas, Offset(-20, -20));



  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
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
              style: ButtonStyle(

                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black), ),
                onPressed: (){
                widget.character2 != empty ?
                Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterPage(character: widget.character2)))
              : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("제작중입니다.")));
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character2.name.toUpperCase(), textAlign: TextAlign.center, textScaler: const TextScaler.linear(1)),
              ],
            )
          ),
        ),
      ],
    );
  }
}