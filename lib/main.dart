import 'package:flutter/material.dart';
import 'jin_moves.dart' as jin;
import 'kazuya_moves.dart' as kazuya;
import 'paul_moves.dart' as paul;
import 'claudio_moves.dart' as claudio;
import 'bryan_moves.dart' as bryan;
import 'hwoarang_moves.dart' as hwoarang;
import 'king_moves.dart' as king;

const sticks = {"c1" : "↙", "c2" : "↓", "c3" : "↘", "c4" : "←", "c5" : "N", "c6" : "→", "c7" : "↖", "c8" : "↑", "c9" : "↗"};

final moves = {"kazuya" : [], "jin" : [], "king" : [], "paul" : [], "law" : [], "jack-8" : [], "lars" : [], "xiaoyu" : [], "nina" : [], "leroy" : [], "asuka" : [], "lili" : [], "bryan" : [], "hworang" : [], "claudio" : [], "azucena" : [], "raven" : []};
final throws = {"kazuya" : [], "jin" : [], "king" : [], "paul" : [], "law" : [], "jack-8" : [], "lars" : [], "xiaoyu" : [], "nina" : [], "leroy" : [], "asuka" : [], "lili" : [], "bryan" : [], "hworang" : [], "claudio" : [], "azucena" : [], "raven" : []};

void main() async {
  runApp(
    MyApp(getList: GetList(),)
  );
}


final characterGetMoveList = {"kazuya" : kazuya.GetContents().getMoveList(), "jin" : jin.GetContents().getMoveList(), "king" : king.GetContents().getMoveList(), "paul" : paul.GetContents().getMoveList(), "claudio" : claudio.GetContents().getMoveList(), "hwoarang" : hwoarang.GetContents().getMoveList(), "bryan" : bryan.GetContents().getMoveList()};
final characterGetThrowList = {"kazuya" : kazuya.GetContents().getThrowList(), "jin" : jin.GetContents().getThrowList(), "king" : king.GetContents().getThrowList(), "paul" : paul.GetContents().getThrowList(), "claudio" : claudio.GetContents().getThrowList(), "hwoarang" : hwoarang.GetContents().getThrowList(), "bryan" : bryan.GetContents().getThrowList()};

Map<String, Widget> characterFunctionList = {"KAZUYA" : kazuya.KAZUYA(moves: moves["kazuya"], throws: throws["kazuya"]), "JIN" : jin.JIN(moves: moves["jin"], throws: throws["jin"]), "KING" : king.KING(moves: moves["king"], throws: throws["king"]), "PAUL" : paul.PAUL(moves: moves["paul"], throws: throws["paul"]), "CLAUDIO" : claudio.CLAUDIO(moves: moves["claudio"], throws: throws["claudio"]), "HWOARANG" : hwoarang.HWOARANG(moves: moves["hwoarang"], throws: throws["hwoarang"]), "BRYAN" : bryan.BRYAN(moves: moves["bryan"], throws: throws["bryan"])};

final characterList = ["KAZUYA", "JIN", "KING", "JUN", "PAUL", "LAW", "JACK-8", "LARS", "XIAOYU", "NINA", "LEROY", "ASUKA", "LILI", "BRYAN", "HWOARANG", "CLAUDIO", "AZUCENA", "RAVEN"];

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
        theme: ThemeData(
            fontFamily: 'Tenada',
            useMaterial3: false,
        ),
        home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 120,
            leading: (
                ButtonBar(
                  children: [
                    Image.asset("assets/logo.png", isAntiAlias: true,)
                  ],
                )
            ),
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
                width: 400,
                height: 3000,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext ctx, int idx) {
                    return Column(
                      children: [
                        for(int i = 0; i < characterList.length /
                            2; i++)...[
                          CharacterButton(
                            character1: characterList[2 * i],
                            character2: characterList[2 * i + 1])
                        ]
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        )
    );
  }
}

class CharacterButton extends StatelessWidget {

  final String character1, character2;

  const CharacterButton({super.key, required this.character1, required this.character2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: 200,
          height: 100,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)
            ),
            onPressed: (){
              if(characterFunctionList[character1] != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => characterFunctionList[character1]!));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("제작중입니다.")));
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Image.asset("assets/$character1.png", fit: BoxFit.fill, isAntiAlias: true,),
                Text(character1,  textAlign: TextAlign.center,)
              ],
            )
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: 200,
          height: 100,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent)
              ),
              onPressed: (){
                if(characterFunctionList[character2] != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => characterFunctionList[character2]!));
                }
              },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Image.asset("assets/$character2.png", fit: BoxFit.fill, isAntiAlias: true,),
                Text(character2, textAlign: TextAlign.center,)
              ],
            )
          ),
        ),
      ],
    );
  }
}