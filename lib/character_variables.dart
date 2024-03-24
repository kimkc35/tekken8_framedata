import 'jin_moves.dart' as jin;
import 'kazuya_moves.dart' as kazuya;
import 'paul_moves.dart' as paul;
import 'claudio_moves.dart' as claudio;
import 'bryan_moves.dart' as bryan;
import 'hwoarang_moves.dart' as hwoarang;
import 'king_moves.dart' as king;
import 'feng_moves.dart' as feng;
import 'asuka_moves.dart' as asuka;
import 'azucena_moves.dart' as azucena;
import 'jack-8_moves.dart' as jack;
import 'jun_moves.dart' as jun;
import 'lars_moves.dart' as lars;
import 'law_moves.dart' as law;
import 'leroy_moves.dart' as leroy;
import 'lili_moves.dart' as lili;
import 'nina_moves.dart' as nina;
import 'raven_moves.dart' as raven;
import 'xiaoyu_moves.dart' as xiaoyu;
import 'alisa_moves.dart' as alisa;
import 'devil jin_moves.dart' as devjin;
import 'dragunov_moves.dart' as dragunov;
import 'lee_moves.dart' as lee;
import 'leo_moves.dart' as leo;
import 'kuma_moves.dart' as kuma;
import 'steve_moves.dart' as steve;
import 'panda_moves.dart' as panda;
import 'reina_moves.dart' as reina;
import 'shaheen_moves.dart' as shaheen;
import 'victor_moves.dart' as victor;
import 'yoshimitsu_moves.dart' as yoshimitsu;
import 'zafina_moves.dart' as zafina;

final Map<String, Map<String, String>> characterVideoUrlList = {};

final moves = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};
final throws = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};

final movesEn = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};
final throwsEn = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : []};

final types = {
  "alisa": alisa.types,
  "asuka": asuka.types,
  "azucena": azucena.types,
  "bryan": bryan.types,
  "claudio": claudio.types,
  "devil jin": devjin.types,
  "dragunov": dragunov.types,
  "feng": feng.types,
  "hwoarang": hwoarang.types,
  "jack-8": jack.types,
  "jin": jin.types,
  "jun": jun.types,
  "kazuya": kazuya.types,
  "king": king.types,
  "kuma": kuma.types,
  "lars": lars.types,
  "law": law.types,
  "lee": lee.types,
  "leo": leo.types,
  "leroy": leroy.types,
  "lili": lili.types,
  "nina": nina.types,
  "panda": panda.types,
  "paul": paul.types,
  "raven": raven.types,
  "reina": reina.types,
  "shaheen": shaheen.types,
  "steve": steve.types,
  "victor": victor.types,
  "xiaoyu": xiaoyu.types,
  "yoshimitsu": yoshimitsu.types,
  "zafina": zafina.types
};

final characterExtraInitials = {
  "alisa": alisa.extraInitials,
  "asuka": asuka.extraInitials,
  "azucena": azucena.extraInitials,
  "bryan": bryan.extraInitials,
  "claudio": claudio.extraInitials,
  "devil jin": devjin.extraInitials,
  "dragunov": dragunov.extraInitials,
  "feng": feng.extraInitials,
  "hwoarang": hwoarang.extraInitials,
  "jack-8": jack.extraInitials,
  "jin": jin.extraInitials,
  "jun": jun.extraInitials,
  "kazuya": kazuya.extraInitials,
  "king": king.extraInitials,
  "kuma": kuma.extraInitials,
  "lars": lars.extraInitials,
  "law": law.extraInitials,
  "lee": lee.extraInitials,
  "leo": leo.extraInitials,
  "leroy": leroy.extraInitials,
  "lili": lili.extraInitials,
  "nina": nina.extraInitials,
  "panda": panda.extraInitials,
  "paul": paul.extraInitials,
  "raven": raven.extraInitials,
  "reina": reina.extraInitials,
  "shaheen": shaheen.extraInitials,
  "steve": steve.extraInitials,
  "victor": victor.extraInitials,
  "xiaoyu": xiaoyu.extraInitials,
  "yoshimitsu": yoshimitsu.extraInitials,
  "zafina": zafina.extraInitials
};

const commonExtraInitials = [
  {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
  {"name" : "guardDamage", "guardDamage" : "가드 대미지"},
  {"name" : "powerCrash", "powerCrash" : "파워 크래시"},
  {"name" : "tornado", "tornado" : "토네이도"},
  {"name" : "homing", "homing" : "호밍기"},
  {"name" : "charge", "charge" : "효과 지속 중에는 가드할 수 없음\n자동 카운터 히트"},
  {"name" : "clean", "clean" : "클린 히트 효과\n()는 클린 히트 시 대미지"}
];

Map<String, dynamic> characterFunctionList = {
  "ALISA" : alisa.Main(moves: moves["alisa"], throws: throws["alisa"]),
  "ASUKA" : asuka.Main(moves: moves["asuka"], throws: throws["asuka"]),
  "AZUCENA" : azucena.Main(moves: moves["azucena"], throws: throws["azucena"]),
  "BRYAN" : bryan.Main(moves: moves["bryan"], throws: throws["bryan"]),
  "CLAUDIO" : claudio.Main(moves: moves["claudio"], throws: throws["claudio"]),
  "DEVIL JIN" : devjin.Main(moves: moves["devil jin"], throws: throws["devil jin"]),
  "DRAGUNOV" : dragunov.Main(moves: moves["dragunov"], throws: throws["dragunov"]),
  "FENG" : feng.Main(moves: moves["feng"], throws: throws["feng"]),
  "HWOARANG" : hwoarang.Main(moves: moves["hwoarang"], throws: throws["hwoarang"]),
  "JACK-8" : jack.Main(moves: moves["jack-8"], throws: throws["jack-8"]),
  "JIN" : jin.Main(moves: moves["jin"], throws: throws["jin"]),
  "JUN" : jun.Main(moves: moves["jun"], throws: throws["jun"]),
  "KAZUYA" : kazuya.Main(moves: moves["kazuya"], throws: throws["kazuya"]),
  "KING" : king.Main(moves: moves["king"], throws: throws["king"]),
  "KUMA" : kuma.Main(moves: moves["kuma"], throws: throws["kuma"]),
  "LARS" : lars.Main(moves: moves["lars"], throws: throws["lars"]),
  "LAW" : law.Main(moves: moves["law"], throws: throws["law"]),
  "LEE" : lee.Main(moves: moves["lee"], throws: throws["lee"]),
  "LEO" : leo.Main(moves: moves["leo"], throws: throws["leo"]),
  "LEROY" : leroy.Main(moves: moves["leroy"], throws: throws["leroy"]),
  "LILI" : lili.Main(moves: moves["lili"], throws: throws["lili"]),
  "NINA" : nina.Main(moves: moves["nina"], throws: throws["nina"]),
  "PANDA" : panda.Main(moves: moves["panda"], throws: throws["panda"]),
  "PAUL" : paul.Main(moves: moves["paul"], throws: throws["paul"]),
  "RAVEN" : raven.Main(moves: moves["raven"], throws: throws["raven"]),
  "REINA" : reina.Main(moves: moves["reina"], throws: throws["reina"]),
  "SHAHEEN" : shaheen.Main(moves: moves["shaheen"], throws: throws["shaheen"],),
  "STEVE" : steve.Main(moves: moves["steve"], throws: throws["steve"]),
  "VICTOR" : victor.Main(moves: moves["victor"], throws: throws["victor"]),
  "XIAOYU" : xiaoyu.Main(moves: moves["xiaoyu"], throws: throws["xiaoyu"]),
  "YOSHIMITSU": yoshimitsu.Main(moves: moves["yoshimitsu"], throws: throws["yoshimitsu"]),
  "ZAFINA": zafina.Main(moves: moves["zafina"], throws: throws["zafina"],)
};

const characterList = [
  "ALISA",
  "ASUKA",
  "AZUCENA",
  "BRYAN",
  "CLAUDIO",
  "DEVIL JIN",
  "DRAGUNOV",
  "FENG",
  "HWOARANG",
  "JACK-8",
  "JIN",
  "JUN",
  "KAZUYA",
  "KING",
  "KUMA",
  "LARS",
  "LAW",
  "LEE",
  "LEO",
  "LEROY",
  "LILI",
  "NINA",
  "PANDA",
  "PAUL",
  "RAVEN",
  "REINA",
  "SHAHEEN",
  "STEVE",
  "VICTOR",
  "XIAOYU",
  "YOSHIMITSU",
  "ZAFINA"
];