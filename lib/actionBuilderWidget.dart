import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'main.dart';

Row actionBuilder(BuildContext context, String character, bool isMove) {
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
                  content: Text(patchNote["description"]),
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
      if (!isMove) ...[
        GestureDetector(
          onTap: () => showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (context) => SettingDialog()),
          child: const Icon(Icons.settings, size: buttonSize),
        )
      ] else if (isPro && isMove) ...[
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
  String currentCharacter = "캐릭터 선택";

  return showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Row(
            children: [
              MenuAnchor(
                menuChildren: [
                  for (MapEntry<String, dynamic> name in patchNote["patchNote"].entries)...[
                    if(name.key != currentCharacter && name.value != "")
                      MenuItemButton(
                        child: Text(name.key.toUpperCase()),
                        onPressed: () {
                          setState(() {
                            currentCharacter = name.key;
                          });
                        },
                      )
                  ]
                ],
                builder: (context, controller, child) {
                  return TextButton(
                    child: (
                        Text(currentCharacter.toUpperCase(), style: TextStyle(fontFamily: mainFont, fontSize: 15),)
                    ),
                    onPressed: () {
                      controller.isOpen
                          ? controller.close()
                          : controller.open();
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  patchNote["version"],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
          contentTextStyle: TextStyle(
              fontFamily: mainFont,
              height: 1.5,
              fontSize: 15,
              color: Colors.black),
          content: SingleChildScrollView(
              child: Text(patchNote["patchNote"][currentCharacter] ?? "")),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('닫기'))
          ],
        );
      },
        ));
}
