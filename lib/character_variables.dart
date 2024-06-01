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
import 'eddy_moves.dart' as eddy;

Map<String, Map<String, String>> characterVideoUrlList = {};

moves = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : [], "eddy" : []};
throws = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : [], "eddy": []};

movesEn = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : [], "eddy" : []};
throwsEn = {"alisa" : [], "asuka" : [], "azucena" : [], "bryan" : [], "devil jin" : [], "dragunov" : [], "claudio" : [], "feng" : [], "hwoarang" : [], "jack-8" : [], "jin" : [], "jun" : [], "kazuya" : [], "king" : [], "kuma" : [], "lars" : [], "law" : [], "lee" : [], "leo" : [], "leroy" : [], "lili" : [], "nina" : [], "panda" : [], "paul" : [], "raven" : [], "reina" : [], "shaheen" : [], "steve" : [], "victor" : [], "xiaoyu" : [], "yoshimitsu" : [], "zafina" : [], "eddy" : []};

final Map<String, List> types = {
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
  "zafina": zafina.types,
  "eddy": eddy.types
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
  "zafina": zafina.extraInitials,
  "eddy": eddy.extraInitials
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
  "alisa" : alisa.Main(moves: moves["alisa"], throws: throws["alisa"]),
  "asuka" : asuka.Main(moves: moves["asuka"], throws: throws["asuka"]),
  "azucena" : azucena.Main(moves: moves["azucena"], throws: throws["azucena"]),
  "bryan" : bryan.Main(moves: moves["bryan"], throws: throws["bryan"]),
  "claudio" : claudio.Main(moves: moves["claudio"], throws: throws["claudio"]),
  "devil jin" : devjin.Main(moves: moves["devil jin"], throws: throws["devil jin"]),
  "dragunov" : dragunov.Main(moves: moves["dragunov"], throws: throws["dragunov"]),
  "feng" : feng.Main(moves: moves["feng"], throws: throws["feng"]),
  "hwoarang" : hwoarang.Main(moves: moves["hwoarang"], throws: throws["hwoarang"]),
  "jack-8" : jack.Main(moves: moves["jack-8"], throws: throws["jack-8"]),
  "jin" : jin.Main(moves: moves["jin"], throws: throws["jin"]),
  "jun" : jun.Main(moves: moves["jun"], throws: throws["jun"]),
  "kazuya" : kazuya.Main(moves: moves["kazuya"], throws: throws["kazuya"]),
  "king" : king.Main(moves: moves["king"], throws: throws["king"]),
  "kuma" : kuma.Main(moves: moves["kuma"], throws: throws["kuma"]),
  "lars" : lars.Main(moves: moves["lars"], throws: throws["lars"]),
  "law" : law.Main(moves: moves["law"], throws: throws["law"]),
  "lee" : lee.Main(moves: moves["lee"], throws: throws["lee"]),
  "leo" : leo.Main(moves: moves["leo"], throws: throws["leo"]),
  "leroy" : leroy.Main(moves: moves["leroy"], throws: throws["leroy"]),
  "lili" : lili.Main(moves: moves["lili"], throws: throws["lili"]),
  "nina" : nina.Main(moves: moves["nina"], throws: throws["nina"]),
  "panda" : panda.Main(moves: moves["panda"], throws: throws["panda"]),
  "paul" : paul.Main(moves: moves["paul"], throws: throws["paul"]),
  "raven" : raven.Main(moves: moves["raven"], throws: throws["raven"]),
  "reina" : reina.Main(moves: moves["reina"], throws: throws["reina"]),
  "shaheen" : shaheen.Main(moves: moves["shaheen"], throws: throws["shaheen"]),
  "steve" : steve.Main(moves: moves["steve"], throws: throws["steve"]),
  "victor" : victor.Main(moves: moves["victor"], throws: throws["victor"]),
  "xiaoyu" : xiaoyu.Main(moves: moves["xiaoyu"], throws: throws["xiaoyu"]),
  "yoshimitsu" : yoshimitsu.Main(moves: moves["yoshimitsu"], throws: throws["yoshimitsu"]),
  "zafina" : zafina.Main(moves: moves["zafina"], throws: throws["zafina"]),
  "eddy" : eddy.Main(moves: moves["eddy"], throws: throws["eddy"]),
};

const characterList = ["alisa", "asuka", "azucena", "bryan", "claudio", "devil jin", "dragunov", "feng", "hwoarang", "jack-8", "jin", "jun", "kazuya", "king", "kuma", "lars", "law", "lee", "leo", "leroy", "lili", "nina", "panda", "paul", "raven", "reina", "shaheen", "steve", "victor", "xiaoyu", "yoshimitsu", "zafina", "eddy", ""];