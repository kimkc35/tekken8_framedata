import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'main.dart';

Row actionBuilder({required BuildContext context, String? character}) {
  const double buttonSize = 37;

  return Row(
    children: [
      GestureDetector(
        onTap: () => showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("설명",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: mainFont)),
                  contentTextStyle: TextStyle(
                      height: 1.5,
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: mainFont),
                  content: Text(patchNotes["description"]),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text('닫기'))
                  ],
                )),
        child: const Icon(Icons.abc, size: buttonSize),
      ),
      GestureDetector(
        onTap: () => patchNoteWidget(context),
        child: const Icon(Icons.article, size: buttonSize),
      ),
      if (character == null) ...[
        GestureDetector(
          onTap: () => showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (context) => SettingDialog()),
          child: const Icon(Icons.settings, size: buttonSize),
        )
      ] else if (isPro) ...[
        GestureDetector(
          onTap: () {
            TextEditingController controller = TextEditingController();

            var currentBox = Hive.box(character);
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
                        fontFamily: mainFont,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      titleTextStyle:
                          TextStyle(fontFamily: mainFont, color: Colors.black),
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
                    ));
          },
          child: Icon(Icons.edit_note, size: buttonSize),
        )
      ]
    ],
  );
}

patchNoteWidget(BuildContext context) {
  TextEditingController patchNoteController = TextEditingController();

  Size screenSize = MediaQuery.of(context).size;

  String replaceNumbers(String text){
    String result = text;
    for (int i = 0; i < sticks.length; i ++){
      result = result.replaceAll("${i + 1} ", "${sticks["c${i + 1}"]}");
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
          contentTextStyle: TextStyle(
              fontFamily: mainFont,
              height: 1.5,
              fontSize: 15,
              color: Colors.black),
          content: SingleChildScrollView(
              child: Text("${patchNotes["version"]} 패치노트\n${replaceNumbers(patchNotes["characters"][patchNoteController.text.toLowerCase()] ?? "")}")
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
