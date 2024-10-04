import 'package:flutter/cupertino.dart';

enum Font {
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
  final String polarisId, name, onlineId, platform, number;

  PlayerInfo({required this.polarisId, required this.name, required this.onlineId, required this.platform, required this.number});

  PlayerInfo.fromJson(Map<String, dynamic> json):
  polarisId = json['polarisId'],
  name = json['name'],
  onlineId = json['onlineId'],
  platform = json['platform'],
  number = json['number'];

  Map<String, dynamic> toJson() => {'polarisId' : polarisId, 'name': name, 'onlineId' : onlineId, 'platform' : platform, 'number' : number};
}

class PlayerDetails{
  final Map<String, List<String>> stats;
  final String prowess;
  final String imgUrl;
  final String rankPoint;
  final bool isBookmarked;

  PlayerDetails({required this.stats, required this.prowess, required this.imgUrl, required this.rankPoint, required this.isBookmarked});

}

class PlayHistory{
  final String player;
  final String date;
  final String playerChar;
  final String oppName;
  final String oppChar;
  final String score;
  final String type;

  PlayHistory({required this.player, required this.date, required this.playerChar, required this.oppName, required this.oppChar, required this.score, required this.type});
}

class CharacterWinRate{
  final String oppChar;
  final String timeFaced;
  final String timeWin;
  final String timeLose;
  final String winRate;

  CharacterWinRate({required this.oppChar, required this.timeFaced, required this.timeWin, required this.timeLose, required this.winRate});

}

class Character{
  final String name;
  final MoveInfo rageArts;
  final List<String> heatSystem;
  final Map<String, bool> types;
  final Map<String, String> typesKo;
  late final Map<String, List<MoveInfo>> moveInfoList;
  late final List<ThrowInfo> throwInfoList;
  Map<String, String>? videoList = {};
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

class Info{
  final String name;
  int startAt;
  int? endAt;

  Info({required this.name, this.startAt = 0, this.endAt});
}

class MoveInfo extends Info{
  final String command, startFrame, guardFrame, hitFrame, counterFrame, range, damage, extra;

  MoveInfo({required super.name, required this.command, required this.startFrame, required this.guardFrame, required this.hitFrame, required this.counterFrame, required this.range, required this.damage, required this.extra, super.startAt, super.endAt});

}

class ThrowInfo extends Info{
  final String command, startFrame, breakCommand, afterBreakFrame, range, damage, extra;

  ThrowInfo({required super.name, required this.command, required this.startFrame, required this.breakCommand, required this.afterBreakFrame, required this.range, required this.damage, required this.extra, super.startAt, super.endAt});
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