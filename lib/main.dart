import 'package:flutter/material.dart';
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

const sticks = {"c1" : "↙", "c2" : "↓", "c3" : "↘", "c4" : "←", "c5" : "N", "c6" : "→", "c7" : "↖", "c8" : "↑", "c9" : "↗"};
final BannerAd _banner = BannerAd(
    adUnitId: 'ca-app-pub-3256415400287290/4169383092',
    size: AdSize.banner,
    request: AdRequest(),
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

final moves = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "lars" : [], "law" : [], "leroy" : [], "lili" : [], "nina" : [], "paul" : [], "raven" : [], "xiaoyu" : []};
final throws = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "lars" : [], "law" : [], "leroy" : [], "lili" : [], "nina" : [], "paul" : [], "raven" : [], "xiaoyu" : []};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    MyApp(getList: GetList())
  );
}

final themeData = ThemeData(
    buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
    fontFamily: 'Tenada',
    useMaterial3: false,
    primarySwatch: Colors.pink
);

const double keyboardFontSize = 10;

final characterGetMoveList = {"alisa" : alisa.GetContents().getMoveList(), "asuka" : asuka.GetContents().getMoveList(), "azucena" : azucena.GetContents().getMoveList(), "bryan" : bryan.GetContents().getMoveList(), "claudio" : claudio.GetContents().getMoveList(), "devil jin" : devjin.GetContents().getMoveList(), "dragunov" : dragunov.GetContents().getMoveList(), "feng" : feng.GetContents().getMoveList(), "hwoarang" : hwoarang.GetContents().getMoveList(), "jack-8" : jack.GetContents().getMoveList(), "jin" : jin.GetContents().getMoveList(), "jun" : jun.GetContents().getMoveList(), "kazuya" : kazuya.GetContents().getMoveList(), "king" : king.GetContents().getMoveList(), "lars" : lars.GetContents().getMoveList(), "law" : law.GetContents().getMoveList(), "leroy" : leroy.GetContents().getMoveList(), "lili" : lili.GetContents().getMoveList(), "nina" : nina.GetContents().getMoveList(), "paul" : paul.GetContents().getMoveList(), "raven" : raven.GetContents().getMoveList(), "xiaoyu" : xiaoyu.GetContents().getMoveList()};
final characterGetThrowList = {"alisa" : alisa.GetContents().getThrowList(), "asuka" : asuka.GetContents().getThrowList(), "azucena" : azucena.GetContents().getThrowList(), "bryan" : bryan.GetContents().getThrowList(), "claudio" : claudio.GetContents().getThrowList(), "devil jin" : devjin.GetContents().getThrowList(), "dragunov" : dragunov.GetContents().getThrowList(),  "feng" : feng.GetContents().getThrowList(), "hwoarang" : hwoarang.GetContents().getThrowList(), "jack-8" : jack.GetContents().getThrowList(), "jin" : jin.GetContents().getThrowList(), "jun" : jun.GetContents().getThrowList(), "kazuya" : kazuya.GetContents().getThrowList(), "king" : king.GetContents().getThrowList(), "lars" : lars.GetContents().getThrowList(), "law" : law.GetContents().getThrowList(), "leroy" : leroy.GetContents().getThrowList(), "lili" : lili.GetContents().getThrowList(), "nina" : nina.GetContents().getThrowList(), "paul" : paul.GetContents().getThrowList(), "raven" : raven.GetContents().getThrowList(), "xiaoyu" : xiaoyu.GetContents().getThrowList()};

Map<String, Widget> characterFunctionList = {"ALISA" : alisa.ALISA(moves: moves["alisa"], throws: throws["alisa"]), "ASUKA" : asuka.ASUKA(moves: moves["asuka"], throws: throws["asuka"]), "AZUCENA" : azucena.AZUCENA(moves: moves["azucena"], throws: throws["azucena"]), "BRYAN" : bryan.BRYAN(moves: moves["bryan"], throws: throws["bryan"]), "CLAUDIO" : claudio.CLAUDIO(moves: moves["claudio"], throws: throws["claudio"]), "DEVIL JIN" : devjin.DEVJIN(moves: moves["devil jin"], throws: throws["devil jin"]), "DRAGUNOV" : dragunov.DRAGUNOV(moves: moves["dragunov"], throws: throws["dragunov"]), "FENG" : feng.FENG(moves: moves["feng"], throws: throws["feng"]), "HWOARANG" : hwoarang.HWOARANG(moves: moves["hwoarang"], throws: throws["hwoarang"]), "JACK-8" : jack.JACK(moves: moves["jack-8"], throws: throws["jack-8"]), "JIN" : jin.JIN(moves: moves["jin"], throws: throws["jin"]), "JUN" : jun.JUN(moves: moves["jun"], throws: throws["jun"]), "KAZUYA" : kazuya.KAZUYA(moves: moves["kazuya"], throws: throws["kazuya"]), "KING" : king.KING(moves: moves["king"], throws: throws["king"]), "LARS" : lars.LARS(moves: moves["lars"], throws: throws["lars"]), "LAW" : law.LAW(moves: moves["law"], throws: throws["law"]), "LEROY" : leroy.LEROY(moves: moves["leroy"], throws: throws["leroy"]), "LILI" : lili.LILI(moves: moves["lili"], throws: throws["lili"]), "NINA" : nina.NINA(moves: moves["nina"], throws: throws["nina"]), "PAUL" : paul.PAUL(moves: moves["paul"], throws: throws["paul"]), "RAVEN" : raven.RAVEN(moves: moves["raven"], throws: throws["raven"]), "XIAOYU" : xiaoyu.XIAOYU(moves: moves["xiaoyu"], throws: throws["xiaoyu"])};

final characterList = ["ALISA", "ASUKA", "AZUCENA", "BRYAN", "CLAUDIO", "DEVIL JIN", "DRAGUNOV", "FENG", "HWOARANG", "JACK-8", "JIN", "JUN", "KAZUYA", "KING", "LARS", "LAW", "LEROY", "LILI", "NINA", "PAUL", "RAVEN", "XIAOYU"];

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


class MyApp extends StatefulWidget {
  final GetList getList;

  const MyApp({super.key, required this.getList});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: themeData,
        home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 120,
            title: Text("FRAMEDATA"),
            centerTitle: true,
            actionsIconTheme: IconThemeData(size: 40),
            actions: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () => showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(title: Text("설명", style: TextStyle(fontSize: 20, color: Colors.black),), contentTextStyle: TextStyle(fontFamily: "Tenada", height: 1.5, fontSize: 15, color: Colors.black), titleTextStyle: TextStyle(fontFamily: "Tenada", color: Colors.black),
                      content: Text("LP: 왼손, RP: 오른손\nLK: 왼발, RK: 오른발\nAL: LP+LK, AR: RP+RK\nAP: 양손, AK: 양발\nD: 다운, T: 토네이도, A: 공중, g:가드 가능"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('닫기'))
                      ],
                    )),
                    child: Icon(Icons.abc),
                  );
                }
              )
            ],
            backgroundColor: Colors.black,
          ),
          body: Container(
            color: Color(0xff333333),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SizedBox(
                width: 200,
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
          padding: EdgeInsets.all(5),
          width: 100,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black), ),
            onPressed: (){
              if(characterFunctionList[widget.character1] != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => characterFunctionList[widget.character1]!));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("제작중입니다.")));
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character1, textAlign: TextAlign.center, textScaler: TextScaler.linear(0.7))
              ],
            )
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          width: 100,
          height: 40,
          child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black), ),
              onPressed: (){
                if(characterFunctionList[widget.character2] != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => characterFunctionList[widget.character2]!));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("제작중입니다.")));
                }
              },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(widget.character2, textAlign: TextAlign.center, textScaler: TextScaler.linear(0.7))
              ],
            )
          ),
        ),
      ],
    );
  }
}