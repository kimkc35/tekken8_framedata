import 'package:flutter/cupertino.dart';

enum Font {
  oneMobileTitle("OneMobileTitle"),
  oneMobile("OneMobile"),
  tenada("Tenada");

  final String font;
  const Font(this.font);
}

enum ComparisonState {
  greater(">"),
  lesser("<"),
  equal("=");

  final String state;
  const ComparisonState(this.state);
}

class PlayerInfo {
  final String name, polarisId;
  final bool isVerified;

  PlayerInfo({required this.name, required this.isVerified, required this.polarisId});

  PlayerInfo.fromJson(Map<String, dynamic> json):
  name = json['name'],
  isVerified = json['isVerified'],
  polarisId = json['polarisId'];

  Map<String, dynamic> toJson() => {'name': name, 'isVerified': isVerified, 'polarisId': polarisId};
}

class PlayerProfile{
  final String polarisId;
  final String prowess;
  final String winRate;
  final bool isVerified;
  final bool isBookmarked;
  final List<CharacterWinRate> characterWinRateList;

  PlayerProfile({required this.polarisId, required this.winRate, required this.prowess, required this.isVerified, required this.isBookmarked, required this.characterWinRateList});

}

class MatchHistory{
  final DateTime date;
  final String stage;
  final String player;
  final String playerChar;
  final String playerCharImgUrl;
  final String oppName;
  final String oppChar;
  final String oppPolarisId;
  final String oppCharImgUrl;
  final String outcome;

  MatchHistory({required this.date, required this.stage, required this.player, required this.playerChar, required this.playerCharImgUrl, required this.oppName, required this.oppChar, required this.oppPolarisId, required this.oppCharImgUrl, required this.outcome});
}

class CharacterWinRate{
  final String charImgUrl;
  final String char;
  final String matches;
  final String winRate;
  final String rankImgUrl;

  CharacterWinRate({required this.charImgUrl, required this.char, required this.matches, required this.winRate, required this.rankImgUrl});

}

class Character{
  final String name;
  final MoveInfo rageArts;
  final List<String> heatSystem;
  final Map<String, bool> types;
  final Map<String, String> typesKo;
  late final Map<String, List<MoveInfo>> moveInfoList;
  late final List<ThrowInfo> throwInfoList;
  final String videoId;

  Character({
    required this.name,
    required this.rageArts,
    required this.heatSystem,
    required this.types,
    required this.typesKo,
    this.videoId = ""
  });

  Map<String, List<MoveInfo>> getMoveList(){
    return moveInfoList.map((key, value) => MapEntry(key, value));
  }

}

Map<String, Color> cellColors = {"blue": Color(0xff79e1ff), "grey": Color(0xffd5d5d5), "yellow": Color(0xffFFFF00)};

class Info{
  final String name;
  int startAt;
  int? endAt;
  final String? color;
  final String? extraVideo;

  Info({required this.name, this.startAt = 0, this.endAt, this.color, this.extraVideo});
}

class MoveInfo extends Info{
  final String command, startFrame, guardFrame, hitFrame, counterFrame, range, damage, extra;

  MoveInfo({required super.name, required this.command, required this.startFrame, required this.guardFrame, required this.hitFrame, required this.counterFrame, required this.range, required this.damage, required this.extra, super.startAt, super.endAt, super.color, super.extraVideo});

}

class ThrowInfo extends Info{
  final String command, startFrame, breakCommand, afterBreakFrame, range, damage, extra;

  ThrowInfo({required super.name, required this.command, required this.startFrame, required this.breakCommand, required this.afterBreakFrame, required this.range, required this.damage, required this.extra, super.startAt, super.endAt, super.color, super.extraVideo});
}

class ComparisonHeader{
  final String name;
  final TextEditingController controller;
  ComparisonState state;

  ComparisonHeader({required this.name, required this.controller, required this.state});

  void changeState(){
    switch(state){
      case ComparisonState.greater:
        state = ComparisonState.equal;
      case ComparisonState.lesser:
        state = ComparisonState.greater;
      case ComparisonState.equal:
        state = ComparisonState.lesser;
    }
  }
}


String generateTypes(String keyOfType){
  final strings = keyOfType.split(" ");
  String resultString = "";

  for(String string in strings){
    resultString += string[0].toUpperCase();
    final leftOvers = string.substring(1);
    resultString += "$leftOvers ";
  }

  resultString = resultString.substring(0, resultString.length - 1);
  return resultString;
}