import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'jin_moves.dart' as jin;
import 'kazuya_moves.dart' as kazuya;
import 'paul_moves.dart' as paul;
import 'claudio_moves.dart' as claudio;
import 'bryan_moves.dart' as bryan;
import 'hwoarang_moves.dart' as hwoarang;
import 'king_moves.dart' as king;
import 'feng_moves.dart' as feng;
import 'asuka_moves.dart' as asuka;
import 'azucena_moves.dart' as azucena;
import 'jack-8_moves.dart' as jack;
import 'jun_moves.dart' as jun;
import 'lars_moves.dart' as lars;
import 'law_moves.dart' as law;
import 'leroy_moves.dart' as leroy;
import 'lili_moves.dart' as lili;
import 'nina_moves.dart' as nina;
import 'raven_moves.dart' as raven;
import 'xiaoyu_moves.dart' as xiaoyu;
import 'alisa_moves.dart' as alisa;
import 'devil jin_moves.dart' as devjin;
import 'dragunov_moves.dart' as dragunov;
import 'lee_moves.dart' as lee;
import 'leo_moves.dart' as leo;
import 'kuma_moves.dart' as kuma;
import 'steve_moves.dart' as steve;
import 'panda_moves.dart' as panda;
import 'reina_moves.dart' as reina;
import 'shaheen_moves.dart' as shaheen;
import 'victor_moves.dart' as victor;
import 'yoshimitsu_moves.dart' as yoshimitsu;
import 'zafina_moves.dart' as zafina;

const bool isPro = false;

bool isFirst = true;

String language = "ko";

String description = "";
String patchNote = "";

AdManagerInterstitialAd? interstitialAd;

const sticks = {"c1" : "↙", "c2" : "↓", "c3" : "↘", "c4" : "←", "c5" : "N", "c6" : "→", "c7" : "↖", "c8" : "↑", "c9" : "↗"};

final BannerAd _banner = BannerAd(
    adUnitId: 'ca-app-pub-3256415400287290/4169383092',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => print('Ad opened.'),
      onAdClosed: (Ad ad) => print('Ad closed.'),
      onAdImpression: (Ad ad) => print('Ad impression.'),
    )
)..load();

final Map moves = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};
final throws = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};

final movesEn = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};
final throwsEn = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};

final types = {
  "alisa": alisa.types,
  "asuka": asuka.types,
  "azucena": azucena.types,
  "bryan": bryan.types,
  "claudio": claudio.types,
  "devil jin": devjin.types,
  "dragunov": dragunov.types,
  "feng": feng.types,
  "hwoarang": hwoarang.types,
  "jack-8": jack.types,
  "jin": jin.types,
  "jun": jun.types,
  "kazuya": kazuya.types,
  "king": king.types,
  "kuma": kuma.types,
  "lars": lars.types,
  "law": law.types,
  "lee": lee.types,
  "leo": leo.types,
  "leroy": leroy.types,
  "lili": lili.types,
  "nina": nina.types,
  "panda": panda.types,
  "paul": paul.types,
  "raven": raven.types,
  "reina": reina.types,
  "shaheen": shaheen.types,
  "steve": steve.types,
  "victor": victor.types,
  "xiaoyu": xiaoyu.types,
  "yoshimitsu": yoshimitsu.types,
  "zafina": zafina.types
};

final characterExtraInitials = {
  "alisa": alisa.extraInitials,
  "asuka": asuka.extraInitials,
  "azucena": azucena.extraInitials,
  "bryan": bryan.extraInitials,
  "claudio": claudio.extraInitials,
  "devil jin": devjin.extraInitials,
  "dragunov": dragunov.extraInitials,
  "feng": feng.extraInitials,
  "hwoarang": hwoarang.extraInitials,
  "jack-8": jack.extraInitials,
  "jin": jin.extraInitials,
  "jun": jun.extraInitials,
  "kazuya": kazuya.extraInitials,
  "king": king.extraInitials,
  "kuma": kuma.extraInitials,
  "lars": lars.extraInitials,
  "law": law.extraInitials,
  "lee": lee.extraInitials,
  "leo": leo.extraInitials,
  "leroy": leroy.extraInitials,
  "lili": lili.extraInitials,
  "nina": nina.extraInitials,
  "panda": panda.extraInitials,
  "paul": paul.extraInitials,
  "raven": raven.extraInitials,
  "reina": reina.extraInitials,
  "shaheen": shaheen.extraInitials,
  "steve": steve.extraInitials,
  "victor": victor.extraInitials,
  "xiaoyu": xiaoyu.extraInitials,
  "yoshimitsu": yoshimitsu.extraInitials,
  "zafina": zafina.extraInitials
};

Map<String, Widget> characterFunctionList = {
  "ALISA" : alisa.Main(moves: moves["alisa"], throws: throws["alisa"]),
  "ASUKA" : asuka.Main(moves: moves["asuka"], throws: throws["asuka"]),
  "AZUCENA" : azucena.Main(moves: moves["azucena"], throws: throws["azucena"]),
  "BRYAN" : bryan.Main(moves: moves["bryan"], throws: throws["bryan"]),
  "CLAUDIO" : claudio.Main(moves: moves["claudio"], throws: throws["claudio"]),
  "DEVIL JIN" : devjin.Main(moves: moves["devil jin"], throws: throws["devil jin"]),
  "DRAGUNOV" : dragunov.Main(moves: moves["dragunov"], throws: throws["dragunov"]),
  "FENG" : feng.Main(moves: moves["feng"], throws: throws["feng"]),
  "HWOARANG" : hwoarang.Main(moves: moves["hwoarang"], throws: throws["hwoarang"]),
  "JACK-8" : jack.Main(moves: moves["jack-8"], throws: throws["jack-8"]),
  "JIN" : jin.Main(moves: moves["jin"], throws: throws["jin"]),
  "JUN" : jun.Main(moves: moves["jun"], throws: throws["jun"]),
  "KAZUYA" : kazuya.Main(moves: moves["kazuya"], throws: throws["kazuya"]),
  "KING" : king.Main(moves: moves["king"], throws: throws["king"]),
  "KUMA" : kuma.Main(moves: moves["kuma"], throws: throws["kuma"]),
  "LARS" : lars.Main(moves: moves["lars"], throws: throws["lars"]),
  "LAW" : law.Main(moves: moves["law"], throws: throws["law"]),
  "LEE" : lee.Main(moves: moves["lee"], throws: throws["lee"]),
  "LEO" : leo.Main(moves: moves["leo"], throws: throws["leo"]),
  "LEROY" : leroy.Main(moves: moves["leroy"], throws: throws["leroy"]),
  "LILI" : lili.Main(moves: moves["lili"], throws: throws["lili"]),
  "NINA" : nina.Main(moves: moves["nina"], throws: throws["nina"]),
  "PANDA" : panda.Main(moves: moves["panda"], throws: throws["panda"]),
  "PAUL" : paul.Main(moves: moves["paul"], throws: throws["paul"]),
  "RAVEN" : raven.Main(moves: moves["raven"], throws: throws["raven"]),
  "REINA" : reina.Main(moves: moves["reina"], throws: throws["reina"]),
  "SHAHEEN" : shaheen.Main(moves: moves["shaheen"], throws: throws["shaheen"],),
  "STEVE" : steve.Main(moves: moves["steve"], throws: throws["steve"]),
  "VICTOR" : victor.Main(moves: moves["victor"], throws: throws["victor"]),
  "XIAOYU" : xiaoyu.Main(moves: moves["xiaoyu"], throws: throws["xiaoyu"]),
  "YOSHIMITSU": yoshimitsu.Main(moves: moves["yoshimitsu"], throws: throws["yoshimitsu"]),
  "ZAFINA": zafina.Main(moves: moves["zafina"], throws: throws["zafina"],)
};

final characterList = [
  "ALISA",
  "ASUKA",
  "AZUCENA",
  "BRYAN",
  "CLAUDIO",
  "DEVIL JIN",
  "DRAGUNOV",
  "FENG",
  "HWOARANG",
  "JACK-8",
  "JIN",
  "JUN",
  "KAZUYA",
  "KING",
  "KUMA",
  "LARS",
  "LAW",
  "LEE",
  "LEO",
  "LEROY",
  "LILI",
  "NINA",
  "PANDA",
  "PAUL",
  "RAVEN",
  "REINA",
  "SHAHEEN",
  "STEVE",
  "VICTOR",
  "XIAOYU",
  "YOSHIMITSU",
  "ZAFINA"
];

class GetContents { // 리스트 구성

  List moveFiles = [
    "move_names", "move_commands", "move_start_frames", "move_guard_frames", "move_hit_frames", "move_counter_frames", "move_ranges", "move_damages", "move_extras"
  ];

  List throwFiles = [
    "throw_names", "throw_commands", "throw_start_frames", "throw_break_commands", "throw_after_break_frames", "throw_damages", "throw_ranges", "throw_extras"
  ];

  Future _loadFile(fileName, character) async {
    return await rootBundle.loadString("assets/$character/$fileName.txt");
  }

  Future<List> _loadList(fileName, character) async {
    final String text = await _loadFile(fileName, character);
    return text.split(" | ");
  }

  Future<List> getMoveList(List types, String character) async {
    var list = [];
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
        if(i == 0 && language == "ko"){
          await _loadList(moveFiles[i], character).then((value) =>
          {
            //디버그
            if(character == "feng"){
              debugPrint("$character, ${moveFiles[i]}, ${types[j]} : ${value[j].toString().split(", ").length}"),
            },
            for(int k = 0; k < value[j].toString().split(", ").length; k++){
              list[j]["contents"].add([(value[j].toString().split(", ")[k])]),
            },
          });
        }else if(i == 0 && language == "en"){
          await _loadList(moveFiles[i] + "_en", character).then((value) =>
          {
            //디버그
            // if(character == "zafina"){
            //   debugPrint("$character, ${moveFiles[i]}, ${types[j]} : ${value[j].toString().split(", ").length}"),
            // },
            for(int k = 0; k < value[j].toString().split(", ").length; k++){
              list[j]["contents"].add([(value[j].toString().split(", ")[k])]),
            },
          });
        }else{
          await _loadList(moveFiles[i], character).then((value) =>
          {
            //디버그
            // if(character == "feng"){
            //   debugPrint("$character, ${moveFiles[i]}, ${types[j]} : ${value[j].toString().split(", ").length}"),
            // },
            for(int k = 0; k < value[j].toString().split(", ").length; k++){
              list[j]["contents"][k].add(value[j].toString().split(", ")[k]),
            },
          });
        }
      }
    }
    return list;
  }

  Future<List> getThrowList(String character, {bool isKo = true}) async {
    List<List<String>> throwList = [];
    var valueList;
    for (int i = 0; i < throwFiles.length; i++){
      String fileContents = await _loadFile(throwFiles[i], character);
      valueList = fileContents.split(", ");
      for (int j = 0; j < valueList.length; j++){
        throwList.length <= j? throwList.add([valueList[j]]) : throwList[j].add(valueList[j]);
      }
    }
    return throwList;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  //초기화
  SharedPreferences prefs = await SharedPreferences.getInstance();
  changeFont = prefs.getBool('changeFont') ?? false;
  mainFont = changeFont ? 'OneMobile' : 'Tenada';
  language = prefs.getString('language') ?? "ko";
  isFirst = prefs.getBool('isFirst') ?? true;

  for (int i = 0; i < characterList.length; i++) {
    // debugPrint("${i + 1}번째 : ${characterList[i].toLowerCase()} 하고 ${characterList[i].toLowerCase()}"); //디버그
    try{
      await GetContents().getMoveList(types[characterList[i].toLowerCase()]!, characterList[i].toLowerCase()).then((value) => {
        for(var types in value){
          for(var contents in types["contents"]){
            for(int i = 1; i <= sticks.length; i++){
              contents[1] = contents[1].toString().replaceAll("$i ", sticks["c$i"].toString()),
              contents[8] = contents[8].toString().replaceAll("$i ", sticks["c$i"].toString())
            },
            contents[8] = contents[8].toString().replaceAll("-", "").replaceAll("/", "\n").replaceAll("-", "").replaceAll("hyphen", "-")
          }
        },
        for(var extraInitial in characterExtraInitials.entries){
          for(var types in value){
            for(var contents in types["contents"]){
              for(int i = 0; i < extraInitial.value.length; i++){
                contents[8] = contents[8].toString().replaceAll(extraInitial.value[i]["name"].toString(), extraInitial.value[i][extraInitial.value[i]["name"]].toString()).replaceAll("/", "\n")
              }
            }
          }
        },
        moves.addAll({characterList[i].toLowerCase() : value}),
      });
      await GetContents().getThrowList(characterList[i].toLowerCase()).then((
          value) =>
      {
        for(var contents in value){
          for(int i = 1; i <= sticks.length; i++){
            contents[1] = contents[1].toString().replaceAll("$i ", sticks["c$i"].toString()),
            contents[7] = contents[7].toString().replaceAll("$i ", sticks["c$i"].toString()),
          },
          contents[1] = contents[1].toString().replaceAll("delete", ""),
          contents[7] = contents[7].toString().replaceAll("-", "").replaceAll("/", "\n").replaceAll("-", "").replaceAll("hyphen", "-").replaceAll("delete", "")
        },
        throws.addAll({characterList[i].toLowerCase() : value})
      });
    }catch(e){
      debugPrint("${characterList[i]}에서 오류 : $e");
    }
  }
  GetContents()._loadFile("description", "internal").then((value) => description = value);
  GetContents()._loadFile("patch note", "internal").then((value) => patchNote = replaceNumbers(value));

  if(isPro){
    await Hive.initFlutter();
    for (int i = 0; i < characterList.length; i++) {
      await Hive.openBox(characterList[i]);
    }
  }

  runApp(
     MyApp()
  );
}

String mainFont = "Tenada";

final themeData = ThemeData(
    buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
    fontFamily: mainFont,
    textTheme: TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.w900)),
    useMaterial3: false,
    primarySwatch: Colors.pink
);

const double keyboardFontSize = 10;

String replaceNumbers(String text){
  String result = text;
  for (int i = 0; i < sticks.length; i ++){
    result = result.replaceAll("${i + 1} ", "${sticks["c${i + 1}"]}");
  }

  return result;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(home: Main(), theme: themeData);
  }
}

Row actionBuilder(BuildContext context){
  return Row(
    children: [
      GestureDetector(
        onTap: () => showDialog<String>(context: context, builder: (context) => AlertDialog(title: Text("설명", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: mainFont)), contentTextStyle: TextStyle(height: 1.5, fontSize: 15, color: Colors.black, fontFamily: mainFont),
          content: Text(description),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('닫기'))
          ],
        )),
        child: const Icon(Icons.abc),
      ),
      GestureDetector(
        onTap: () => showDialog<String>(context: context, builder: (context) => AlertDialog(title: Text("v1.02.01 패치노트", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: TextStyle(fontFamily: mainFont, height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: TextStyle(fontFamily: mainFont, color: Colors.black),
          content: SingleChildScrollView(child: Text(patchNote)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('닫기'))
          ],
        )),
        child: const Icon(Icons.article),
      ),
    ],
  );
}

memo (BuildContext context, String character, name) {
  TextEditingController controller = TextEditingController();

  var currentBox = Hive.box(character);
  if(currentBox.containsKey(name)){
    controller.text = currentBox.get(name);
  }

  showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(title: Text("${character.toUpperCase()}, $name", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: TextStyle(fontFamily: mainFont, height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: TextStyle(fontFamily: mainFont, color: Colors.black),
      content: SingleChildScrollView(child: TextField(onChanged: (value) {
        currentBox.put(name, value);
      },controller:controller,maxLines: null, decoration: const InputDecoration(hintText: "원하는 내용을 입력하세요!", border: null))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('닫기'))
      ],
    ));
}

bool changeFont = false;

class SettingDialog extends StatefulWidget {
  const SettingDialog({super.key});

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

//설정
class _SettingDialogState extends State<SettingDialog> {

  void saveFontSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('changeFont', changeFont);
    setState(() {
      mainFont = changeFont ? 'OneMobile' : 'Tenada';
    });
  }

  void saveLanguageSetting(setLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = setLanguage;
    });
    prefs.setString('language', language);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(language == "ko"?"설정" : "Setting", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: TextStyle(fontFamily: mainFont, height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: TextStyle(fontFamily: mainFont, color: Colors.black),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(language == 'ko'?"폰트 바꾸기" : "Change Font"),
                Switch(value: changeFont, onChanged: (value) {
                  setState(() {
                    changeFont = value;
                  });
                  saveFontSetting();
                })
              ],
            ),
            // Row(
            //   children: [
            //     Icon(Icons.translate),
            //     DropdownButton(value: language, items: [DropdownMenuItem(value: "ko", child: Text("한국어"),), DropdownMenuItem(value: "en", child: Text("English"),)], onChanged: (value) => saveLanguageSetting(value))
            //   ],
            // ),
            Text(language == "ko"? "설정은 재시작을 해야 전부 적용됩니다." : "All settings will take effect after a restart."),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Restart.restartApp(), child: Text(language == "ko"? '재시작' : "Restart")),
        TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text( language == "ko"? '닫기' : 'Close'))
      ],
    );
  }
}


class Main extends StatefulWidget {

  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  void changeIsFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirst = false;
    prefs.setBool('isFirst', isFirst);
  }

  final Uri _url = Uri.parse("https://play.google.com/store/apps/details?id=com.tk8.framedata.vpro");

  @override
  void initState() {
    super.initState();
    if(!isPro) {
      loadAd();
      if(isFirst){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          changeIsFirst();
          showDialog(context: context, builder: (context) => AlertDialog(title: Text("프로버전 출시!", style: TextStyle(fontSize: 20, color: Colors.black)),
            content: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(onTap: (){
                    launchUrl(_url);
                  },child: Text("클릭해서 이동하세요!", style: TextStyle(fontSize: 15, color: Colors.lightBlue),)),
                  Text("한번 창을 닫으면 더이상 뜨지 않습니다.", style: TextStyle(fontSize: 15))
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text( language == "ko"? '닫기' : 'Close'))
            ],
          ));
        });
      }
    }
  }

  Widget setting() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => showDialog<String>(context: context, barrierDismissible: false, builder: (context) => SettingDialog()),
          child: const Icon(Icons.settings),
        )
      ],
    );
  }

  void loadAd() {
    AdManagerInterstitialAd.load(
        adUnitId: 'ca-app-pub-3256415400287290/6923530178',
        request: const AdManagerAdRequest(),
        adLoadCallback: AdManagerInterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('AdManagerInterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    if(isPro){
      return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leadingWidth: 120,
                title: const Text("FRAMEDATA"),
                centerTitle: true,
                actionsIconTheme: const IconThemeData(size: 40),
                actions: [
                  actionBuilder(context),
                  setting()
                ],
                backgroundColor: Colors.black,
              ),
              body: Container(
                color: const Color(0xff333333),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 3000,
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext ctx, int idx) {
                          return Column(
                            children: [
                              for(int i = 0; i < characterList.length / 2; i++)...[
                                CharacterButton(
                                    character1: characterList[2 * i],
                                    character2: characterList[2 * i + 1]
                                )
                              ]
                            ],
                          );
                        }
                    ),
                  ),
                ),
              )
          );
    }
    return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 120,
            title: const Text("FRAMEDATA"),
            centerTitle: true,
            actionsIconTheme: const IconThemeData(size: 40),
            actions: [
              actionBuilder(context),
              setting()
            ],
            backgroundColor: Colors.black,
          ),
          body: Container(
            color: const Color(0xff333333),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SizedBox(
                width: 400,
                height: 3000,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext ctx, int idx) {
                    return Column(
                      children: [
                        for(int i = 0; i < characterList.length / 2; i++)...[
                          CharacterButton(
                              character1: characterList[2 * i],
                              character2: characterList[2 * i + 1]
                          )
                        ]
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.black,
            width: _banner.size.width.toDouble(),
            height: _banner.size.height.toDouble(),
            child: AdWidget(ad: _banner,),
          )
        );
  }
}

class CharacterButton extends StatefulWidget {

  final String character1, character2;

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
              if(characterFunctionList[widget.character1] != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => characterFunctionList[widget.character1]!));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("제작중입니다.")));
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character1, textAlign: TextAlign.center, textScaler: const TextScaler.linear(1))
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
                if(characterFunctionList[widget.character2] != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => characterFunctionList[widget.character2]!));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("제작중입니다.")));
                }
              },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character2, textAlign: TextAlign.center, textScaler: const TextScaler.linear(1))
              ],
            )
          ),
        ),
      ],
    );
  }
}