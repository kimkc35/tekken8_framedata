import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

final moves = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : []};
final throws = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : []};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    const MyApp()
  );
}

final themeData = ThemeData(
    buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
    fontFamily: 'Tenada',
    useMaterial3: false,
    primarySwatch: Colors.pink
);

const double keyboardFontSize = 10;

final characterGetMoveList = {
  "alisa" : alisa.GetContents().getMoveList(),
  "asuka" : asuka.GetContents().getMoveList(),
  "azucena" : azucena.GetContents().getMoveList(),
  "bryan" : bryan.GetContents().getMoveList(),
  "claudio" : claudio.GetContents().getMoveList(),
  "devil jin" : devjin.GetContents().getMoveList(),
  "dragunov" : dragunov.GetContents().getMoveList(),
  "feng" : feng.GetContents().getMoveList(),
  "hwoarang" : hwoarang.GetContents().getMoveList(),
  "jack-8" : jack.GetContents().getMoveList(),
  "jin" : jin.GetContents().getMoveList(),
  "jun" : jun.GetContents().getMoveList(),
  "kazuya" : kazuya.GetContents().getMoveList(),
  "king" : king.GetContents().getMoveList(),
  "kuma" : kuma.GetContents().getMoveList(),
  "lars" : lars.GetContents().getMoveList(),
  "law" : law.GetContents().getMoveList(),
  "lee" : lee.GetContents().getMoveList(),
  "leo" : leo.GetContents().getMoveList(),
  "leroy" : leroy.GetContents().getMoveList(),
  "lili" : lili.GetContents().getMoveList(),
  "nina" : nina.GetContents().getMoveList(),
  "panda" : panda.GetContents().getMoveList(),
  "paul" : paul.GetContents().getMoveList(),
  "raven" : raven.GetContents().getMoveList(),
  "reina" : reina.GetContents().getMoveList(),
  "shaheen" : shaheen.GetContents().getMoveList(),
  "steve" : steve.GetContents().getMoveList(),
  "victor" : victor.GetContents().getMoveList(),
  "xiaoyu" : xiaoyu.GetContents().getMoveList()
};

final characterGetThrowList = {
  "alisa" : alisa.GetContents().getThrowList(),
  "asuka" : asuka.GetContents().getThrowList(),
  "azucena" : azucena.GetContents().getThrowList(),
  "bryan" : bryan.GetContents().getThrowList(),
  "claudio" : claudio.GetContents().getThrowList(),
  "devil jin" : devjin.GetContents().getThrowList(),
  "dragunov" : dragunov.GetContents().getThrowList(),
  "feng" : feng.GetContents().getThrowList(),
  "hwoarang" : hwoarang.GetContents().getThrowList(),
  "jack-8" : jack.GetContents().getThrowList(),
  "jin" : jin.GetContents().getThrowList(),
  "jun" : jun.GetContents().getThrowList(),
  "kazuya" : kazuya.GetContents().getThrowList(),
  "king" : king.GetContents().getThrowList(),
  "kuma" : kuma.GetContents().getThrowList(),
  "lars" : lars.GetContents().getThrowList(),
  "law" : law.GetContents().getThrowList(),
  "lee" : lee.GetContents().getThrowList(),
  "leo" : leo.GetContents().getThrowList(),
  "leroy" : leroy.GetContents().getThrowList(),
  "lili" : lili.GetContents().getThrowList(),
  "nina" : nina.GetContents().getThrowList(),
  "panda" : panda.GetContents().getThrowList(),
  "paul" : paul.GetContents().getThrowList(),
  "raven" : raven.GetContents().getThrowList(),
  "reina" : reina.GetContents().getThrowList(),
  "shaheen" : shaheen.GetContents().getThrowList(),
  "steve" : steve.GetContents().getThrowList(),
  "victor" : victor.GetContents().getThrowList(),
  "xiaoyu" : xiaoyu.GetContents().getThrowList()
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
  "XIAOYU" : xiaoyu.Main(moves: moves["xiaoyu"], throws: throws["xiaoyu"])
};

final characterList = ["ALISA", "ASUKA", "AZUCENA", "BRYAN", "CLAUDIO", "DEVIL JIN", "DRAGUNOV", "FENG", "HWOARANG", "JACK-8", "JIN", "JUN", "KAZUYA", "KING", "KUMA", "LARS", "LAW", "LEE", "LEO", "LEROY", "LILI", "NINA", "PANDA", "PAUL", "RAVEN", "REINA", "SHAHEEN", "STEVE", "VICTOR", "XIAOYU", "YOSHIMITSU", "ZAFINA"];

Future getFile(String fileName) async{
  return await rootBundle.loadString("assets/$fileName.txt");
}

class GetList{
  Future getCommandList(String character) async{
    var moveList;
    moveList = await characterGetMoveList[character];
    return await moveList;
  }

  Future getThrowList(String character) async{
    var throwList;
    throwList = await characterGetThrowList[character];
    return await throwList;
  }
}

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
    return Main(getList: GetList(),);
  }
}



class Main extends StatefulWidget {
  final GetList getList;

  const Main({super.key, required this.getList});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i < characterList.length; i++) {
        widget.getList.getCommandList(characterList[i].toString().toLowerCase()).then((
            value) =>
        {
          moves[characterList[i].toString().toLowerCase()] = value
        });
        widget.getList.getThrowList(characterList[i].toString().toLowerCase()).then((
            value) =>
        {
          throws[characterList[i].toString().toLowerCase()] = value,
        });
      }
      getFile("description").then((value) => description = value);
      getFile("patch note").then((value) => patchNote = replaceNumbers(value));
      loadAd();
    });
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
    return MaterialApp(
        theme: themeData,
        home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 120,
            title: const Text("FRAMEDATA"),
            centerTitle: true,
            actionsIconTheme: const IconThemeData(size: 40),
            actions: [
              Builder(
                builder: (context) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () => showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(title: const Text("설명", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: const TextStyle(fontFamily: "Tenada", height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: const TextStyle(fontFamily: "Tenada", color: Colors.black),
                          content: Text(description),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('닫기'))
                          ],
                        )),
                        child: const Icon(Icons.abc),
                      ),
                      GestureDetector(
                        onTap: () => showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(title: const Text("1.01.04V 패치노트", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: const TextStyle(fontFamily: "Tenada", height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: const TextStyle(fontFamily: "Tenada", color: Colors.black),
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
              )
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