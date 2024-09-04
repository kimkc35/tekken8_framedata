import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekken8_framedata/playerDetailsScreen.dart';

import 'main.dart';
import 'modules.dart';

const double buttonSize = 34;

Row actionBuilder({required BuildContext context,String? character, required Function refresh}) {

  return Row(
    children: [
      firstAction(context, buttonSize),
      GestureDetector(
        onTap: () => patchNoteWidget(context),
        child: const Icon(Icons.article, size: buttonSize),
      ),
      if (character == null) ...[
        GestureDetector(
          onTap: () => showDialog<String>(
              context: context,
              builder: (context) => settingDialog(context, refresh)),
          child: const Icon(Icons.settings, size: buttonSize),
        )
      ] else if (isPro) ...[
        GestureDetector(
          onTap: () {
            TextEditingController controller = TextEditingController();

            final currentBox = Hive.box(character);
            if (currentBox.containsKey(character)) {
              controller.text = currentBox.get(character);
            }

            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  character.toUpperCase(),
                  style: TextStyle(color: Colors.black),
                  textScaler: TextScaler.linear(1.2),
                ),
                contentTextStyle: TextStyle(
                  height: 1.5,
                  color: Colors.black,
                ),
                content: SingleChildScrollView(
                    child: TextField(
                        onChanged: (value) {
                          currentBox.put(character, value);
                        },
                        controller: controller,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: "원하는 내용을 입력하세요!", border: null))),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text('닫기'))
                ],
              )
            );
          },
          child: Icon(Icons.edit_note, size: buttonSize),
        ),
      ]
    ],
  );
}

Widget firstAction(BuildContext context, double buttonSize) {
  if(tabController.index == 0){
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("설명",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,)),
            content: Text(patchNotes["description"], style: TextStyle(height: 1.5, fontSize: 15),),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('닫기'))
            ],
          )),
      child: Icon(Icons.abc, size: buttonSize),
    );
  }else if(tabController.index == 1){
    return SizedBox.shrink();
  }
  return GestureDetector(
    child: Icon(Icons.star, size: buttonSize,),
    onTap: () {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("즐겨찾기 한 유저"),
        content: bookmarkedList.isEmpty? Text("즐겨찾기 한 유저가 없습니다!") :
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView.separated(
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerDetailsPage(playerInfo: bookmarkedList[index]))),
                  child: Text(bookmarkedList[index].polarisId, style: TextStyle(color: themeData.primaryColor)),
                ),
                Expanded(child: Text(bookmarkedList[index].name, overflow: TextOverflow.visible, textAlign: TextAlign.center,))
              ],
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(height: 1, color: Colors.black,),
            ),
            itemCount: bookmarkedList.length
          ),
        ),
      ));
    },
  );

}

patchNoteWidget(BuildContext context) {
  TextEditingController patchNoteController = TextEditingController(text: patchNotes["characters"].entries.firstWhere((e) => e.value != "").key.toUpperCase());

  Size screenSize = MediaQuery.of(context).size;

  String replaceNumbers(String text){
    String result = text;
    for (int i = 0; i < sticks.length; i ++){
      result = result.replaceAll("${i + 1} ", "${sticks["c${i + 1}"]}");
    }

    return result;
  }

  List<TextSpan> convertPatchNote(String character){
    List<TextSpan> result = [TextSpan(text: "${patchNotes["version"]} 패치노트\n")];
    final String text = replaceNumbers(patchNotes["characters"][character]);
    if(text.contains(":")){
      text.split("\n").forEach((element) {
        RegExp regexp = RegExp(r'^(.*?)(:.*)');
        Match? match = regexp.firstMatch(element);
        final command = match!.group(1);
        final patch = match.group(2).toString();
        result.add(
          TextSpan(text: "- ")
        );
        result.add(
          TextSpan(text: command, style: patch.contains("(하향)") ? TextStyle(color: Colors.red) : patch.contains("(상향)") ? TextStyle(color: Colors.green) : patch.contains("(조정)") ? TextStyle(color: Colors.amber) : TextStyle())
        );
        result.add(
          TextSpan(text: "$patch\n")
        );
      });
    }
    return result;
  }

  return showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Row(
            children: [
              DropdownMenu(
                menuHeight: screenSize.height * 0.4,
                onSelected: (value) => setState((){
                }),
                hintText: "캐릭터",
                controller: patchNoteController,
                  dropdownMenuEntries: [
                    for(MapEntry<String, dynamic> character in patchNotes["characters"].entries)...[
                      if(character.value != "") DropdownMenuEntry(value: character.key, label: character.key.toUpperCase())
                    ]
                  ]
              ),
            ],
          ),
          content: SingleChildScrollView(
              child: Text.rich(
                TextSpan(
                  children: convertPatchNote(patchNoteController.text.toLowerCase())
                ),
              )
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('닫기'))
          ],
        );
      },
        ));
}

AlertDialog settingDialog(BuildContext context, Function refresh){

  void saveFontSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('changeFont', changeFont);
  }

  return AlertDialog(title: Text(language == "ko"?"설정" : "Setting", style: TextStyle(fontSize: 20)),
    content: StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          child: Row(
            children: [
              Text(language == 'ko' ? "폰트 바꾸기" : "Change Font"),
              Switch(value: changeFont, onChanged: (value) {
                changeFont = value;
                themeData = ThemeData(
                  buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
                  textTheme: TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.w900)),
                  fontFamily: changeFont ? Font.oneMobile.font : Font.tenada.font,
                  useMaterial3: false,
                  primarySwatch: Colors.pink,
                );
                saveFontSetting();
                refresh();
                setState((){});
              })
            ],
          ),
        );
      }
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text( language == "ko"? '닫기' : 'Close'))
    ],
  );
}