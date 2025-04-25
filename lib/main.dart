// import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'movesWidget.dart';
import 'firebase_options.dart' ;
import 'modules.dart';
import 'tipScreen.dart';
import 'upgradeAlertWidget.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

const bool isPro =
  kIsWeb? false :
  true;

bool isFirst = true;

const firebaseScreenName = [
  "home", "tip", "profile"
];

final BannerAd _banner = loadBannerAd()..load();

late Map<String, dynamic> patchNotes;

List<PlayerInfo> bookmarkedList = [];

const sticks = {"c1" : "↙", "c2" : "↓", "c3" : "↘", "c4" : "←", "c5" : "N", "c6" : "→", "c7" : "↖", "c8" : "↑", "c9" : "↗"};

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  await initializeSetting();

  FirebaseAnalytics.instance.logScreenView(screenName: firebaseScreenName[0]);

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ko')],
        path: 'assets/localizations',
        fallbackLocale: Locale('en'),
        child: MyApp()
    ),
  );
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
    fontFamily: Font.oneMobileTitle.font,
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
      MobileAds.instance.initialize();
      loadInterstitialAd();
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
              MoveInfo(name: moveJson['name'], command: moveJson['command'], startFrame: moveJson['start_frame'], guardFrame: moveJson["guard_frame"], hitFrame: moveJson['hit_frame'], counterFrame: moveJson['counter_frame'], range: moveJson['range'], damage: moveJson['damage'], extra: moveJson['extra'], startAt: moveJson['startAt'] ?? 0, endAt: moveJson['endAt'], color: moveJson['color'], extraVideo: moveJson['extraVideo'])
          );
        } catch(e) {
          debugPrint("$moveJson에서 오류, $e");
        }
      }
    }

    for(var throwJson in characterJson['throws']){
      try {
        throwInfoList.add(
          ThrowInfo(name: throwJson['name'], command: throwJson['command'], startFrame: throwJson['start_frame'], breakCommand: throwJson['break_command'], afterBreakFrame: throwJson['after_break_frame'], range: throwJson['range'], damage: throwJson['damage'], extra: throwJson['extra'], startAt: throwJson['startAt'] ?? 0, endAt: throwJson['endAt'], color: throwJson['color'], extraVideo: throwJson['extraVideo'])
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
  //localization
  // if(!prefs.containsKey("lang")){
  //   final deviceLocales = PlatformDispatcher.instance.locales;
  //   final currentLocale = deviceLocales[0].languageCode;
  //
  //   (currentLocale == "ko" || currentLocale == "en") ? prefs.setString("lang", currentLocale) : prefs.setString("lang", "en");
  //   lang = prefs.getString("lang")!;
  // }else{
  //   lang = prefs.getString("lang")!;
  // }

  if(prefs.containsKey('bookmarkedList')){
    final initialBookmarkedList = prefs.getStringList('bookmarkedList')!;
    debugPrint(prefs.getStringList('bookmarkedList').toString());

    for(String string in initialBookmarkedList) {
      try{
        bookmarkedList.add(PlayerInfo.fromJson(jsonDecode(string)));
      }catch(e){
        initialBookmarkedList.remove(string);
      }
    }
    prefs.setStringList('bookmarkedList', initialBookmarkedList);
  }

  patchNotes = jsonDecode(await rootBundle.loadString("assets/internal/patch_note.json"));
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
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorObservers: <NavigatorObserver>[FirebaseAnalyticsObserver(analytics: analytics)],
          theme: value,
          home: Main(),
        );
      },
    );
  }
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

    tabController = TabController(length: tabList.length, vsync: this);
    tabController.addListener(() {
      setState(() {

      });
    });
  }

  List<Widget> tabList = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.fill)
        // gradient: RadialGradient(
        //   colors: [Color(0xff345c6d), Color(0xff020108)],
        //   stops: [0, 1],
        //   radius: 0.9
        // )
      ),
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
          title: Text("FRAMEDATA", style: TextStyle(fontFamily: "Tenada"),),
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
            width: _banner.size.width.toDouble(),
            height: _banner.size.height.toDouble(),
            child: AdWidget(ad: _banner,),
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
            style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => Colors.black), ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterPage(character: widget.character1,)));
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character1.name.toUpperCase(), textAlign: TextAlign.center, textScaler: const TextScaler.linear(1), style: TextStyle(fontFamily: "Tenada"))
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
                backgroundColor: WidgetStateColor.resolveWith((states) => Colors.black), ),
                onPressed: (){
                widget.character2 != empty ?
                Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterPage(character: widget.character2)))
              : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("main.empty").tr()));
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character2.name.toUpperCase(), textAlign: TextAlign.center, textScaler: const TextScaler.linear(1), style: TextStyle(fontFamily: "Tenada"),),
              ],
            )
          ),
        ),
      ],
    );
  }
}