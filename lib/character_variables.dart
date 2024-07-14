import 'main.dart';

const commonExtraInitials = [
  {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
  {"name" : "guardDamage", "guardDamage" : "가드 대미지"},
  {"name" : "powerCrash", "powerCrash" : "파워 크래시"},
  {"name" : "tornado", "tornado" : "토네이도"},
  {"name" : "homing", "homing" : "호밍기"},
  {"name" : "charge", "charge" : "효과 지속 중에는 가드할 수 없음\n자동 카운터 히트"},
  {"name" : "clean", "clean" : "클린 히트 효과\n()는 클린 히트 시 대미지"}
];

class Character{
  String name;
  List rageArts;
  List<Map<String, String>> extraInitials;
  List<String> heatSystem;
  Map<String, bool> types;
  Map<String, String> typesKo;
  late List<Map<String, dynamic>> moveList;
  late List<List<String>> throwList;
  Map<String, String> videoList = {};

  Character({
    required this.name,
    required this.rageArts,
    required this.extraInitials,
    required this.heatSystem,
    required this.types,
    required this.typesKo,
  });
}

Character empty = Character(name: "", rageArts: [], extraInitials: [], heatSystem: [], types: {}, typesKo: {});

Character alisa = Character(
  name: "alisa", 
  extraInitials: [{"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}], 
  heatSystem: ["체인톱을 사용하는 공격의 가드 대미지 증가", "새로운 듀얼 부트 이행기 사용 가능"], 
  rageArts: ["레디언트 페가수스 봄", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "혹은 레이지 상태에서 디스트럭티브 폼 도중 ${sticks["c3"]}AP\n레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰\n홀드 가능"],
  types: {"heat" : false, "general" : false, "sit" : false, "destructive form" : false, "boot" : false, "dual boot" : false, "backup" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "destructive form" : "디스트럭티브 폼", "boot" : "부트", "dual boot" : "듀얼 부트", "backup" : "백업"},
);

Character asuka = Character(
  name: "asuka",
  extraInitials: [],
  heatSystem: ["나니와의 기염 보유 시의 기술 사용 가능"],
  rageArts: [language == "ko"?"나니와 중재꾼 너클":"Naniwa Peacemaker Knuckle", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰\n홀드 가능"],
  types: {"heat" : false, "general" : false, "sit" : false, "naniwa gusto" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "naniwa gusto" : "나니와의 기염"}
);

Character azucena = Character(
  name: "azucena", 
  extraInitials: [], 
  heatSystem: ["리베르타도르 레볼루시온 사용 가능", "누에보 리베르타도르 사용 가능", "파워가 상승한 리베르타도르 사용 가능"], 
  rageArts: ["알레그리아 델 카페", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "libertador" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "libertador" : "리베르타도르"},
);

Character bryan = Character(
  name: "bryan", 
  extraInitials: [
    {"name" : "snakeEyes", "snakeEyes" : "히트 발동 시 스네이크 아이즈를 획득"},
    {"name" : "useSnakeEyes", "useSnakeEyes" : "스네이크 아이즈를 소비(히트 상태 지속 중에는 히트 상태의 남은 시간을 대신 소비)"},
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "sway", "sway" : "${sticks["c4"]}~입력 시 스웨이로 이행\n()는 이행 시 프레임"},
    {"name" : "slitherStep", "slitherStep" : "${sticks["c6"]}~입력 시 슬리더 스텝으로 이행\n()는 이행 시 프레임"}
  ], 
  heatSystem: ["스네이크 아이즈 보유 시의 기술 사용 가능"], 
  rageArts: ["토털 반달라이제이션", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "snake eyes" : false, "slither step" : false, "sway" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "snake eyes" : "스네이크 아이즈", "slither step" : "슬리더 스텝", "sway" : "스웨이"},
);

Character claudio = Character(
  name: "claudio",
  extraInitials: [{"name" : "starburst", "starburst" : "히트 시 스타버스트 상태로"}],
  heatSystem: ["스타버스트 상태의 기술 사용 가능"],
  rageArts: ["라 루체 디 시리오", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "starburst" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "starburst" : "스타버스트"},
);

Character devilJin = Character(
  name: "devil jin", 
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "charge", "charge" : "효과 지속 중에는 가드할 수 없음\n자동 카운터 히트"}
  ], 
  heatSystem: ["멸초파 사용 가능", "최속 입력이 아니더라도 최속 풍신권 사용 가능"], 
  rageArts: ["흉계시현 혈쇄인", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "wind god step" : false, "fly" : false, "mourning crow" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "wind god step" : "풍신 스텝", "fly" : "비공", "mourning crow" : "모닝 크로우"},
);

Character dragunov = Character(
  name: "dragunov", 
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "sneak", "sneak" : "${sticks["c3"]}~입력 시 스네이크로/()는 이행 시 프레임"}
  ], 
  heatSystem: ["페인트 & 캐치, 앰부시 태클이 잡기 풀기 불가능", "일부 연계에서 앰부시 태클 사용 가능"], 
  rageArts: ["화이트 엔젤 오브 데스", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "sneak" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "sneak" : "스네이크"},
);

Character eddy = Character(
  name: "eddy", 
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}
  ], 
  heatSystem: ["게헤이루 에시플로지부 사용 가능", "하부 지 아하이아 리베라두 사용 가능"], 
  rageArts: ["인셴치 지 아셰", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "bananeira" : false, "negativa" : false, "mandinga" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "bananeira" : "바나네이라", "negativa" : "네가치바", "mandinga" : "만징가"},
);

Character feng = Character(
  name: "feng", 
  extraInitials: [], 
  heatSystem: ["신수박면장 사용 가능", "신수염장멸파 사용 가능", "응룡렬해답 사용 가능"], 
  rageArts: ["진결 화룡정천장", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "lingering shadow" : false, "shifting clouds" : false, "deceptive step" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "lingering shadow" : "잔영", "shifting clouds" : "운수", "deceptive step" : "허보"},
);

Character hwoarang = Character(
  name: "hwoarang", 
  extraInitials: [
    {"name" : "LF.", "LF." : "왼 플라밍고"},
    {"name" : "RF.", "RF." : "오른 플라밍고"},
    {"name" : "RS.", "RS." : "오른 자세"},
  ], 
  heatSystem: ["파워가 상승한 오른 플라밍고 도중의 발차기 기술 사용 가능"], 
  rageArts: ["스카이 베리얼", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "오른 자세, 왼 플라밍고, 오른 플라밍고 도중에도 사용 가능\n레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "shark step" : false, "right stance" : false, "left flamingo" : false, "right flamingo" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "shark step" : "샤크 스텝", "right stance" : "오른 자세", "left flamingo" : "왼 플라밍고", "right flamingo" : "오른 플라밍고"},
);

Character jack8 = Character(
  name: "jack-8", 
  extraInitials: [
    {"name" : "howl", "howl" : "2 ~입력 시 감마 하울로\n()는 이행 시 프레임"}
  ], 
  heatSystem: ["감마 차지 보유 시의 기술 사용 가능"], 
  rageArts: ["테라포밍 캐논", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "sit down" : false, "gamma howl" : false, "gamma charge" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "sit down" : "시트 다운", "gamma howl" : "감마 하울", "gamma charge" : "감마 차지"},
);

Character jin = Character(
  name: "jin", 
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "zenshin", "zenshin" : "${sticks["c6"]}~입력시 전심 이행\n()안의 프레임은 전심 이행 시 프레임"},
    {"name" : "aps", "aps" : "각성 삼전 서기 도중"}
  ], 
  heatSystem: ["데빌의 힘을 사용하는 새로운 기술 사용 가능", "최속 입력이 아니더라도 최속 왼 찔러 올리기와 최속 오른 돌려 찌르기 사용 가능"], 
  rageArts: ["극성마인충", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "breaking step" : false, "zanshin" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "breaking step" : "브레이킹 스텝", "zanshin" : "잔심"},
);

Character jun = Character(
  name: "jun",
  extraInitials: [
    {"name" : "horizon", "horizon" : "2 ~ or 8 ~입력 시 횡이동으로"},
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "clean", "clean" : "클린 히트 효과\n()는 클린 히트 시 대미지, 프레임"},
  ],
  heatSystem: ["체력을 소비하지 않고 카자마의 힘(체력 소비 기술) 사용 가능", "파워가 상승한 감념상벽 사용 가능"],
  rageArts: ["아마츠 이자나미", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "izumo" : false, "genjitsu" : false, "miare" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "izumo" : "이즈모", "genjitsu" : "환일", "miare" : "미아레"
  },
);

Character kazuya = Character(
  name: "kazuya",
  extraInitials: [
    {"name" : "step", "step" : "${sticks["c3"]}~입력 시 풍신 스텝으로 이행\n()는 이행 시 프레임"},
    {"name" : "damageUp", "damageUp" : "상대 공격을 받아내면 대미지 증가"},
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
  ],
  heatSystem: ["데빌의 힘을 사용하는 새로운 기술 사용 가능", "최속 입력이 아니더라도 최속 풍신권 사용 가능"],
  rageArts: ["데모닉 카타스트로피", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "wind god step" : false, "devil" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "wind god step" : "풍신 스텝", "devil" : "데빌"
  },
);

Character king = Character(
  name: "king",
  extraInitials: [],
  heatSystem: ["파워가 상승한 재규어 스프린트 사용 가능", "특정 잡기 기술로 히트 상태의 남은 시간 회복 가능"],
  rageArts: ["앵거 오브 더 비스트", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "beast step" : false, "jaguar step" : false, "jaguar sprint" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "beast step" : "비스트 스텝", "jaguar step" : "재규어 스텝", "jaguar sprint" : "재규어 스프린트"
  },
);

Character kuma = Character(
  name: "kuma",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "hunting", "hunting" : "${sticks["c2"]} ~ or AK입력 시 헌팅으로"},
  ],
  heatSystem: ["일부 홀드기가 원래보다 짧은 시간 입력으로 최대 홀드 성능이 됨", "파워가 상승한 베어 롤 사용 가능", "윈드 베어 피스트, 프레시 윈드 베어 피스트 사용 가능"],
  rageArts: ["타입 38 이래디케이션 웨폰: 아라마키", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "hunting" : false, "bear sit" : false, "bear roll" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "hunting" : "헌팅 자세", "bear sit" : "베어 시트", "bear roll" : "베어 롤"
  },
);

Character lars = Character(
  name: "lars",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "clean", "clean" : "클린 히트 효과\n()는 클린 히트 시 대미지, 프레임"},
  ],
  heatSystem: ["파워가 상승한 리미티드 엔트리 사용 가능", "새로운 사일런트 엔트리 이행기 사용 가능"],
  rageArts: ["제우스 언리미티드", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "dynamic entry" : false, "silent entry" : false, "limited entry" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "dynamic entry" : "다이나믹 엔트리", "silent entry" : "사일런트 엔트리", "limited entry" : "리미티드 엔트리"
  },
);

Character law = Character(
  name: "law",
  extraInitials: [
    {"name" : "dragonCharge", "dragonCharge" : "${sticks["c6"]}~입력 시 드래곤 차지로\n()는 이행 시 프레임"}
  ],
  heatSystem: ["파워가 상승한 쌍절곤 기술 사용 가능", "드래곤 차지로 펀치 공격 흘리기 가능"],
  rageArts: ["페이트 오브 더 드래곤", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "dragon charge" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "dragon charge" : "드래곤 차지"
  },
);

Character lee = Character(
  name: "lee",
  extraInitials: [
    {"name" : "heatJust", "heatJust" : "히트 상태 지속 중에는 저스트 입력 불필요(히트 상태의 남은 시간을 소비,저스트 성공으로 남은 시간 회복)"},
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}
  ],
  heatSystem: ["저스트 입력이 아니더라도 저스트 입력 기술 사용 가능", "저스트 입력 성공 시, 히트 상태의 남은 시간 회복"],
  rageArts: ["더 마벨러스 로즈", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n혹은 레이지 상태에서 히트맨 도중 ${sticks["c3"]}AP\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "mist step" : false, "hitman" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "mist step" : "미스트 스텝", "hitman" : "히트맨"
  },
);

Character leo = Character(
  name: "leo",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "금계독립", "금계독립" : "금계독립(금계독립)"},
    {"name" : "Fo Bu", "Fo Bu" : "부보"},
    {"name" : "Jin Bu", "Jin Bu" : "진보"}
  ],
  heatSystem: ["섬전 보유 시의 기술 사용 가능"],
  rageArts: ["건곤회천황", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "jin bu" : false, "금계독립" : false, "fo bu" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "jin bu" : "진보", "금계독립" : "금계독립", "fo bu" : "부보"
  },
);

Character leroy = Character(
  name: "leroy",
  extraInitials: [
    {"name" : "parryFunction", "parryFunction" : "반격기 효과 있음(히트 상태 지속 중에 성공하면 히트 상태의 남은 시간 회복)\n반격기 성공 후 LP or RP를 입력하면 Chain Punch: Branch로"}
  ],
  heatSystem: ["연환권을 비롯한 고속 연속 공격의 가드 대미지 증가", "리로이 고유의 흘리기, 반격기를 성공하면 히트 상태의 남은 시간 회복 가능"],
  rageArts: ["타계련환흑룡경", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "hermit" : false, "cane" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "hermit" : "독보", "cane" : "지팡이"
  },
);

Character lili = Character(
  name: "lili",
  extraInitials: [],
  heatSystem: ["파워가 상승한 파이스티 래빗 사용 가능", "파워가 상승한 피어싱 톤 사용 가능"],
  rageArts: ["라 비 앙 로즈 포르티시시모", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "dew glide" : false, "feisty rabbit" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "dew glide" : "듀 글라이드", "feisty rabbit" : "파이스티 래빗"
  },
);

Character nina = Character(
  name: "nina",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}
  ],
  heatSystem: ["파워가 상승한 권총 기술 사용 가능", "키스 샷 페네트레이터 사용 가능"],
  rageArts: ["데스 바이 디그리즈", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "ducking step" : false, "sway" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "ducking step" : "더킹 스텝", "sway" : "스웨이"
  },
);

Character panda = Character(
  name: "panda",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "hunting", "hunting" : "${sticks["c2"]} ~ or AK입력 시 헌팅으로"}
  ],
  heatSystem: ["일부 홀드기가 원래보다 짧은 시간 입력으로 최대 홀드 성능이 됨", "파워가 상승한 베어 롤 사용 가능", "판다 슈팅 스타 사용 가능"],
  rageArts: ["클로즈 콜! 팬더 스토밍 플라워", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "hunting" : false, "bear sit" : false, "bear roll" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "hunting" : "헌팅 자세", "bear sit" : "베어 시트", "bear roll" : "베어 롤"
  },
);

Character paul = Character(
  name: "paul",
  extraInitials: [
    {"name" : "sway", "sway" : "${sticks["c4"]}~입력 시 부초(스웨이) 이행\n()는 부초(스웨이) 이행 시 프레임"}
  ],
  heatSystem: ["파워가 상승한 붕권", "파워가 상승한 홀드기 사용 가능"],
  rageArts: ["빅뱅폭권", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "cormorant step" : false, "sway" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "cormorant step" : "잠복 스텝", "sway" : "부초(스웨이)"
  },
);

Character raven = Character(
  name: "raven",
  extraInitials: [],
  heatSystem: ["분신을 사용한 공격이 가드당했을 때 자동으로 추가 공격 발동", "분신을 사용한 공격이 히트했을 때 히트 상태의 남은 시간 회복", "티폰 팽 팬텀 사용 가능"],
  rageArts: ["와일드 헌트 X-에큐터", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "shadow sprint" : false, "soulzone" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "shadow sprint" : "섀도 스프린트", "soulzone" : "소울존"
  },
);

Character reina = Character(
  name: "reina",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}
  ],
  heatSystem: ["일부 연계에서 겹쳐 죽이기 사용 가능", "최속 입력이 아니더라도 최속 풍신권, 최속 무신각 사용 가능", "금강벽으로 상중단 공격 흘리기 가능"],
  rageArts: ["멸신 찬연세괴", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "wind god step" : false, "sentai" : false, "unsoku" : false, "heaven's wrath" : false, "wind step" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "wind god step" : "풍신 스텝", "sentai" : "선체", "unsoku" : "운족", "heaven's wrath" : "금강벽", "wind step" : "바람 다리"
  },
);

Character shaheen = Character(
  name: "shaheen",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "stealthStep", "stealthStep" : "${sticks["c3"]}~입력 시 스텔스 스텝으로/()는 이행 시 프레임"}
  ],
  heatSystem: ["손날을 사용하는 일부 기술이 히트했을 때 히트 상태의 남은 시간 회복", "알 굴 마스터 사용 가능"],
  rageArts: ["나즘 알샤말", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "stealth step" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "stealth step" : "스텔스 스텝"
  },
);

Character steve = Character(
  name: "steve",
  extraInitials: [
    {"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"},
    {"name" : "dds", "dds" : "더킹, 더킹 레프트(라이트), 스웨이로 이행 가능"}
  ],
  heatSystem: ["새로운 더킹 인 이행기 사용 가능", "투-페이스드 사용 가능", "라이온 하트로 중단 공격 흘리기 가능"],
  rageArts: ["디어 랜드 오브 호프", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "ducking left/right" : false, "quick spin" : false, "ducking/ducking in" : false, "peekaboo" : false, "swaying" : false, "flicker stance" : false, "lion heart" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "ducking left/right" : "더킹 레프트/라이트", "quick spin" : "퀵 스핀", "ducking/ducking in" : "더킹/더킹 인", "peekaboo" : "피커브", "swaying" : "스웨이", "flicker stance" : "플리커 자세", "lion heart" : "라이온 하트"
  },
);

Character victor = Character(
  name: "victor",
  extraInitials: [],
  heatSystem: ["파워가 상승한 파보", "백양염제파, 백련염제파 사용 가능"],
  rageArts: ["쿠 드 슈발리에", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "iai Stance" : false, "perfumer" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "iai Stance" : "이아이 스탠스", "perfumer" : "퍼퓨머"
  },
);

Character xiaoyu = Character(
  name: "xiaoyu",
  extraInitials: [],
  heatSystem: ["파워가 상승한 파보", "백양염제파, 백련염제파 사용 가능"],
  rageArts: ["왕전비초 구천진공", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "back" : false, "sit" : false, "hypnotist" : false, "phoenix" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "back" : "뒤자세", "sit" : "앉은 자세", "hypnotist" : "파보", "phoenix" : "봉황"
  },
);

Character yoshimitsu = Character(
  name: "yoshimitsu",
  extraInitials: [{"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}],
  heatSystem: ["납도 자세 도중에만 쓸 수 있는 파워 상승 버전 칼 기술을 일반 자세에서도 사용 가능", "만잠자리 자세 도중의 일부 칼 기술이 파워 상승"],
  rageArts: ["삼계순회 제행무상", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "레이지 아츠 히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "kincho" : false, "meditation" : false, "flea" : false, "indian stance" : false, "mutou no kiwami" : false, "manji dragonfly" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "kincho" : "금타 자세", "meditation" : "무상 자세", "flea" : "지뢰인 자세", "indian stance" : "만자앉기 자세", "mutou no kiwami" : "납도 자세", "manji dragonfly" : "만잠자리 자세"},
);

Character zafina = Character(
  name: "zafina",
  extraInitials: [{"name" : "heat", "heat" : "히트 상태의 남은 시간을 소비"}],
  heatSystem: ["아자젤의 힘(체력 소비 기술)이 발동했을 때 체력을 소비하지 않음", "아자젤의 힘에 의한 큰 기술이 파워 크래시가 됨"],
  rageArts: ["셈퍼 어바러스 어젯", "레이지 상태에서 ${sticks["c3"]}AP", "20", "-15", "D", "D", "중단", "55", "혹은 레이지 상태에서 스케어크로 자세 도중 ${sticks["c3"]}AP 레이지 아츠 히트 시 상대의 회복 가능 게이지를 없앰"],
  types: {"heat" : false, "general" : false, "sit" : false, "scarecrow stance" : false, "tarantula stance" : false, "mantis stance" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "scarecrow stance" : "스케어크로 자세", "tarantula stance" : "타란튤라 자세", "mantis stance" : "맨티스 자세"},
);



final characterList = [alisa, asuka, azucena, bryan, claudio, devilJin, dragunov, eddy, feng, hwoarang, jack8, jin, jun, kazuya, king, kuma, lars, law, lee, leo, leroy, lili, nina, panda, paul, raven, reina, shaheen, steve, victor, xiaoyu, yoshimitsu, zafina, empty];