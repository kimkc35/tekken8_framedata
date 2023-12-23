import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

final TextEditingController searchController = TextEditingController();

String searchText = "";

class Keyboard extends StatefulWidget {
  final searchText = "";
  const Keyboard({super.key, required searchText});

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {

  @override
  void initState() {
    super.initState();
    searchText = widget.searchText;
  }

  Widget keyboardButton(String content, {String inputText = ""}){
    if(content == "delete"){
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 40,
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                searchController.text = searchController.text.substring(0, searchController.text.length - 1);
                searchText = searchController.text;
              });
            }, child: Icon(CupertinoIcons.arrow_left_to_line, size: 20, color: Colors.white,), ),
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
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                searchController.text = searchController.text + inputText;
                searchText = searchController.text;
              });
            }, child: Text(content, style: TextStyle(color: Colors.white,),)),
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
            child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
              setState(() {
                searchController.text = "";
                searchText = searchController.text;
              });
            }, child: Text(content, style: TextStyle(color: Colors.white,),)),
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
          child: TextButton(style: ButtonStyle(side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.pink))),onPressed: (){
            setState(() {
              searchController.text = searchController.text + content;
              searchText = searchController.text;
            });
          }, child: Text(content, style: TextStyle(color: Colors.white,),)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: main.themeData,
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
                          keyboardButton("히트", inputText: "히트 발동기"),
                        ],
                      ),
                      Row( //4번째 줄
                        children: [
                          keyboardButton("상단"),
                          keyboardButton("중단"),
                          keyboardButton("하단"),
                          keyboardButton("+"),
                          keyboardButton("-"),
                          keyboardButton("가댐", inputText: "가드 대미지"),
                          keyboardButton("파크", inputText: "파워 크래시"),
                        ],
                      ),
                      Row( //5번째 줄
                        children: [
                          keyboardButton("1"),
                          keyboardButton("2"),
                          keyboardButton("3"),
                          keyboardButton("4"),
                          keyboardButton("5"),
                          keyboardButton("6"),
                          keyboardButton("호밍기"),
                        ],
                      ),
                      Row( //6번째 줄
                        children: [
                          keyboardButton("7"),
                          keyboardButton("8"),
                          keyboardButton("9"),
                          keyboardButton("0"),
                          keyboardButton(""),
                          keyboardButton(""),
                          keyboardButton("AC"),
                        ],
                      ),
                    ],
                  )
              ),
            ),
          );
        },
      );}, icon: Icon(Icons.keyboard_alt_outlined), color: Colors.white, iconSize: 30,);
  }
}
