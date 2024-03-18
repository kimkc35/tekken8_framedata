import 'package:flutter/material.dart';
import 'main.dart';
import 'package:string_validator/string_validator.dart';

TextStyle contextStyle = TextStyle(fontWeight: FontWeight.w400, height: 1.5);

TextStyle headerStyle = TextStyle(color: Colors.black);

const TextScaler headerScale = TextScaler.linear(0.8);

Container heatSystemContexts(List<String> addition){
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("1. 모든 공격에 가드 대미지 효과가 붙음 (공통)", style: contextStyle),
        Text("2. 콤보나 공격의 기점이 되는 히트 대시 발동 가능(발동 후 히트 상태 종료) (공통)", style: contextStyle),
        Text("3. 대미지가 높은 큰 기술 히트 스매시 발동 가능(발동 후 히트 상태 종료) (공통)", style: contextStyle),
        for(var i = 0; i < addition.length; i++)...[
          Text("${i + 4}. ${addition[i]}", style: contextStyle,)
        ]
      ],
    ),
  );
}

const double listWidth = 37;

const TextScaler textScale = TextScaler.linear(0.9);

int listLength = 0;

TextStyle textStyleDefault = TextStyle(fontWeight: FontWeight.w400, color: Colors.black, height: 1.2, fontFamily: mainFont),
    textStylePlus = TextStyle(fontWeight: FontWeight.w400, color: Colors.green, fontFamily: mainFont),
    textStyleMinus = TextStyle(fontWeight: FontWeight.w400, color: Color(0xff1a74b2), fontFamily: mainFont),
    textStylePunish = TextStyle(fontWeight: FontWeight.w400, color: Colors.red, fontFamily: mainFont);

//무브 리스트 생성
List<DataCell> createMove(BuildContext context, String character, name, command, start, guard, hit, counter, range, damage, extra){
  listLength++;
  String guardPart1 = "", guardPart2 = "", hitPart1 = "", hitPart2 = "", counterPart1 = "", counterPart2 = "";

  if(guard.contains("(")){
    guardPart1 = guard.toString().split("(")[0];
    guardPart2 = guard.toString().split("(")[1].replaceAll("(", "").replaceAll(")", "");
  }

  if(hit.contains("(")){
    hitPart1 = hit.toString().split("(")[0];
    hitPart2 = hit.toString().split("(")[1].replaceAll("(", "").replaceAll(")", "");
  }

  if(counter.contains("(")){
    counterPart1 = counter.toString().split("(")[0];
    counterPart2 = counter.toString().split("(")[1].replaceAll("(", "").replaceAll(")", "");
  }

  return [
    DataCell(SizedBox(width: 150, child: Text("$name\n$command", textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault,)), onTap: () {if(isPro)memo(context, character, name);}), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(start,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //발생
    if(guard.contains("("))...[
      DataCell(SizedBox(width: listWidth, child: RichText(text : TextSpan(children: [
        guardPart1.contains("+") ? TextSpan(text: guardPart1, style: textStylePlus) : guardPart1.contains("-") ? TextSpan(text: guardPart1, style: textStyleMinus) : TextSpan(text: guardPart1, style: textStyleDefault),
        TextSpan(text: "\n(", style: textStyleDefault, ),
        guardPart2.contains("+") ? TextSpan(text: guardPart2, style: textStylePlus) : guardPart2.contains("-") ? TextSpan(text: guardPart2, style: textStyleMinus) : TextSpan(text: guardPart2, style: textStyleDefault),
        TextSpan(text: ")", style: textStyleDefault),
      ]), textScaler: textScale, textAlign: TextAlign.center)))
    ]else if(guard.contains("-") && guard != "-")...[
      if(isFloat(guard) && int.parse(guard) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(guard.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    if(hit.contains("("))...[
      DataCell(SizedBox(width: listWidth, child: RichText(text : TextSpan(children: [
        hitPart1.contains("+") ? TextSpan(text: hitPart1, style: textStylePlus) : hitPart1.contains("-") ? TextSpan(text: hitPart1, style: textStyleMinus) : TextSpan(text: hitPart1, style: textStyleDefault),
        TextSpan(text: "\n(", style: textStyleDefault, ),
        hitPart2.contains("+") ? TextSpan(text: hitPart2, style: textStylePlus) : hitPart2.contains("-") ? TextSpan(text: hitPart2, style: textStyleMinus) : TextSpan(text: hitPart2, style: textStyleDefault),
        TextSpan(text: ")", style: textStyleDefault),
      ]), textScaler: textScale, textAlign: TextAlign.center)))
    ]else if(hit.contains("-") && hit != "-")...[
      if(isFloat(hit) && int.parse(hit) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(hit.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    if(counter.contains("("))...[
      DataCell(SizedBox(width: listWidth, child: RichText(text : TextSpan(children: [
        counterPart1.contains("+") ? TextSpan(text: counterPart1, style: textStylePlus) : counterPart1.contains("-") ? TextSpan(text: counterPart1, style: textStyleMinus) : TextSpan(text: counterPart1, style: textStyleDefault),
        TextSpan(text: "\n(", style: textStyleDefault, ),
        counterPart2.contains("+") ? TextSpan(text: counterPart2, style: textStylePlus) : counterPart2.contains("-") ? TextSpan(text: counterPart2, style: textStyleMinus) : TextSpan(text: counterPart2, style: textStyleDefault),
        TextSpan(text: ")", style: textStyleDefault),
      ]), textScaler: textScale, textAlign: TextAlign.center)))
    ]else if(counter.contains("-") && counter != "-")...[
      if(isFloat(counter) && int.parse(counter) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(counter.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    DataCell(SizedBox(width: 30, child: Text(range,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //판정
    DataCell(SizedBox(width: 50, child: Text(damage,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //대미지
    DataCell(Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(child: Text(extra.toString(),textAlign: TextAlign.start, textScaler: textScale, style: textStyleDefault)),
    )), //비고
  ];
}

List<DataCell> createThrow(BuildContext context, String character, name, command, start, breakThrow, frameAfterBreak, damage, range, extra){
  return [
    DataCell(SizedBox(width: 150, child: Text("$name\n$command", textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault,)), onTap: () {if(isPro)memo(context, character, name);}), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(start, textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //발생
    DataCell(SizedBox(width: 40, child: Text(breakThrow, textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //풀기
    if(frameAfterBreak.contains("+") && frameAfterBreak.contains("-") && frameAfterBreak != "-")...[ //풀기 후 F
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ]else if(frameAfterBreak.contains("-") && frameAfterBreak != "-")...[
      if(isFloat(frameAfterBreak) && int.parse(frameAfterBreak) <= -10)...[
        DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: textScale, style: textStylePunish)))
      ]else...[
        DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: textScale, style: textStyleMinus)))
      ]
    ]else if(frameAfterBreak.contains("+"))...[
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: textScale, style: textStylePlus)))
    ]else...[
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault)))
    ],
    DataCell(SizedBox(width: 50, child: Text(damage, textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //대미지
    DataCell(SizedBox(width: 30, child: Text(range, textAlign: TextAlign.center, textScaler: textScale, style: textStyleDefault))), //판정
    DataCell(Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(extra, textAlign: TextAlign.start, textScaler: textScale, style: textStyleDefault),
    )), //비고
  ];
}