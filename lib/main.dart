import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';
import 'actionBuilderWidget.dart';
import 'character_variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'characterWidget.dart';
import 'upgradeAlertWidget.dart';

const bool isPro = false;

bool isFirst = true;

String language = "ko";

late Map<String, dynamic> patchNote;

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

const List moveFiles = [
  "move_names", "move_commands", "move_start_frames", "move_guard_frames", "move_hit_frames", "move_counter_frames", "move_ranges", "move_damages", "move_extras"
];

const List throwFiles = [
  "throw_names", "throw_commands", "throw_start_frames", "throw_break_commands", "throw_after_break_frames", "throw_damages", "throw_ranges", "throw_extras"
];

main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeSetting();

  runApp(
     MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(), 
      theme: themeData
   );
  }
}

class GetContents { // 리스트 구성

  Character character;

  GetContents(this.character);

  Future _loadCharcterFile(fileName) async {
    return await rootBundle.loadString("assets/${character.name}/$fileName.txt");
  }

  Future<List> _loadList(fileName) async {
    final String text = await _loadCharcterFile(fileName);
    return text.split(" | ");
  }

  Future<List<Map<String, dynamic>>> getMoveList(Map<String, bool> types) async {
    List<Map<String, dynamic>> moveList = [];
    int valueNum = 0;
    for(String type in types.keys) {
      moveList.addAll(
          {
            {
              "type": type,
              "contents": []
            }
          }
      );
      for (String file in moveFiles) {
        await _loadList(file).then((value) =>
        {
          //디버그
          // if(character.name == "kuma"){
          //   debugPrint("$character, $file, $type : ${mass.toString().split(", ").length}"),
          // },
          for(int i = 0; i < value[valueNum].toString().split(", ").length; i++){
            if(file == "move_names"){
              moveList.firstWhere((element) => element["type"] == type)["contents"].add([value[valueNum].toString().split(", ")[i]])
            }else{
              moveList.firstWhere((element) => element["type"] == type)["contents"][i].add(value[valueNum].toString().split(", ")[i])
            }
          }
          // for(int k = 0; k < value[j].toString().split(", ").length; k++){
          //   file == "move_names"? list[j]["contents"].add([value[j].toString().split(", ")[k]]) : list[j]["contents"][k].add(value[j].toString().split(", ")[k]),
          // },
        });
        //  late List temp;
        // if(language == "ko"){
        //   await _loadList(file, character).then((value) =>
        //   {
        //     //디버그
        //     if(character == "kuma"){
        //       debugPrint("$character, $file, ${types[j]} : ${value[j].toString().split(", ").length}"),
        //     },
        //     for(int k = 0; k < value[j].toString().split(", ").length; k++){
        //       file == "move_names"? list[j]["contents"].add([(value[j].toString().split(", ")[k])]) : list[j]["contents"][k].add((value[j].toString().split(", ")[k])),
        //     },
        //   });
        // }else if(language == "en"){
        //   if(file == "move_names" || file == "move_commands"){
        //     await _loadList("${file}_en", character).then((value) =>
        //     {
        //       //디버그
        //       // if(character == "zafina"){
        //       //   debugPrint("$character, ${moveFiles[i]}, ${types[j]} : ${value[j].toString().split(", ").length}"),
        //       // },
        //       for(int k = 0; k < value[j].toString().split(", ").length; k++){
        //         if(file == "move_names"){
        //           temp = value[j].toString().replaceAll("일어서며", "WS").replaceAll("횡이동 중", "SS").replaceAll("몸을 숙인 상태에서", "FC").replaceAll("상대에게 등을 보일 때", "BT")
        //               .replaceAll("상대가 쓰러져 있을 때", "OTG").replaceAll("홀드", "Hold").replaceAll("히트 혹은 가드 시", "Hit or Guard").replaceAll("히트 시", "Hit").replaceAll("가드 시", "Guard")
        //               .replaceAll("카운터 히트", "Counter Hit").replaceAll("히트 상태에서", "Heat").replaceAll("엎드려 쓰러져 있을 때", "FDFT").replaceAll("누워 쓰러져 있을 때", "FUFT")
        //               .split(", "),
        //           list[j]["contents"][k].add((temp[k])),
        //         }else{
        //           list[j]["contents"].add([(value[j].toString().split(", ")[k])]),
        //         }
        //       },
        //     });
        //   }else{
        //     await _loadList(file, character).then((value) =>
        //     {
        //       //디버그
        //       // if(character == "zafina"){
        //       //   debugPrint("$character, ${moveFiles[i]}, ${types[j]} : ${value[j].toString().split(", ").length}"),
        //       // },
        //       for(int k = 0; k < value[j].toString().split(", ").length; k++){
        //         if(file == "move_ranges"){
        //           temp = value[j].toString().replaceAll("상단", "H").replaceAll("중단", "M").replaceAll("하단", "L").replaceAll("가불", "UB").split(", "),
        //           list[j]["contents"][k].add((temp[k])),
        //         }else{
        //           list[j]["contents"][k].add((value[j].toString().split(", ")[k])),
        //         }
        //       },
        //     });
        //   }
        // }
      }
      valueNum++;
    }
    return moveList;
  }

  Future<List<List<String>>> getThrowList({bool isKo = true}) async {
    List<List<String>> throwList = [];
    List valueList;
    for (int i = 0; i < throwFiles.length; i++){
      String fileContents = await _loadCharcterFile(throwFiles[i]);
      valueList = fileContents.split(", ");
      //디버깅
      // character.name == "king"?debugPrint("$character의 ${throwFiles[i]} 길이 : ${valueList.length}"):null;
      for (int j = 0; j < valueList.length; j++){
        throwList.length <= j? throwList.add([valueList[j]]) : throwList[j].add(valueList[j]);
      }
    }
    return throwList;
  }

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

Future<void> initializeSetting() async{

  if(isPro){
    await Hive.initFlutter();
  }else{
    MobileAds.instance.initialize();
  }

  //초기화
  SharedPreferences prefs = await SharedPreferences.getInstance();
  changeFont = prefs.getBool('changeFont') ?? false;
  mainFont = changeFont ? 'OneMobile' : 'Tenada';
  language = prefs.getString('language') ?? "ko";

  for (Character character in characterList.skipWhile((value) => value.name == "")) {
    isPro ? await Hive.openBox(character.name) : null;
    // debugPrint("${i + 1}번째 : ${characterList[i]} 하고 ${characterList[i]}"); //디버그
    try{
      await GetContents(character).getMoveList(character.types).then((value) => {
        for(var type in value){
          for(var contents in type["contents"]){
            for(int i = 1; i <= sticks.length; i++){
              contents[1] = contents[1].toString().replaceAll("$i ", sticks["c$i"].toString()),
              contents[8] = contents[8].toString().replaceAll("$i ", sticks["c$i"].toString()).replaceAll("space", " ")
            },
            contents[8] = contents[8].toString().replaceAll("-", "").replaceAll("/", "\n").replaceAll("-", "").replaceAll("hyphen", "-")
          },
          for(var contents in type["contents"]){
            for(int i = 0; i < commonExtraInitials.length; i++){
              contents[8] = contents[8].toString().replaceAll(commonExtraInitials[i]["name"].toString(), commonExtraInitials[i][commonExtraInitials[i]["name"]].toString())
            }
          }
        },
        for(var extraInitial in character.extraInitials){
          for(var type in value){
            for(var contents in type["contents"]){
              for(int i = 0; i < extraInitial.values.length; i++){
                contents[8] = contents[8].toString().replaceAll(extraInitial["name"].toString(), extraInitial[extraInitial["name"]].toString()).replaceAll("/", "\n")
              }
            }
          }
        },
        character.moveList = value,
      });
      await GetContents(character).getThrowList().then((value) =>
      {
        for(var contents in value){
          for(int i = 1; i <= sticks.length; i++){
            contents[1] = contents[1].toString().replaceAll("$i ", sticks["c$i"].toString()),
            contents[7] = contents[7].toString().replaceAll("$i ", sticks["c$i"].toString()),
          },
          contents[1] = contents[1].toString().replaceAll("delete", ""),
          contents[7] = contents[7].toString().replaceAll("-", "").replaceAll("/", "\n").replaceAll("-", "").replaceAll("hyphen", "-").replaceAll("delete", "")
        },
        character.throwList = value,
      });
    }catch(e){
      debugPrint("${character.name}에서 오류 : $e");
    }
  }
  patchNote = jsonDecode(await rootBundle.loadString("assets/internal/patch_note.json"));
}

String mainFont = "Tenada";

final themeData = ThemeData(
  buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
  fontFamily: mainFont,
  textTheme: TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.w900)),
  useMaterial3: false,
  primarySwatch: Colors.pink,
);

String replaceNumbers(String text){
  String result = text;
  for (int i = 0; i < sticks.length; i ++){
    result = result.replaceAll("${i + 1} ", "${sticks["c${i + 1}"]}");
  }

  return result;
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
            //한국어
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

  @override
  void initState() {
    super.initState();
    if(!isPro) {
      loadAd();
    }
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
    return MyUpgradeAlert(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leadingWidth: 120,
          title: Text("FRAMEDATA"),
          centerTitle: true,

          actions: [
            actionBuilder(context, "", false)
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
            style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black), ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if(widget.character1.videoList == null) GetContents(widget.character1).makeCharacterVideoUrlList();
                return CharacterPage(character: widget.character1,);
              }));
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
              widget.character2 != empty?
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if(widget.character2.videoList == null) GetContents(widget.character2).makeCharacterVideoUrlList();
                return CharacterPage(character: widget.character2);
              }))
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