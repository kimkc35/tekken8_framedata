import 'package:flutter/material.dart';
import 'main.dart';
import 'package:string_validator/string_validator.dart';

TextStyle contextStyle = TextStyle(fontWeight: FontWeight.w400, height: 1.5);

TextStyle headingStyle = TextStyle(color: Colors.black, fontSize: 12);

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

const double listWidth = 35;

const TextScaler scale = TextScaler.linear(0.8);

int listLength = 0;

TextStyle commandStyle = const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, height: 1.2),
    commandStylePlus = const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.green),
    commandStyleMinus = const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xff1a74b2)),
    commandStylePunish = const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.red);

//무브 리스트 생성
List<DataCell> createMove(BuildContext context, String character, name, command, start, guard, hit, counter, range, damage, extra){
  listLength++;
  return [
    DataCell(SizedBox(width: 150, child: Text("$name\n$command", textAlign: TextAlign.center, textScaler: scale, style: commandStyle,)), onTap: () {if(isPro)memo(context, character, name);}), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(start,textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //발생
    if(guard.contains("+") && guard.contains("-") && guard != "-")...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(guard.contains("-") && guard != "-")...[
      if(isFloat(guard) && int.parse(guard) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(guard.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(guard,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    if(hit.contains("+") && hit.contains("-") && hit != "-")...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(hit.contains("-") && hit != "-")...[
      if(isFloat(hit) && int.parse(hit) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(hit.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(hit,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    if(counter.contains("+") && counter.contains("-") && counter != "-")...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(counter.contains("-") && counter != "-")...[
      if(isFloat(counter) && int.parse(counter) <= -10)...[
        DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(counter.contains("+"))...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: listWidth, child: Text(counter,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    DataCell(SizedBox(width: 30, child: Text(range,textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //판정
    DataCell(SizedBox(width: 50, child: Text(damage,textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //대미지
    DataCell(Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(child: Text(extra.toString().replaceAll("-", "").replaceAll("/", "\n"),textAlign: TextAlign.start, textScaler: scale, style: commandStyle)),
    )), //비고
  ];
}

List<DataCell> createThrow(BuildContext context, String character, name, command, start, breakThrow, frameAfterBreak, damage, range, extra){
  return [
    DataCell(SizedBox(width: 150, child: Text("$name\n$command", textAlign: TextAlign.center, textScaler: scale, style: commandStyle,)), onTap: () {if(isPro)memo(context, character, name);}), //기술명, 커맨드
    DataCell(SizedBox(width: 30, child: Text(start, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //발생
    DataCell(SizedBox(width: 40, child: Text(breakThrow, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //풀기
    if(frameAfterBreak.contains("+") && frameAfterBreak.contains("-") && frameAfterBreak != "-")...[ //풀기 후 F
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ]else if(frameAfterBreak.contains("-") && frameAfterBreak != "-")...[
      if(isFloat(frameAfterBreak) && int.parse(frameAfterBreak) <= -10)...[
        DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStylePunish)))
      ]else...[
        DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStyleMinus)))
      ]
    ]else if(frameAfterBreak.contains("+"))...[
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStylePlus)))
    ]else...[
      DataCell(SizedBox(width: 30, child: Text(frameAfterBreak,textAlign: TextAlign.center, textScaler: scale, style: commandStyle)))
    ],
    DataCell(SizedBox(width: 50, child: Text(damage, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //대미지
    DataCell(SizedBox(width: 30, child: Text(range, textAlign: TextAlign.center, textScaler: scale, style: commandStyle))), //판정
    DataCell(Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(extra.toString().replaceAll("-", "").replaceAll("/", "\n").replaceAll("-", "").replaceAll("hyphen", "-"), textAlign: TextAlign.start, textScaler: scale, style: commandStyle),
    )), //비고
  ];
}