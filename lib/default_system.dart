import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:string_validator/string_validator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'modules.dart';

TextStyle contextStyle = TextStyle(fontWeight: FontWeight.w400, height: 1.5);

TextStyle headerStyle = TextStyle(color: Colors.black);

const TextScaler headerScale = TextScaler.linear(0.8);

memo (BuildContext context, Character character, Info info) {

  TextEditingController controller = TextEditingController();

  YoutubePlayerController youtubeController = YoutubePlayerController(
    initialVideoId: info.extraVideo ?? character.videoId,
    flags: YoutubePlayerFlags(
        forceHD: true,
        loop: true,
        autoPlay: true,
        hideThumbnail: true,
        controlsVisibleAtStart: false,
        startAt: info.startAt,
        endAt: info.endAt
    ),
  );

  playYoutubePlayer(){
    return showDialog(context: context, builder: (BuildContext context) {
      return PopScope(
        onPopInvokedWithResult: (b, r) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        },
        child:
        (character.videoId == "" || info.endAt == null || info.extraVideo == null)
           ? AlertDialog(content: Text("영상이 없습니다."),) :
        Dialog(
          insetPadding: EdgeInsets.zero,
          child: YoutubePlayer(
            controller: youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.redAccent,
              handleColor: Colors.red,
            ),
          ),
        )
      );
    });
  }

  showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(title: Text("${character.name.toUpperCase()}, ${info.name}", style: TextStyle(fontSize: 20),),
    content: SingleChildScrollView(
      child: kIsWeb? TextField(
        decoration: InputDecoration(hintText: "웹에선 이용 불가합니다.", enabled: false),
      ) : TextField(
      onChanged: (value) {

        final currentBox = Hive.box(character.name);
        if(currentBox.containsKey(info.name)){
          controller.text = currentBox.get(info.name);
        }
        currentBox.put(info.name, value);
      },
        controller:controller,
        maxLines: null,
        decoration: const InputDecoration(hintText: "원하는 내용을 입력하세요!", border: null)
      )
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => playYoutubePlayer(),
            child: Text('영상 재생')),
          TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('닫기'))
      ],)
    ],
  ));
}

const double listWidth = 37;

const TextScaler textScale = TextScaler.linear(0.9);

int listLength = 0;

String changeRange(String range){
  String resultRange = range;
  resultRange = resultRange.replaceAll("상단", "High");
  resultRange = resultRange.replaceAll("중단", "Mid");
  resultRange = resultRange.replaceAll("하단", "Low");
  resultRange = resultRange.replaceAll("가불", "Unblockable");
  resultRange = resultRange.replaceAll("잡기", "Throw");
  resultRange = resultRange.replaceAll("연계", "Combo");
  
  return resultRange;
}

String changeCommand(String command, Character character){
  const sticks = {
    "→": "f",
    "↘": "d/f",
    "↓": "d",
    "↙": "d/b",
    "←": "b",
    "↖": "u/b",
    "↑": "u",
    "↗": "u/f",
    "N": "N"
  };

  const commands = {
    "AP": "1+2",
    "AK": "3+4",
    "AL": "1+3",
    "AR": "2+4",
    "LP": "1",
    "RP": "2",
    "LK": "3",
    "RK": "4",
  };

  String resultCommand = command;
  for(var command in commands.entries){
    resultCommand = resultCommand.replaceAll(RegExp('${command.key}(?!\\+)'), "${command.value},");
    resultCommand = resultCommand.replaceAll(command.key, command.value);
  }
  for(var stick in sticks.entries){
    resultCommand = resultCommand.replaceAllMapped(RegExp('^${stick.key}(\\d)'), (match) {
      String matchedChar = match.group(1)!;
      return '${stick.value}+$matchedChar';
    });
    resultCommand = resultCommand.replaceAll(RegExp('${stick.key}~'), "${stick.value}~");
    resultCommand = resultCommand.replaceAll(stick.key, "${stick.value},");
  }
  resultCommand = resultCommand.replaceAll("횡이동 중", "SS");
  resultCommand = resultCommand.replaceAll("달리는 도중", "While Running");
  resultCommand = resultCommand.replaceAll("몸을 숙인 상태에서", "FC");
  resultCommand = resultCommand.replaceAll("일어나며", "WS");
  resultCommand = resultCommand.replaceAll("카운터 히트 시", "During Counter Attack");
  resultCommand = resultCommand.replaceAll("히트 시", "During Attack");
  resultCommand = resultCommand.replaceFirst("레이지 상태에서", "During Rage");
  resultCommand = resultCommand.replaceFirst("히트 발동 가능 상태에서", "When Heat activation is availabe");
  resultCommand = resultCommand.replaceFirst("히트 상태에서", "During Heat");
  for(var type in character.typesKo.entries){
    resultCommand = resultCommand.replaceAll(RegExp('^${type.value} 도중'), "During ${generateTypes(type.key)}");
  }

  if(resultCommand.endsWith(",")) resultCommand = resultCommand.substring(0, resultCommand.length - 1);
  resultCommand = resultCommand.replaceAllMapped(RegExp(r',(\(|\]|\)\ )'), (match) {
    String matchedChar = match.group(1)!;
    return matchedChar;
  });

  return resultCommand;
}

//무브 리스트 생성
List<DataCell> createMove(BuildContext context, Character character, MoveInfo moveInfo){
  TextStyle textStyleDefault = TextStyle(color: Colors.black, height: 1.2, ),
      textStylePlus = TextStyle(color: Colors.green),
      textStyleMinus = TextStyle(color: Color(0xff1a74b2)),
      textStylePunish = TextStyle(color: Colors.red,);

  listLength++;
  List<String> guardParts = [];
  String guardPart1 = "", hitPart1 = "", hitPart2 = "", counterPart1 = "", counterPart2 = "";

  if(moveInfo.guardFrame.contains("(")){
    guardPart1 = moveInfo.guardFrame.toString().split("(")[0];
    guardParts = moveInfo.guardFrame.toString().split("(")[1].replaceAll("(", "").replaceAll(")", "").split(",");
  }

  if(moveInfo.hitFrame.contains("(")){
    hitPart1 = moveInfo.hitFrame.toString().split("(")[0];
    hitPart2 = moveInfo.hitFrame.toString().split("(")[1].replaceAll("(", "").replaceAll(")", "");
  }

  if(moveInfo.counterFrame.contains("(")){
    counterPart1 = moveInfo.counterFrame.toString().split("(")[0];
    counterPart2 = moveInfo.counterFrame.toString().split("(")[1].replaceAll("(", "").replaceAll(")", "");
  }

  return [
    DataCell(Container(padding: EdgeInsets.all(7),width: 150, child: Text("${moveInfo.name}\n${context.locale.languageCode == "ko" ? moveInfo.command : changeCommand(moveInfo.command, character)}", textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault,)), onTap: () {if(isPro)memo(context, character, moveInfo);}), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(moveInfo.startFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //발생
    if(moveInfo.guardFrame.contains("("))...[
      DataCell(SizedBox(width: listWidth, child: Text.rich(TextSpan(children: [
        guardPart1.contains("+") ? TextSpan(text: guardPart1, style: textStylePlus) : (guardPart1.contains("-") && isFloat(guardPart1) && int.parse(guardPart1) <= -10) ? TextSpan(text: guardPart1, style: textStylePunish) : guardPart1.contains("-") ? TextSpan(text: guardPart1, style: textStyleMinus) : TextSpan(text: guardPart1, style: textStyleDefault),
        TextSpan(text: "\n(", style: textStyleDefault, ),
        for(int i = 0; i < guardParts.length; i++)...[
          guardParts[i].contains("+") ? TextSpan(text: guardParts[i], style: textStylePlus) : (guardParts[i].contains("-") && isFloat(guardParts[i]) && int.parse(guardParts[i]) <= -10) ? TextSpan(text: guardParts[i], style: textStylePunish) : guardParts[i].contains("-") ? TextSpan(text: guardParts[i], style: textStyleMinus) : TextSpan(text: guardParts[i], style: textStyleDefault),
          i != guardParts.length - 1 ? TextSpan(text: ",", style: textStyleDefault) : TextSpan(text: "")
        ],
          TextSpan(text: ")", style: textStyleDefault),
      ]), textScaler: textScale, textAlign: TextAlign.center)))
    ]else if(moveInfo.guardFrame.contains("-") && moveInfo.guardFrame != "-")...[
      if(isFloat(moveInfo.guardFrame) && int.parse(moveInfo.guardFrame) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(moveInfo.guardFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(moveInfo.guardFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(moveInfo.guardFrame.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(moveInfo.guardFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(moveInfo.guardFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    if(moveInfo.hitFrame.contains("("))...[
      DataCell(SizedBox(width: listWidth, child: Text.rich(TextSpan(children: [
        hitPart1.contains("+") ? TextSpan(text: hitPart1, style: textStylePlus) : hitPart1.contains("-") ? TextSpan(text: hitPart1, style: textStyleMinus) : TextSpan(text: hitPart1, style: textStyleDefault),
        TextSpan(text: "\n(", style: textStyleDefault, ),
        hitPart2.contains("+") ? TextSpan(text: hitPart2, style: textStylePlus) : hitPart2.contains("-") ? TextSpan(text: hitPart2, style: textStyleMinus) : TextSpan(text: hitPart2, style: textStyleDefault),
        TextSpan(text: ")", style: textStyleDefault),
      ]), textScaler: textScale, textAlign: TextAlign.center)))
    ]else if(moveInfo.hitFrame.contains("-") && moveInfo.hitFrame != "-")...[
      if(isFloat(moveInfo.hitFrame) && int.parse(moveInfo.hitFrame) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(moveInfo.hitFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(moveInfo.hitFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(moveInfo.hitFrame.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(moveInfo.hitFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(moveInfo.hitFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    if(moveInfo.counterFrame.contains("("))...[
      DataCell(SizedBox(width: listWidth, child: Text.rich(TextSpan(children: [
        counterPart1.contains("+") ? TextSpan(text: counterPart1, style: textStylePlus) : counterPart1.contains("-") ? TextSpan(text: counterPart1, style: textStyleMinus) : TextSpan(text: counterPart1, style: textStyleDefault),
        TextSpan(text: "\n(", style: textStyleDefault, ),
        counterPart2.contains("+") ? TextSpan(text: counterPart2, style: textStylePlus) : counterPart2.contains("-") ? TextSpan(text: counterPart2, style: textStyleMinus) : TextSpan(text: counterPart2, style: textStyleDefault),
        TextSpan(text: ")", style: textStyleDefault),
      ]), textScaler: textScale, textAlign: TextAlign.center)))
    ]else if(moveInfo.counterFrame.contains("-") && moveInfo.counterFrame != "-")...[
      if(isFloat(moveInfo.counterFrame) && int.parse(moveInfo.counterFrame) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(moveInfo.counterFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(moveInfo.counterFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(moveInfo.counterFrame.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(moveInfo.counterFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(moveInfo.counterFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    DataCell(SizedBox(width: 30, child: Text(context.locale.languageCode == "ko" ? moveInfo.range : changeRange(moveInfo.range),textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //판정
    DataCell(SizedBox(width: 50, child: Text(moveInfo.damage,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //대미지
    DataCell(Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(child: Text(moveInfo.extra.replaceAll(RegExp(r'\[.*?\]'), ""),textAlign: TextAlign.start, textScaler: textScale, style: textStyleDefault)),
    )), //비고
  ];
}

List<DataCell> createThrow(BuildContext context, Character character, ThrowInfo throwInfo){
  TextStyle textStyleDefault = TextStyle(color: Colors.black, height: 1.2, ),
      textStylePlus = TextStyle(color: Colors.green),
      textStyleMinus = TextStyle(color: Color(0xff1a74b2)),
      textStylePunish = TextStyle( color: Colors.red,);

  return [
    DataCell(SizedBox(width: 150, child: Text("${throwInfo.name}\n${context.locale.languageCode == "ko" ? throwInfo.command : changeCommand(throwInfo.command, character)}", textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault,)), onTap: () {if(isPro)memo(context, character, throwInfo);}), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(throwInfo.startFrame, textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //발생
    DataCell(SizedBox(width: 40, child: Text(throwInfo.breakCommand, textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //풀기
    if(throwInfo.afterBreakFrame.contains("+") && throwInfo.afterBreakFrame.contains("-") && throwInfo.afterBreakFrame != "-")...[ //풀기 후 F
      DataCell(SizedBox(width: 30, child: Text(throwInfo.afterBreakFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ]else if(throwInfo.afterBreakFrame.contains("-") && throwInfo.afterBreakFrame != "-")...[
      if(isFloat(throwInfo.afterBreakFrame) && int.parse(throwInfo.afterBreakFrame) <= -10)...[
        DataCell(SizedBox(width: 30, child: Text(throwInfo.afterBreakFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: 30, child: Text(throwInfo.afterBreakFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(throwInfo.afterBreakFrame.contains("+"))...[
      DataCell(SizedBox(width: 30, child: Text(throwInfo.afterBreakFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: 30, child: Text(throwInfo.afterBreakFrame,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    DataCell(SizedBox(width: 50, child: Text(throwInfo.damage, textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //대미지
    DataCell(SizedBox(width: 30, child: Text(context.locale.languageCode == "ko" ? throwInfo.range : changeRange(throwInfo.range), textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //판정
    DataCell(Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(throwInfo.extra, textAlign: TextAlign.start, textScaler: textScale, style: textStyleDefault),
    )), //비고
  ];
}