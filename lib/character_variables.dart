import 'main.dart';
import 'modules.dart';

const Map<String, String> characterImageUrls = {
  "alisa": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_mnt.png",
  "asuka": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_der.png",
  "azucena": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_cat.png",
  "bryan": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_cht.png",
  "claudio": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_ctr.png",
  "devil jin": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_swl.png",
  "dragunov": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_kmd.png",
  "eddy": "https://tekkenwarehouse.com/wp-content/uploads/2024/04/Copy-of-T_UI_Makuai_Character_L_dog.png",
  "feng": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_klw.png",
  "hwoarang": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_snk.png",
  "jack-8": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_ccn.png",
  "jin": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_ant.png",
  "jun": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_aml.png",
  "kazuya": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_grl.png",
  "king": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_pgn.png",
  "kuma": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_rbt.png",
  "lars": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_lzd.png",
  "law": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_pig.png",
  "lee": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_wlf.png",
  "leo": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_ghp.png",
  "leroy": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_jly.png",
  "lili": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_hms.png",
  "lidia": "https://tekkenwarehouse.com/wp-content/uploads/2024/07/T_UI_Makuai_Character_L_cbr.png",
  "nina": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_kal.png",
  "panda": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_ttr.png",
  "paul": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_grf.png",
  "raven": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_bbn.png",
  "reina": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_zbr.png",
  "shaheen": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_hrs.png",
  "steve": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_bsn.png",
  "victor": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_lon.png",
  "xiaoyu": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_rat.png",
  "yoshimitsu": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_cml.png",
  "zafina": "https://tekkenwarehouse.com/wp-content/uploads/2024/02/T_UI_Makuai_Character_L_crw.png",
  "heihachi": "https://tekkenwarehouse.com/wp-content/uploads/2024/09/T_UI_Makuai_Character_L_bee.png"
};

Character empty = Character(name: "", rageArts: MoveInfo(name: "", command: "", startFrame: "", guardFrame: "", hitFrame: "", counterFrame: "", range: "", damage: "", extra: ""), heatSystem: [], types: {}, typesKo: {});

Character alisa = Character(
  name: "alisa",
  heatSystem: ["체인톱을 사용하는 공격의 가드 대미지 증가", "새로운 듀얼 부트 이행기 사용 가능"],
  rageArts: MoveInfo(name:"레디언트 페가수스 봄", command:"레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D",range:  "중단",damage:  "55",extra:  "혹은 레이지 상태에서 디스트럭티브 폼 도중 ${sticks["c3"]}AP\n레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰\n홀드 가능", startAt: 50, endAt: 65),
  types: {"heat" : false, "general" : false, "sit" : false, "destructive form" : false, "boot" : false, "dual boot" : false, "backup" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "destructive form" : "디스트럭티브 폼", "boot" : "부트", "dual boot" : "듀얼 부트", "backup" : "백업"},
  videoId: "vIYrz2ISyY4"
);

Character asuka = Character(
  name: "asuka",
  heatSystem: ["나니와의 기염 보유 시의 기술 사용 가능"],
  rageArts: MoveInfo(name: "나니와 중재꾼 너클", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰\n홀드 가능", startAt: 33, endAt: 46),
  types: {"heat" : false, "general" : false, "sit" : false, "naniwa gusto" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "naniwa gusto" : "나니와의 기염"},
  videoId: "cl9FEzyx5dg"
);

Character azucena = Character(
  name: "azucena",
  heatSystem: ["리베르타도르 레볼루시온 사용 가능", "누에보 리베르타도르 사용 가능", "파워가 상승한 리베르타도르 사용 가능"],
  rageArts: MoveInfo(name: "알레그리아 델 카페", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 81, endAt: 95),
  types: {"heat" : false, "general" : false, "sit" : false, "libertador" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "libertador" : "리베르타도르"},
  videoId: "kljO7Spwvms"
);

Character bryan = Character(
  name: "bryan",
  heatSystem: ["스네이크 아이즈 보유 시의 기술 사용 가능"],
  rageArts: MoveInfo(name: "토털 반달라이제이션", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 33, endAt: 48),
  types: {"heat" : false, "general" : false, "sit" : false, "snake eyes" : false, "slither step" : false, "sway" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "snake eyes" : "스네이크 아이즈", "slither step" : "슬리더 스텝", "sway" : "스웨이"},
  videoId: "QRXmsR3s91c"
);

Character claudio = Character(
  name: "claudio",
  heatSystem: ["스타버스트 상태의 기술 사용 가능"],
  rageArts: MoveInfo(name: "라 루체 디 시리오", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 37, endAt: 50),
  types: {"heat" : false, "general" : false, "sit" : false, "starburst" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "starburst" : "스타버스트"},
  videoId: "wvsa9IIXmsU"
);

Character devilJin = Character(
  name: "devil jin",
  heatSystem: ["멸초파 사용 가능", "최속 입력이 아니더라도 최속 풍신권 사용 가능"],
  rageArts: MoveInfo(name: "흉계시현 혈쇄인", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 61, endAt: 76),
  types: {"heat" : false, "general" : false, "sit" : false, "wind god step" : false, "fly" : false, "mourning crow" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "wind god step" : "풍신 스텝", "fly" : "비공", "mourning crow" : "모닝 크로우"},
  videoId: "LerMZ9rXJDE"
);

Character dragunov = Character(
  name: "dragunov",
  heatSystem: ["페인트 & 캐치, 앰부시 태클이 잡기 풀기 불가능", "일부 연계에서 앰부시 태클 사용 가능"],
  rageArts: MoveInfo(name: "화이트 엔젤 오브 데스", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 62, endAt: 77),
  types: {"heat" : false, "general" : false, "sit" : false, "sneak" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "sneak" : "스네이크"},
  videoId: "gC-tC-qwNZs"
);

Character feng = Character(
  name: "feng",
  heatSystem: ["신수박면장 사용 가능", "신수염장멸파 사용 가능", "응룡렬해답 사용 가능"],
  rageArts: MoveInfo(name: "진결 화룡정천장", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 42, endAt: 56),
  types: {"heat" : false, "general" : false, "sit" : false, "lingering shadow" : false, "shifting clouds" : false, "deceptive step" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "lingering shadow" : "잔영", "shifting clouds" : "운수", "deceptive step" : "허보"},
  videoId: "fVW4i4byh3c"
);

Character hwoarang = Character(
  name: "hwoarang",
  heatSystem: ["파워가 상승한 오른 플라밍고 도중의 발차기 기술 사용 가능"],
  rageArts: MoveInfo(name: "스카이 베리얼", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "오른 자세, 왼 플라밍고, 오른 플라밍고 도중에도 사용 가능\n레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 35, endAt: 50),
  types: {"heat" : false, "general" : false, "sit" : false, "shark step" : false, "right stance" : false, "left flamingo" : false, "right flamingo" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "shark step" : "샤크 스텝", "right stance" : "오른 자세", "left flamingo" : "왼 플라밍고", "right flamingo" : "오른 플라밍고"},
  videoId: "cQMeT4HkcXY"
);

Character jack8 = Character(
  name: "jack-8",
  heatSystem: ["감마 차지 보유 시의 기술 사용 가능"],
  rageArts: MoveInfo(name: "테라포밍 캐논", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 37, endAt: 52),
  types: {"heat" : false, "general" : false, "sit" : false, "sit down" : false, "gamma howl" : false, "gamma charge" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "sit down" : "시트 다운", "gamma howl" : "감마 하울", "gamma charge" : "감마 차지"},
  videoId: "5v-CS2r5UbY"
);

Character jin = Character(
  name: "jin",
  heatSystem: ["데빌의 힘을 사용하는 새로운 기술 사용 가능", "최속 입력이 아니더라도 최속 왼 찔러 올리기와 최속 오른 돌려 찌르기 사용 가능"],
  rageArts: MoveInfo(name: "극성마인충", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 69, endAt: 83),
  types: {"heat" : false, "general" : false, "sit" : false, "breaking step" : false, "zanshin" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "breaking step" : "브레이킹 스텝", "zanshin" : "잔심"},
  videoId: "lucyXDt_7GY"
);

Character jun = Character(
  name: "jun",
  heatSystem: ["체력을 소비하지 않고 카자마의 힘(체력 소비 기술) 사용 가능", "파워가 상승한 감념상벽 사용 가능"],
  rageArts: MoveInfo(name: "아마츠 이자나미", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 43, endAt: 58),
  types: {"heat" : false, "general" : false, "sit" : false, "izumo" : false, "genjitsu" : false, "miare" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "izumo" : "이즈모", "genjitsu" : "환일", "miare" : "미아레"
  },
  videoId: "HWRp14BKC34"
);

Character kazuya = Character(
  name: "kazuya",
  heatSystem: ["데빌의 힘을 사용하는 새로운 기술 사용 가능", "최속 입력이 아니더라도 최속 풍신권 사용 가능"],
  rageArts: MoveInfo(name: "데모닉 카타스트로피", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 32, endAt: 46),
  types: {"heat" : false, "general" : false, "sit" : false, "wind god step" : false, "devil" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "wind god step" : "풍신 스텝", "devil" : "데빌"
  },
  videoId: "Ecyp7zTq69Q"
);

Character king = Character(
  name: "king",
  heatSystem: ["파워가 상승한 재규어 스프린트 사용 가능", "특정 잡기 기술로 히트 상태의 남은 시간 회복 가능"],
  rageArts: MoveInfo(name: "앵거 오브 더 비스트", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 43, endAt: 58),
  types: {"heat" : false, "general" : false, "sit" : false, "beast step" : false, "jaguar step" : false, "jaguar sprint" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "beast step" : "비스트 스텝", "jaguar step" : "재규어 스텝", "jaguar sprint" : "재규어 스프린트"
  },
  videoId: "P3Vky4ojnSw"
);

Character kuma = Character(
  name: "kuma",
  heatSystem: ["일부 홀드기가 원래보다 짧은 시간 입력으로 최대 홀드 성능이 됨", "파워가 상승한 베어 롤 사용 가능", "윈드 베어 피스트, 프레시 윈드 베어 피스트 사용 가능"],
  rageArts: MoveInfo(name: "타입 38 이래디케이션 웨폰: 아라마키", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 47, endAt: 61),
  types: {"heat" : false, "general" : false, "sit" : false, "hunting" : false, "bear sit" : false, "bear roll" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "hunting" : "헌팅", "bear sit" : "베어 시트", "bear roll" : "베어 롤"
  },
  videoId: "unownphUFS0"
);

Character lars = Character(
  name: "lars",
  heatSystem: ["파워가 상승한 리미티드 엔트리 사용 가능", "새로운 사일런트 엔트리 이행기 사용 가능"],
rageArts: MoveInfo(name: "제우스 언리미티드", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 43, endAt: 56),
  types: {"heat" : false, "general" : false, "sit" : false, "dynamic entry" : false, "silent entry" : false, "limited entry" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "dynamic entry" : "다이나믹 엔트리", "silent entry" : "사일런트 엔트리", "limited entry" : "리미티드 엔트리"
  },
  videoId: "OSV-i9rowzE"
);

Character law = Character(
  name: "law",
  heatSystem: ["파워가 상승한 쌍절곤 기술 사용 가능", "드래곤 차지로 펀치 공격 흘리기 가능"],
  rageArts: MoveInfo(name: "페이트 오브 더 드래곤", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 43, endAt: 56),
  types: {"heat" : false, "general" : false, "sit" : false, "dragon charge" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "dragon charge" : "드래곤 차지"
  },
  videoId: "raOOkq-k2So"
);

Character lee = Character(
  name: "lee",
  heatSystem: ["저스트 입력이 아니더라도 저스트 입력 기술 사용 가능", "저스트 입력 성공 시, 히트 상태의 남은 시간 회복"],
  rageArts: MoveInfo(name: "더 마벨러스 로즈", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n혹은 레이지 상태에서 히트맨 도중 ${sticks["c3"]}AP\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 43, endAt: 57),
  types: {"heat" : false, "general" : false, "sit" : false, "mist step" : false, "hitman" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "mist step" : "미스트 스텝", "hitman" : "히트맨"
  },
  videoId: "SY3giIyekKA"
);

Character leo = Character(
  name: "leo",
  heatSystem: ["섬전 보유 시의 기술 사용 가능"],
  rageArts: MoveInfo(name: "건곤회천황", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 45, endAt: 59),
  types: {"heat" : false, "general" : false, "sit" : false, "jin bu" : false, "jin ji du li" : false, "fo bu" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "jin bu" : "진보", "jin ji du li" : "금계독립", "fo bu" : "부보"
  },
  videoId: "NaYFkO6OwjE"
);

Character leroy = Character(
  name: "leroy",
  heatSystem: ["연환권을 비롯한 고속 연속 공격의 가드 대미지 증가", "리로이 고유의 흘리기, 반격기를 성공하면 히트 상태의 남은 시간 회복 가능"],
  rageArts: MoveInfo(name: "타계련환흑룡경", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 40, endAt: 55),
  types: {"heat" : false, "general" : false, "sit" : false, "hermit" : false, "cane" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "hermit" : "독보", "cane" : "지팡이"
  },
  videoId: "Xf_hxx9e_HY"
);

Character lili = Character(
  name: "lili",
  heatSystem: ["파워가 상승한 파이스티 래빗 사용 가능", "파워가 상승한 피어싱 톤 사용 가능"],
  rageArts: MoveInfo(name: "라 비 앙 로즈 포르티시시모", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 41, endAt: 54),
  types: {"heat" : false, "general" : false, "sit" : false, "dew glide" : false, "feisty rabbit" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "dew glide" : "듀 글라이드", "feisty rabbit" : "파이스티 래빗"
  },
  videoId: "sGIFlJzWJ94"
);

Character nina = Character(
  name: "nina",
  heatSystem: ["파워가 상승한 권총 기술 사용 가능", "키스 샷 페네트레이터 사용 가능"],
  rageArts: MoveInfo(name: "데스 바이 디그리즈", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 36, endAt: 50),
  types: {"heat" : false, "general" : false, "sit" : false, "ducking step" : false, "sway" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "ducking step" : "더킹 스텝", "sway" : "스웨이"
  },
  videoId: "pqVWqAvJqHE"
);

Character panda = Character(
  name: "panda",
  heatSystem: ["일부 홀드기가 원래보다 짧은 시간 입력으로 최대 홀드 성능이 됨", "파워가 상승한 베어 롤 사용 가능", "판다 슈팅 스타 사용 가능"],
  rageArts: MoveInfo(name: "클로즈 콜! 팬더 스토밍 플라워", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 35, endAt: 50),
  types: {"heat" : false, "general" : false, "sit" : false, "hunting" : false, "bear sit" : false, "bear roll" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "hunting" : "헌팅 자세", "bear sit" : "베어 시트", "bear roll" : "베어 롤"
  },
  videoId: "Yfghmn1CsrU"
);

Character paul = Character(
  name: "paul",
  heatSystem: ["파워가 상승한 붕권", "파워가 상승한 홀드기 사용 가능"],
  rageArts: MoveInfo(name: "빅뱅폭권", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 29, endAt: 42),
  types: {"heat" : false, "general" : false, "sit" : false, "cormorant step" : false, "sway" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "cormorant step" : "잠복 스텝", "sway" : "부초(스웨이)"
  },
  videoId: "kxEUjyHiuDA"
);

Character raven = Character(
  name: "raven",
  heatSystem: ["분신을 사용한 공격이 가드당했을 때 자동으로 추가 공격 발동", "분신을 사용한 공격이 히트했을 때 히트 상태의 남은 시간 회복", "티폰 팽 팬텀 사용 가능"],
  rageArts: MoveInfo(name: "와일드 헌트 X-에큐터", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 44, endAt: 59),
  types: {"heat" : false, "general" : false, "sit" : false, "shadow sprint" : false, "soulzone" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "shadow sprint" : "섀도 스프린트", "soulzone" : "소울존"
  },
  videoId: "mPBGzasEyCE"
);

Character reina = Character(
  name: "reina",
  heatSystem: ["일부 연계에서 겹쳐 죽이기 사용 가능", "최속 입력이 아니더라도 최속 풍신권, 최속 무신각 사용 가능", "금강벽으로 상중단 공격 흘리기 가능"],
  rageArts: MoveInfo(name: "멸신 찬연세괴", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 63, endAt: 78),
  types: {"heat" : false, "general" : false, "sit" : false, "wind god step" : false, "sentai" : false, "unsoku" : false, "heaven's wrath" : false, "wind step" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "wind god step" : "풍신 스텝", "sentai" : "선체", "unsoku" : "운족", "heaven's wrath" : "금강벽", "wind step" : "바람 다리"
  },
  videoId: "-k9n4wryC10"
);

Character shaheen = Character(
  name: "shaheen",
  heatSystem: ["손날을 사용하는 일부 기술이 히트했을 때 히트 상태의 남은 시간 회복", "알 굴 마스터 사용 가능"],
  rageArts: MoveInfo(name: "나즘 알샤말", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 35, endAt: 53),
  types: {"heat" : false, "general" : false, "sit" : false, "stealth step" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "stealth step" : "스텔스 스텝"
  },
  videoId: "9sw9rU26src"
);

Character steve = Character(
  name: "steve",
  heatSystem: ["새로운 더킹 인 이행기 사용 가능", "투-페이스드 사용 가능", "라이온 하트로 중단 공격 흘리기 가능"],
  rageArts: MoveInfo(name: "디어 랜드 오브 호프", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 76, endAt: 91),
  types: {"heat" : false, "general" : false, "sit" : false, "ducking left/right" : false, "quick spin" : false, "ducking/ducking in" : false, "peekaboo" : false, "swaying" : false, "flicker stance" : false, "lion heart" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "ducking left/right" : "더킹 레프트/라이트", "quick spin" : "퀵 스핀", "ducking/ducking in" : "더킹/더킹 인", "peekaboo" : "피커브", "swaying" : "스웨이", "flicker stance" : "플리커 자세", "lion heart" : "라이온 하트"
  },
  videoId: "lCn4-wDeOD8"
);

Character victor = Character(
  name: "victor",
  heatSystem: ["파워가 상승한 파보", "백양염제파, 백련염제파 사용 가능"],
  rageArts: MoveInfo(name: "쿠 드 슈발리에", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 48, endAt: 63),
  types: {"heat" : false, "general" : false, "sit" : false, "iai Stance" : false, "perfumer" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "iai Stance" : "이아이 스탠스", "perfumer" : "퍼퓨머"
  },
  videoId: "bcKehXKweTg"
);

Character xiaoyu = Character(
  name: "xiaoyu",
  heatSystem: ["파워가 상승한 파보", "백양염제파, 백련염제파 사용 가능"],
  rageArts: MoveInfo(name: "왕전비초 구천진공", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 57, endAt: 61),
  types: {"heat" : false, "general" : false, "back" : false, "sit" : false, "hypnotist" : false, "phoenix" : false},
  typesKo: {
    "heat" : "히트", "general" : "일반", "back" : "뒤자세", "sit" : "앉은 자세", "hypnotist" : "파보", "phoenix" : "봉황"
  },
  videoId: "kRj2yD5-4Q4"
);

Character yoshimitsu = Character(
  name: "yoshimitsu",
  heatSystem: ["납도 자세 도중에만 쓸 수 있는 파워 상승 버전 칼 기술을 일반 자세에서도 사용 가능", "만잠자리 자세 도중의 일부 칼 기술이 파워 상승"],
  rageArts: MoveInfo(name: "삼계순회 제행무상", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 32, endAt: 47),
  types: {"heat" : false, "general" : false, "sit" : false, "kincho" : false, "meditation" : false, "flea" : false, "indian stance" : false, "mutou no kiwami" : false, "manji dragonfly" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "kincho" : "금타 자세", "meditation" : "무상 자세", "flea" : "지뢰인 자세", "indian stance" : "만자앉기 자세", "mutou no kiwami" : "납도 자세", "manji dragonfly" : "만잠자리 자세"},
  videoId: "32pYkK8wrP8"
);

Character zafina = Character(
  name: "zafina",
  heatSystem: ["아자젤의 힘(체력 소비 기술)이 발동했을 때 체력을 소비하지 않음", "아자젤의 힘에 의한 큰 기술이 파워 크래시가 됨"],
  rageArts: MoveInfo(name: "셈퍼 어바러스 어젯", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "혹은 레이지 상태에서 스케어크로 자세 도중 ${sticks["c3"]}AP 레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 39, endAt: 53),
  types: {"heat" : false, "general" : false, "sit" : false, "scarecrow stance" : false, "tarantula stance" : false, "mantis stance" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "scarecrow stance" : "스케어크로 자세", "tarantula stance" : "타란튤라 자세", "mantis stance" : "맨티스 자세"},
  videoId: "vshwmLE3bpo"
);

Character eddy = Character(
  name: "eddy",
  heatSystem: ["게헤이루 에시플로지부 사용 가능", "하부 지 아하이아 리베라두 사용 가능"],
  rageArts: MoveInfo(name: "인셴치 지 아셰", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 45, endAt: 59),
  types: {"heat" : false, "general" : false, "sit" : false, "bananeira" : false, "negativa" : false, "mandinga" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "bananeira" : "바나네이라", "negativa" : "네가치바", "mandinga" : "만징가"},
  videoId: "bEKK2uh7ea8"
);

Character lidia = Character(
  name: "lidia",
  heatSystem: ["천상천하 자세 사용 가능", "파워가 상승한 AP, →→~RP, →→→~LP, 후랑 자세 중 LP 사용 가능"],
  rageArts: MoveInfo(name: "스칼렛 발러: 마샬 디보션", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 42, endAt: 56),
  types: {"heat" : false, "general" : false, "sit" : false, "horse stance" : false, "cat stance" : false, "wolf stance" : false, "heaven and earth" : false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "horse stance" : "말 자세", "cat stance" : "묘족 자세", "wolf stance" : "후랑 자세", "heaven and earth" : "천상천하 자세"},
  videoId: "ZYSdvZ6qaEk"
);

Character heihachi = Character(
  name: "heihachi",
  heatSystem: ["최속뇌신권, 최속풍신권이 최속 입력이 아니더라도 사용 가능", "번개를 두른 강력한 기술을 사용 가능", "풍신호법으로 상중단 공격에 대한 반격기 효과 사용 가능", "특수한 강화 상태 「미시마류 최종오의 무의 경지」 사용 가능"],
  rageArts: MoveInfo(name: "미시마류 오의 귀신풍뢰권", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 72, endAt: 87),
  types: {"heat" : false, "general" : false, "sit" : false, "wind god step": false, "thunder god's kamae": false, "wind god's kamae": false, "warrior instinct": false},
  typesKo: {"heat" : "히트", "general" : "일반", "sit" : "앉은 자세", "wind god step": "풍신 스텝", "thunder god's kamae": "뇌신호법", "wind god's kamae": "풍신호법", "warrior instinct": "무의 경지"},
  videoId: "VI5e0Nralcw"
);

Character clive = Character(
    name: "clive",
    heatSystem: ["강력한 이프리트의 어빌리티를 사용 가능", "토르갈의 파상 공격이 파워 상승"],
    rageArts: MoveInfo(name: "지옥의 화염", command: "레이지 상태에서 ${sticks["c3"]}AP", startFrame: "20", guardFrame: "-15", hitFrame: "D", counterFrame: "D", range: "중단", damage: "55", extra: "레이지 아츠\n히트 시 상대의 회복 가능 게이지를 없앰", startAt: 70, endAt: 87),
    types: {"heat": false, "general": false, "sit": false, "zantetsuken": false, "wings of light": false, "phoenix shift": false, "updraft": false},
    typesKo: {"heat": "히트", "general": "일반", "sit": "앉은 자세", "zantetsuken": "참철검", "wings of light": "바하무트 윙", "phoenix shift": "피닉스 시프트", "updraft": "업드래프트"},
    videoId: "L9sqXtKD7KQ"
);

final characterList = [alisa, asuka, azucena, bryan, claudio, devilJin, dragunov, feng, hwoarang, jack8, jin, jun, kazuya, king, kuma, lars, law, lee, leo, leroy, lili, nina, panda, paul, raven, reina, shaheen, steve, victor, xiaoyu, yoshimitsu, zafina, eddy, lidia, heihachi, clive];