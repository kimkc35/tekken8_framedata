import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tekken8_framedata/profileScreen.dart';

import 'main.dart';

const double buttonSize = 30;

Padding actionBuilder({required BuildContext context,String? character}) {
  return Padding(
    padding: const EdgeInsets.only(right: 5),
    child: Row(
      spacing: 5,
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
                builder: (context) => settingDialog(context)),
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
                          decoration: InputDecoration(
                              hintText: "memo.hintText".tr(), border: null))),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text('memo.close'.tr()))
                  ],
                )
              );
            },
            child: Icon(Icons.edit_note, size: buttonSize),
          ),
        ]
      ],
    ),
  );
}

Widget firstAction(BuildContext context, double buttonSize) {
  if(tabController.index == 0){
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("description.title".tr(),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,)),
            content: Text("description.context".tr(), style: TextStyle(height: 1.5, fontSize: 15),),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('description.close'.tr()))
            ],
          )),
      child: Icon(Icons.question_mark, size: buttonSize,),
    );
  }else if(tabController.index == 1){
    return SizedBox.shrink();
  }
  return GestureDetector(
    child: Icon(Icons.star, size: buttonSize,),
    onTap: () {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("bookmark.title".tr()),
        content: bookmarkedList.isEmpty? Text("bookmark.noBookmarkedPlayer".tr()) :
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView.separated(
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex:1, child: Text(bookmarkedList[index].name, overflow: TextOverflow.visible, textAlign: TextAlign.center,)),
                Expanded(
                  flex:1,
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(playerInfo: bookmarkedList[index]))),
                    child: Text(bookmarkedList[index].polarisId, style: TextStyle(color: CustomThemeMode.currentThemeData.value.primaryColor)),
                  ),
                ),
              ],
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
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
  TextEditingController patchNoteController = TextEditingController();

  Size screenSize = MediaQuery.of(context).size;

  String replaceNumbers(String text){
    String result = text;
    for (int i = 0; i < sticks.length; i ++){
      result = result.replaceAll("${i + 1} ", "${sticks["c${i + 1}"]}");
    }

    return result;
  }

  List<TextSpan> convertPatchNote(String character){
    List<TextSpan> result = [TextSpan(text: "${patchNotes["version"]} ${"patchNote.title".tr()}\n")];
    if(character.isNotEmpty){
      final String text = replaceNumbers(patchNotes["characters"][character]);
      text.split("\n").forEach((element) {
        if(element.contains(":")){
          RegExp regexp = RegExp(r'^(.*?)(:.*)');
          Match? match = regexp.firstMatch(element);
          final command = match!.group(1);
          final patch = match.group(2).toString().replaceAll(" - ", "\n - ");
          result.add(
              TextSpan(text: "■ ")
          );
          result.add(
              TextSpan(text: command, style: patch.contains("(하향)") ? TextStyle(color: Colors.red) : patch.contains("(상향)") ? TextStyle(color: Colors.green) : patch.contains("(조정)") ? TextStyle(color: Colors.amber) : TextStyle())
          );
          result.add(
              TextSpan(text: "$patch\n")
          );
        }else{
          result.add(
              TextSpan(text: "$element\n")
          );
        }
      });
    }
    return result;
  }

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: DropdownMenu(
            menuHeight: screenSize.height * 0.4,
            onSelected: (value) => setState(() {}),
            hintText: "캐릭터",
            controller: patchNoteController,
            dropdownMenuEntries: [
              for(MapEntry<String,
                  dynamic> character in patchNotes["characters"].entries)...[
                if(character.value != "") DropdownMenuEntry(
                    value: character.key, label: character.key.toUpperCase())
              ]
            ]
          ),
          content: SingleChildScrollView(
            child: Text.rich(
              TextSpan(
                  style: TextStyle(height: 1.4),
                  children: convertPatchNote(
                      patchNoteController.text.toLowerCase())
              ),
            )
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('setting.close').tr())
          ],
        );
      },
    );
   }
 );
}

AlertDialog settingDialog(BuildContext context){
  TextEditingController localizationController = TextEditingController(text: context.locale.languageCode == "ko" ? "한국어" : "English");

  return AlertDialog(title: Text('setting.title', style: TextStyle(fontSize: 20)).tr(),
    content: ValueListenableBuilder(
      valueListenable: CustomThemeMode.fontChanged,
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text('setting.changeFont').tr(),
                  Switch(value: value, onChanged: (value) {
                    CustomThemeMode.changeFont();
                  })
                ],
              ),
              Row(
                children: [
                  DropdownMenu(
                    dropdownMenuEntries: [
                      DropdownMenuEntry(label: "English", value: "en"),
                      DropdownMenuEntry(label: "한국어", value: "ko")
                    ],
                    controller: localizationController,
                    initialSelection: context.locale.languageCode,
                    onSelected: (value){
                      context.setLocale(Locale(value!));
                      // setLocale(context, value!);
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('setting.close').tr())
    ],
  );
}