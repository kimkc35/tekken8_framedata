import 'package:flutter/material.dart';

TextStyle contextStyle = const TextStyle(fontWeight: FontWeight.w400, height: 1.5);

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