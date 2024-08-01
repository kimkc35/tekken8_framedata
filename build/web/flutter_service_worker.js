'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c92954892ac539c574ca0ad0390a67a4",
"assets/AssetManifest.bin.json": "99c8de2cb040fd278963f5082187af6f",
"assets/AssetManifest.json": "dd71683604417b18eafcabca0c146141",
"assets/assets/alisa/move_commands.txt": "5ced073926ae41439beaae2b875b7ec0",
"assets/assets/alisa/move_commands_en.txt": "9b08425779bf1cedefd4fb10aee22277",
"assets/assets/alisa/move_counter_frames.txt": "7f3cbcde67831ffca001ffa2950b59e4",
"assets/assets/alisa/move_damages.txt": "855d6ac5b735619d89bb4cfe4be1a279",
"assets/assets/alisa/move_extras.txt": "90c70f341e4323e24392109356ca6a6c",
"assets/assets/alisa/move_guard_frames.txt": "acf63e95e99f066264456737f9c6fddf",
"assets/assets/alisa/move_hit_frames.txt": "f75a5087a990ce81f79c2a1248da179e",
"assets/assets/alisa/move_names.txt": "149f5d82d48e40bf36b2906d01865fc6",
"assets/assets/alisa/move_names_en.txt": "635d0193cd12cd11aed137f0b6179c0c",
"assets/assets/alisa/move_ranges.txt": "f07f23db8cec578dfc06520f69e6a624",
"assets/assets/alisa/move_start_frames.txt": "df5534a166ce7b5c1b2b6472f36ddca2",
"assets/assets/alisa/throw_after_break_frames.txt": "b33b35732dd5439275e96556c638bf1b",
"assets/assets/alisa/throw_break_commands.txt": "e744a84c3831e69e237f06a44d34eafc",
"assets/assets/alisa/throw_commands.txt": "17664b2527037513c3c73d1b020c2539",
"assets/assets/alisa/throw_damages.txt": "6798b8551ec2867c5f60c4ad3bc82e1c",
"assets/assets/alisa/throw_extras.txt": "78e94d7968f5a4bd5e3463c6dc82f2e9",
"assets/assets/alisa/throw_names.txt": "c3e5ccf64e48d0224549ec722d69f859",
"assets/assets/alisa/throw_ranges.txt": "156265998c7fb148a37c53d86ab8f6b2",
"assets/assets/alisa/throw_start_frames.txt": "b3fe5e199df28e1ae15926a91f3ebfaa",
"assets/assets/asuka/move_commands.txt": "eeea1f4b4b72b485e9317c510fecd5d3",
"assets/assets/asuka/move_commands_en.txt": "f0c3b10fae05909cee35fee2c4a04240",
"assets/assets/asuka/move_counter_frames.txt": "66b7f0a6b73bdbcf74ff592874466186",
"assets/assets/asuka/move_damages.txt": "2a9b69f7342cbb3e82de134df3735052",
"assets/assets/asuka/move_extras.txt": "5f93ff81336a746ad769b89c057da55e",
"assets/assets/asuka/move_guard_frames.txt": "8e738a10c783c2f90077c95e1d7b59f1",
"assets/assets/asuka/move_hit_frames.txt": "dac9b2743177fbe399b476131fdc3b34",
"assets/assets/asuka/move_names.txt": "03f0d2a0478ff63cba801508b66c8196",
"assets/assets/asuka/move_names_en.txt": "4850470b4bfd61110f497d48bf5fdd8b",
"assets/assets/asuka/move_ranges.txt": "1a2f1115daa14b0b0364323daa955bd8",
"assets/assets/asuka/move_start_frames.txt": "b5baed6f283a55fc54fccd5da2529ed6",
"assets/assets/asuka/throw_after_break_frames.txt": "4e1fdaec6b8797c23cd0e8adcf437678",
"assets/assets/asuka/throw_break_commands.txt": "0037dced914284bd31260f8a9cab25ba",
"assets/assets/asuka/throw_commands.txt": "3fa1d3be661a87f092f7a3c3e10f9386",
"assets/assets/asuka/throw_damages.txt": "88f2f8e81f1ebee91b0f962ac4e51f07",
"assets/assets/asuka/throw_extras.txt": "6661b016801979d6e1a872ac0402073a",
"assets/assets/asuka/throw_names.txt": "50df8bc205fac8e30744f5a2e584155e",
"assets/assets/asuka/throw_ranges.txt": "d0ad83dd44fc47bc135b36427c4aa4b1",
"assets/assets/asuka/throw_start_frames.txt": "fe40c3f10cea6b9bf01cb8c2145969f3",
"assets/assets/azucena/move_commands.txt": "2fe8c6575d76e627c4c705d38319159b",
"assets/assets/azucena/move_counter_frames.txt": "e2993aab57fe2f7c6bbb82c25ab2633b",
"assets/assets/azucena/move_damages.txt": "ea2e99bd6fa562f8a679f7ef011125bf",
"assets/assets/azucena/move_extras.txt": "bebdc452d2596e3270b3a8a8830df842",
"assets/assets/azucena/move_guard_frames.txt": "44de153da3101ad1a96a609527179800",
"assets/assets/azucena/move_hit_frames.txt": "841d8897009913dcd9214db655913893",
"assets/assets/azucena/move_names.txt": "3378f3ff171f8826cb88a1950da0023f",
"assets/assets/azucena/move_names_en.txt": "d1324f7fa881cb043fe931c693a696e9",
"assets/assets/azucena/move_ranges.txt": "851ec3ea96cd301d1c380c18ca05a36b",
"assets/assets/azucena/move_start_frames.txt": "19e867a96a0e10083b9fbfc0688523ca",
"assets/assets/azucena/throw_after_break_frames.txt": "23c14aa15d163315b522fc1f96cb6bcd",
"assets/assets/azucena/throw_break_commands.txt": "4207554e9a7897dcf403e88f5d8868e5",
"assets/assets/azucena/throw_commands.txt": "a765e043483b3209b8f020e69c969de2",
"assets/assets/azucena/throw_damages.txt": "a024e12c4b9babecc4b0a8e71a8ed5a6",
"assets/assets/azucena/throw_extras.txt": "ed7247eee7d29fa6b09b30afa4b39079",
"assets/assets/azucena/throw_names.txt": "37b81a4d6c4ad9e54ccfc7ee9d85b328",
"assets/assets/azucena/throw_ranges.txt": "f53437a5ccbe0983490f7905d3318513",
"assets/assets/azucena/throw_start_frames.txt": "bc671627ec680b597869a53a00e1f0c7",
"assets/assets/bryan/move_commands.txt": "bfb90aa952e3de7848ec0276c2271149",
"assets/assets/bryan/move_counter_frames.txt": "e354dd098c51bf0adcc5c0875d51ce91",
"assets/assets/bryan/move_damages.txt": "137536e5f033205b59307e3031212715",
"assets/assets/bryan/move_extras.txt": "4a4d886ab3a4f88b9336c2ada5327c30",
"assets/assets/bryan/move_guard_frames.txt": "2a4404ed4d553dc23b48f05471be865d",
"assets/assets/bryan/move_hit_frames.txt": "54377031491626233a818ef44425af53",
"assets/assets/bryan/move_names.txt": "083fd4a69dd7deae6f0969330113cc24",
"assets/assets/bryan/move_names_en.txt": "2280cffa1a2e15d2d61744f745789f8d",
"assets/assets/bryan/move_ranges.txt": "820f2d92ccb353b28dda4af010f3a4e0",
"assets/assets/bryan/move_start_frames.txt": "9148d31a395e764d6ffa3e6da5454d9c",
"assets/assets/bryan/throw_after_break_frames.txt": "e5744a07ece8d60e17975ba85f2e3c25",
"assets/assets/bryan/throw_break_commands.txt": "d22af989f792240adebad9a6a0ac48a0",
"assets/assets/bryan/throw_commands.txt": "66a1d7e5dcbe017a80d4223e61ab684c",
"assets/assets/bryan/throw_damages.txt": "db606e3d37f6225a29131653eeaf7c08",
"assets/assets/bryan/throw_extras.txt": "89be40d8bc8c23ef48489fa071d7fa9c",
"assets/assets/bryan/throw_names.txt": "c6bab72e210607b6d04f59052c46538c",
"assets/assets/bryan/throw_ranges.txt": "7ba36bb233a09b958f8a373f8bf04527",
"assets/assets/bryan/throw_start_frames.txt": "617848ac6513e461faf17543686e7073",
"assets/assets/claudio/move_commands.txt": "2717e3ee7516afe8a5dd89b11423abdc",
"assets/assets/claudio/move_counter_frames.txt": "1a5a26341fa19721cb07dcf7773949b5",
"assets/assets/claudio/move_damages.txt": "bcab99108f252488eaa42442e4ff14e3",
"assets/assets/claudio/move_extras.txt": "5f4be4222efae3e3c0e5f5fa68b06650",
"assets/assets/claudio/move_guard_frames.txt": "88a4dcb3775408e660d3246223a1b1f5",
"assets/assets/claudio/move_hit_frames.txt": "1125d779a0c11f47d26542b023296d99",
"assets/assets/claudio/move_names.txt": "2d0a2cab0795055b1fd81a25df095be8",
"assets/assets/claudio/move_names_en.txt": "ce032910023a1a46e58df63eabe3c085",
"assets/assets/claudio/move_ranges.txt": "780deabd8f363b946763bae13f71987a",
"assets/assets/claudio/move_start_frames.txt": "4143daa86f452401f03c0492b0ed110e",
"assets/assets/claudio/throw_after_break_frames.txt": "228ae080bac15440b495f3d7fe70a6cc",
"assets/assets/claudio/throw_break_commands.txt": "3386abbb130402e14caf63da7d0a7a04",
"assets/assets/claudio/throw_commands.txt": "878781e678afcb6ee9971a2bf40d5818",
"assets/assets/claudio/throw_damages.txt": "ad0d02ade8dfd8a0eae6a3a00b87ca46",
"assets/assets/claudio/throw_extras.txt": "a3ccf47129590e525cffb7b8ee1dead0",
"assets/assets/claudio/throw_names.txt": "f8e7e7ebdba8fc72574c820f13338be4",
"assets/assets/claudio/throw_ranges.txt": "06c697fa40541292ec855740cf793467",
"assets/assets/claudio/throw_start_frames.txt": "81a02ef7e398abfe936dca70969e2225",
"assets/assets/devil%2520jin/move_commands.txt": "f74c55d87205badc6a2ea85dd8a1658a",
"assets/assets/devil%2520jin/move_counter_frames.txt": "8451a2641b09a90db6072910d775a65d",
"assets/assets/devil%2520jin/move_damages.txt": "70995165c2c3c66ef946f353ea40b6c2",
"assets/assets/devil%2520jin/move_extras.txt": "35b78b92f41b519065172acb5339efa1",
"assets/assets/devil%2520jin/move_guard_frames.txt": "0d3ed6ecee0a167f5cf2f8e74b89bbca",
"assets/assets/devil%2520jin/move_hit_frames.txt": "293d427d3430d1d6e55916127323fa17",
"assets/assets/devil%2520jin/move_names.txt": "d04e397a6b1943b149cfbee8936bc914",
"assets/assets/devil%2520jin/move_names_en.txt": "3bc478007a9655d0488bfccda4f498a5",
"assets/assets/devil%2520jin/move_ranges.txt": "a1350e9589d52c393d627682585702b4",
"assets/assets/devil%2520jin/move_start_frames.txt": "0635a85150caf42e39c8464963a4ca1e",
"assets/assets/devil%2520jin/throw_after_break_frames.txt": "b0ddd159de37ea8d1a9c98cdc6b1ebff",
"assets/assets/devil%2520jin/throw_break_commands.txt": "32593204a5ae762e05fe5f4568f49565",
"assets/assets/devil%2520jin/throw_commands.txt": "624f9facf9d75cf23bba045eacea4cb6",
"assets/assets/devil%2520jin/throw_damages.txt": "c96401110bec26e374b953ef2c857eeb",
"assets/assets/devil%2520jin/throw_extras.txt": "9a1178c45843e630c1daf8bc6b95b17f",
"assets/assets/devil%2520jin/throw_names.txt": "65f439bebff8a66f4354e30099843218",
"assets/assets/devil%2520jin/throw_ranges.txt": "d5321e5008d6787909d360cd6d2c0b19",
"assets/assets/devil%2520jin/throw_start_frames.txt": "79a4694aa24e76490ce05c49ce4e7729",
"assets/assets/dragunov/move_commands.txt": "d82e69b157910a6fb6d809492c891757",
"assets/assets/dragunov/move_counter_frames.txt": "f984011724a1235f6d285bb2777e6774",
"assets/assets/dragunov/move_damages.txt": "d51a92723b0462432fb3e9fc51097d68",
"assets/assets/dragunov/move_extras.txt": "36b37a6117720650be46d8ca2255ebc6",
"assets/assets/dragunov/move_guard_frames.txt": "d147436829f53249d7c85d4b962c58a6",
"assets/assets/dragunov/move_hit_frames.txt": "761031cff4eecf6d78841a6b18f1fc59",
"assets/assets/dragunov/move_names.txt": "0dcd8379f457ac3f6f3421b0fa197837",
"assets/assets/dragunov/move_names_en.txt": "f934adb480920502653e0674329fdab8",
"assets/assets/dragunov/move_ranges.txt": "f32f2cf4341141047a67f2bf1b7bfe30",
"assets/assets/dragunov/move_start_frames.txt": "841e638563166f3abf0ab0b7e33a6b4c",
"assets/assets/dragunov/throw_after_break_frames.txt": "c874efd21b427adecad4870858850c84",
"assets/assets/dragunov/throw_break_commands.txt": "455af1e159cda1a88ebcdba85c44217c",
"assets/assets/dragunov/throw_commands.txt": "7af013fe2e3fdd580c1e3d5261f58c1a",
"assets/assets/dragunov/throw_damages.txt": "a76a40a25f75e08e19ec3c8d8877ecec",
"assets/assets/dragunov/throw_extras.txt": "43822a0fe8dc9f9addf9eaa4b4840ba5",
"assets/assets/dragunov/throw_names.txt": "22c91242dec5177541121a89b742c6f1",
"assets/assets/dragunov/throw_ranges.txt": "e89732ef8a6f3593c85b572323e9d7d0",
"assets/assets/dragunov/throw_start_frames.txt": "4e349bc2b749851acf38fdbf31907b75",
"assets/assets/eddy/move_commands.txt": "bdfd61fc82ed18d1fe8ccade6ec918e1",
"assets/assets/eddy/move_counter_frames.txt": "0f5eb4d13aa3fc71f54876a3870ad453",
"assets/assets/eddy/move_damages.txt": "f3908888b7d03801066cba38ab522e3a",
"assets/assets/eddy/move_extras.txt": "0ece62d4e5181ce15573a5d0e6194cc0",
"assets/assets/eddy/move_guard_frames.txt": "6db9f4aaa57278396a4fbfdc86e044e3",
"assets/assets/eddy/move_hit_frames.txt": "30cdb653ee98285e1cfa00820e220c9f",
"assets/assets/eddy/move_names.txt": "8fa5809f015b8752852c64c8e945d0ec",
"assets/assets/eddy/move_names_en.txt": "f934adb480920502653e0674329fdab8",
"assets/assets/eddy/move_ranges.txt": "4136ac58c9f3e26a4ccdb7362476eb67",
"assets/assets/eddy/move_start_frames.txt": "4fd318eda34db74de4173e4a544d5efd",
"assets/assets/eddy/throw_after_break_frames.txt": "96fe84186323674d6b99a00fc3dc59e6",
"assets/assets/eddy/throw_break_commands.txt": "6bc1131afcb320cf023402b5e22c9e18",
"assets/assets/eddy/throw_commands.txt": "ae5123a839e3b908f1449a4abd8df2c6",
"assets/assets/eddy/throw_damages.txt": "df59fce7fa46ba487e5bfdd6430b24cb",
"assets/assets/eddy/throw_extras.txt": "678d9bd0bdfaf67a90d940c0e8e274c2",
"assets/assets/eddy/throw_names.txt": "af3f04845d6dfb82bdb90748de5ac5e1",
"assets/assets/eddy/throw_ranges.txt": "e6bb0ddd7b91bfae2bba093bc311f571",
"assets/assets/eddy/throw_start_frames.txt": "40beb59f76e8f9e71566c93c4d0710fd",
"assets/assets/feng/move_commands.txt": "e2926244fec6be9b5b3d52451770f5cd",
"assets/assets/feng/move_counter_frames.txt": "798e042bf08701d5586eb4008ab55b3e",
"assets/assets/feng/move_damages.txt": "110fff20ebb8ddc0feb4a7654a48fd04",
"assets/assets/feng/move_extras.txt": "f9b59d70ae83d7af1009f526a32c7a89",
"assets/assets/feng/move_guard_frames.txt": "5339ff1e6abf53fb21d77be951984fc7",
"assets/assets/feng/move_hit_frames.txt": "3a81f4acd12cb85b0d3b4986c434ae4e",
"assets/assets/feng/move_names.txt": "ffd405b02e0305450eddea701b15b203",
"assets/assets/feng/move_names_en.txt": "1f75060e653c758fa2d576b9ce11fe99",
"assets/assets/feng/move_ranges.txt": "2bbdb4c0f3223036bba3f4c8878d0d3e",
"assets/assets/feng/move_start_frames.txt": "483d8814cc2f86ffaab23119ea11b594",
"assets/assets/feng/throw_after_break_frames.txt": "51b9be987b80ce2edc2fc218bd28790f",
"assets/assets/feng/throw_break_commands.txt": "3de93156e54b70db94383253af424a89",
"assets/assets/feng/throw_commands.txt": "34238bd7835e2711a6c694b59797f3b4",
"assets/assets/feng/throw_damages.txt": "3f849c8dd81fb134e1710fe9586e0709",
"assets/assets/feng/throw_extras.txt": "748a7103d1048b9c9adc2514d6af1db6",
"assets/assets/feng/throw_names.txt": "c627284cff6238450e1c36caed557050",
"assets/assets/feng/throw_ranges.txt": "12960a5e530e1784172ece306590d08e",
"assets/assets/feng/throw_start_frames.txt": "36099e4450c6bc558232b51819320e5e",
"assets/assets/fonts/ONE%2520Mobile%2520Bold.ttf": "79badd71ce490387bb296d5928e298cd",
"assets/assets/fonts/Tenada.ttf": "0ba8366fb06b6b4c2fe9d6b83ac85bcf",
"assets/assets/hwoarang/move_commands.txt": "e12c0c87ccc3796e807af848f83d0365",
"assets/assets/hwoarang/move_counter_frames.txt": "92afa0bb1f0e93e1e0858fb04f96b4a0",
"assets/assets/hwoarang/move_damages.txt": "455a628b47dcdcb00946e65f5f50d6e3",
"assets/assets/hwoarang/move_extras.txt": "05ea53db450503c31b33c35315b5163d",
"assets/assets/hwoarang/move_guard_frames.txt": "d7c2e734fe0663a5d97dfdce3c0c45f5",
"assets/assets/hwoarang/move_hit_frames.txt": "db9fdd96d8b3833a588f70a45f750fcc",
"assets/assets/hwoarang/move_names.txt": "1de72f84b25f57828e092c23b0c7192e",
"assets/assets/hwoarang/move_names_en.txt": "bd2d942438d90ac0b37fd5c7e77a90fb",
"assets/assets/hwoarang/move_ranges.txt": "e604b934f15dba3ddb957729f7304694",
"assets/assets/hwoarang/move_start_frames.txt": "fa91c05711f833719c37dc163760c237",
"assets/assets/hwoarang/throw_after_break_frames.txt": "5de47755a761ca77ceaf32855e5d724a",
"assets/assets/hwoarang/throw_break_commands.txt": "ae43c7c2f47b95452d2f58dc1b7a5c3e",
"assets/assets/hwoarang/throw_commands.txt": "314424d596bad7bf8f4566acffef08a8",
"assets/assets/hwoarang/throw_damages.txt": "02aea0dbfe85399aca8f5d96f6729533",
"assets/assets/hwoarang/throw_extras.txt": "05cb3a1250580c09e54ba21b6b816843",
"assets/assets/hwoarang/throw_names.txt": "657792055c872aecf6360b854eaa46b6",
"assets/assets/hwoarang/throw_ranges.txt": "1e8b887beaec0d2fe8c324f45f372638",
"assets/assets/hwoarang/throw_start_frames.txt": "1c366b65f744c76e492c3efefabcaecb",
"assets/assets/icons/free.png": "9c520a9a558c970cfe6c3bd8286dca6d",
"assets/assets/icons/pro.png": "c7bfc5fc630df183d38106a415a420b1",
"assets/assets/internal/patch_note.json": "b1bbf4010f9add549a3ab1a52ca060ef",
"assets/assets/jack-8/move_commands.txt": "e834c624b5b70839ee9fb5c8edb874ec",
"assets/assets/jack-8/move_counter_frames.txt": "829d81dcd6f2848eb54fffc48a6357c7",
"assets/assets/jack-8/move_damages.txt": "0a191676e6ad554f2abdcd861d5281fe",
"assets/assets/jack-8/move_extras.txt": "dcf6b5fc5e265d44c43c7e6c65574f8a",
"assets/assets/jack-8/move_guard_frames.txt": "2a832bd95c096da658e30733210f1fd3",
"assets/assets/jack-8/move_hit_frames.txt": "cfac5c6ff35f39a89c00d533321a9a82",
"assets/assets/jack-8/move_names.txt": "8567163cc6d8ccc68b325d6b29ce6ed8",
"assets/assets/jack-8/move_names_en.txt": "f1defcf641710988a4b59c8dc3ed2a9a",
"assets/assets/jack-8/move_ranges.txt": "fe3d85abc2e68b0d33169d7ab5a362a1",
"assets/assets/jack-8/move_start_frames.txt": "0abfdf7b8c40cc2d90f46703e1059e45",
"assets/assets/jack-8/throw_after_break_frames.txt": "23bb04cab0b8c2d690f2155f2efdadbb",
"assets/assets/jack-8/throw_break_commands.txt": "83804ef72357db5c1867d40b703c5953",
"assets/assets/jack-8/throw_commands.txt": "2cac3b1c8436489ec83507efd4c1841b",
"assets/assets/jack-8/throw_damages.txt": "b4e8b78f9048f8cb2827070103cd75f5",
"assets/assets/jack-8/throw_extras.txt": "e6580acd7c179f50680e4283f3603c9c",
"assets/assets/jack-8/throw_names.txt": "f92c9ff16a89fed5a62efd9f523c26b7",
"assets/assets/jack-8/throw_ranges.txt": "39ba1131ca98ecaffd682cb833409c63",
"assets/assets/jack-8/throw_start_frames.txt": "7199720de0bd570e86e635fc197f6993",
"assets/assets/jin/move_commands.txt": "aa72b64b440821998bca0859445b9731",
"assets/assets/jin/move_counter_frames.txt": "cf6d514640d4db406516b76fb972bb8e",
"assets/assets/jin/move_damages.txt": "2db2226b6f2b1ab024ba6fe754029b40",
"assets/assets/jin/move_extras.txt": "f56718558256a775f8645d534cdf2ddd",
"assets/assets/jin/move_guard_frames.txt": "2ae708bbfd92f82ed65cdd8cc947d333",
"assets/assets/jin/move_hit_frames.txt": "1e049e4fa50e77ae9973895734eea473",
"assets/assets/jin/move_names.txt": "d76207af673db3d99c7f93b6ba141454",
"assets/assets/jin/move_names_en.txt": "03bccfa008c29fc622bed7b2097c09a6",
"assets/assets/jin/move_ranges.txt": "89146fd9c5c0e3eb6931fa7a5597b8f8",
"assets/assets/jin/move_start_frames.txt": "6c74c84e24f0b130b8137e9ff827b906",
"assets/assets/jin/throw_after_break_frames.txt": "1e934ce22f62cb794d5344a8b4f17974",
"assets/assets/jin/throw_break_commands.txt": "3ec0769e5c110f10b4f9f980c95655ea",
"assets/assets/jin/throw_commands.txt": "8f58e074c02084093e6e64728d123353",
"assets/assets/jin/throw_damages.txt": "c70b41a72feee88365ff9e21ac0986f6",
"assets/assets/jin/throw_extras.txt": "d7c4113756bd15b5fdd318e1d23102b9",
"assets/assets/jin/throw_names.txt": "8a2f1abc503292addae3f48b574c315c",
"assets/assets/jin/throw_ranges.txt": "ceef1226b9b43c221ee79f5f4ea13e09",
"assets/assets/jin/throw_start_frames.txt": "b5805925b8aa567d448842df6d8ad7c3",
"assets/assets/jun/move_commands.txt": "c3209e896d1362190e20c6c55f7396c2",
"assets/assets/jun/move_counter_frames.txt": "df5503bfe122100233607b3d4d7e88e8",
"assets/assets/jun/move_damages.txt": "03db22f9e9b5da901cb8926876663de7",
"assets/assets/jun/move_extras.txt": "2c08c95cfae747e5d5974025e9c791cb",
"assets/assets/jun/move_guard_frames.txt": "81a5de0167c5eb16832ed899849975b1",
"assets/assets/jun/move_hit_frames.txt": "916fec00c47cdd350dbb608c3bb6c879",
"assets/assets/jun/move_names.txt": "5a544e2443f979cc47f713e13dde0302",
"assets/assets/jun/move_names_en.txt": "cdd47915ed0818c72edbe4f9fbcf19e6",
"assets/assets/jun/move_ranges.txt": "1c0869a181596f1628b162ed777302bb",
"assets/assets/jun/move_start_frames.txt": "33429ec4441ec184e8784a364379592e",
"assets/assets/jun/throw_after_break_frames.txt": "cff39d4b91383c97f4e30da53c7f4199",
"assets/assets/jun/throw_break_commands.txt": "0f41a3a463611fd85b47a3c660089eb5",
"assets/assets/jun/throw_commands.txt": "ba15cf09bd0f45d4b9836a8cdacaaf6c",
"assets/assets/jun/throw_damages.txt": "b62ceccdd43a2e72f11a36288b7ec9f1",
"assets/assets/jun/throw_extras.txt": "656b7880395e863dff62015575f25946",
"assets/assets/jun/throw_names.txt": "f87a685620a617ca4b1f4217652cf6ee",
"assets/assets/jun/throw_ranges.txt": "197f98cdb14e147cc079050610394a27",
"assets/assets/jun/throw_start_frames.txt": "29c95b0342852ec42b4b42164cd548d5",
"assets/assets/kazuya/move_commands.txt": "1798e633f0fdede960ca7bafc9ec9e18",
"assets/assets/kazuya/move_counter_frames.txt": "39dd422a05d5f14aafdc2d80932dafc1",
"assets/assets/kazuya/move_damages.txt": "0eacc0141894be19d8b80ed1428de667",
"assets/assets/kazuya/move_extras.txt": "31d2d5fe028d36ad488ce377bd7046c8",
"assets/assets/kazuya/move_guard_frames.txt": "56506373ef829a632dc038a2af69e640",
"assets/assets/kazuya/move_hit_frames.txt": "c20d7d40007dc205d59d94638b63367f",
"assets/assets/kazuya/move_names.txt": "625fad7b697c23cb0df0d923ce8827e9",
"assets/assets/kazuya/move_names_en.txt": "ec241d755be39cd291ab175a88ffff6f",
"assets/assets/kazuya/move_ranges.txt": "87c82629294de0b8415d147de18ef097",
"assets/assets/kazuya/move_start_frames.txt": "ae71908e763080df7a758a5ec6f89d80",
"assets/assets/kazuya/throw_after_break_frames.txt": "892690a166080013ad4fa159b84da90c",
"assets/assets/kazuya/throw_break_commands.txt": "0d9b983df019b9bd7c95a25575c63969",
"assets/assets/kazuya/throw_commands.txt": "a70eb1dcb287c5e4b5faf59f7c045361",
"assets/assets/kazuya/throw_damages.txt": "84f7625fecc3df6ce3f5b3ba3ab455f5",
"assets/assets/kazuya/throw_extras.txt": "7c2d95e41ff9967a13a44cdd5436a2e2",
"assets/assets/kazuya/throw_names.txt": "2c5f3ebc45582709ef802b810c11c179",
"assets/assets/kazuya/throw_ranges.txt": "7b820caaf57d3e5bfc242f3576e3e2d2",
"assets/assets/kazuya/throw_start_frames.txt": "8f95cb924d4a9f433f577dc2fdebb8e9",
"assets/assets/king/move_commands.txt": "fecf92198969958b3a23003a9045edfe",
"assets/assets/king/move_counter_frames.txt": "5467129f6e1130cd7ba74acdca5de73e",
"assets/assets/king/move_damages.txt": "53a1292d26979b2e8791b17bfbe0e76c",
"assets/assets/king/move_extras.txt": "a38623b5918eb2d90da6b97451bb07df",
"assets/assets/king/move_guard_frames.txt": "a200b261c2ea7ec317769b8678ba30b9",
"assets/assets/king/move_hit_frames.txt": "a0405b18ca6a3966798c6bf389ad65f2",
"assets/assets/king/move_names.txt": "73ac665bd798ed7f655bc4991e8f6754",
"assets/assets/king/move_names_en.txt": "35fbc351b7cca0962e38db216638f97d",
"assets/assets/king/move_ranges.txt": "ded8e03dd73167bcb181252fe03e8905",
"assets/assets/king/move_start_frames.txt": "a1038d844d3db87e63485dc32f30b5ba",
"assets/assets/king/throw_after_break_frames.txt": "c47ee6eea61657f63303e8e7c9dbeef4",
"assets/assets/king/throw_break_commands.txt": "5200d9ab46c26e51514cb2588f3f4621",
"assets/assets/king/throw_commands.txt": "5c99b34febb005e087e0804604946d69",
"assets/assets/king/throw_damages.txt": "adc1d072b5861e5ccc23678d559905cf",
"assets/assets/king/throw_extras.txt": "45a2cbcbe5260cdbe9693e60741ebeb2",
"assets/assets/king/throw_names.txt": "16fa576b10b2f7e4742ec85da70cb60e",
"assets/assets/king/throw_names_en.txt": "1cb537118e3dea789cc36cc695ff64ea",
"assets/assets/king/throw_ranges.txt": "22f48e7a6a0b7972a480726ccecb8755",
"assets/assets/king/throw_start_frames.txt": "6c7a9cfeceb98fda9f8e6a9081613dd3",
"assets/assets/kuma/move_commands.txt": "c5e466a8ff21264a6b225c0ee7fed503",
"assets/assets/kuma/move_counter_frames.txt": "7df4c5236ae82988bd1f9acce4354a7d",
"assets/assets/kuma/move_damages.txt": "ace9869b830ab262fa68c6c39d0f311c",
"assets/assets/kuma/move_extras.txt": "176d37f14879b59aa3f5b41526a3c1dd",
"assets/assets/kuma/move_guard_frames.txt": "4b197c0af6535343d65db76f7de99d0d",
"assets/assets/kuma/move_hit_frames.txt": "f04ffae6fb3d368f14c1b0c4c4026741",
"assets/assets/kuma/move_names.txt": "6505ef9ccfa97d7310fd48c529db7ab8",
"assets/assets/kuma/move_names_en.txt": "5014eaa0c964022749d93543b410bbdb",
"assets/assets/kuma/move_ranges.txt": "14dadc0d3725b47c8b48f4d895981d66",
"assets/assets/kuma/move_start_frames.txt": "f25a9c0b908e1012ea82980f41c524eb",
"assets/assets/kuma/throw_after_break_frames.txt": "e9a637697d3c25a34b019fd72923b4e6",
"assets/assets/kuma/throw_break_commands.txt": "3de93156e54b70db94383253af424a89",
"assets/assets/kuma/throw_commands.txt": "198b86c52a823bd972ebc53cac45f691",
"assets/assets/kuma/throw_damages.txt": "8eec83e8f0eb58a49dc2a1cffaf7a528",
"assets/assets/kuma/throw_extras.txt": "f326a69ea24f9083c81eede232f3b868",
"assets/assets/kuma/throw_names.txt": "53694042ab6d700381dc206e06c0fb73",
"assets/assets/kuma/throw_ranges.txt": "ceef1226b9b43c221ee79f5f4ea13e09",
"assets/assets/kuma/throw_start_frames.txt": "31d1ff3be48f78a0e72f65800262936e",
"assets/assets/lars/move_commands.txt": "0606ef2cbca4090f6cbd25e133f824e6",
"assets/assets/lars/move_counter_frames.txt": "0aa80b96c5a8f7e76bd47fb6a021eed7",
"assets/assets/lars/move_damages.txt": "8d74fe7619d8d56ff6580e1c9b9a0dc5",
"assets/assets/lars/move_extras.txt": "ad10d2d00e6b088fa734e234f464a44e",
"assets/assets/lars/move_guard_frames.txt": "231f07c858eb5b09bf8401992c1821df",
"assets/assets/lars/move_hit_frames.txt": "ca1d986c0cd2f8dcd8848af6b7c509c2",
"assets/assets/lars/move_names.txt": "2c894b2f5dd375b4a5436c170d2612ee",
"assets/assets/lars/move_names_en.txt": "d2277699807a2043ff2144f4e016489d",
"assets/assets/lars/move_ranges.txt": "27181f7fe2058ba859b736e1a9064507",
"assets/assets/lars/move_start_frames.txt": "3791e92322d139c7639c8c3d6e673421",
"assets/assets/lars/throw_after_break_frames.txt": "d11b394f369a74140da28803f9d70649",
"assets/assets/lars/throw_break_commands.txt": "e744a84c3831e69e237f06a44d34eafc",
"assets/assets/lars/throw_commands.txt": "85f23b04ff801493fe348e59ea046e9e",
"assets/assets/lars/throw_damages.txt": "65d6860a406cb91c2f58abd58bb0f943",
"assets/assets/lars/throw_extras.txt": "cbb5230269746d8a578fb02940a04514",
"assets/assets/lars/throw_names.txt": "d19a64844485f40c6a9da76a7586e036",
"assets/assets/lars/throw_ranges.txt": "f45707faadbd12f9629fe9888a8d6de3",
"assets/assets/lars/throw_start_frames.txt": "a2643da761518c80f1ab687deec62b17",
"assets/assets/law/move_commands.txt": "a0d1e9159a74617632954879df038534",
"assets/assets/law/move_counter_frames.txt": "b5328f53dba3e0f9cc7b18c66cc1cc83",
"assets/assets/law/move_damages.txt": "0006218e88051d1d43aabbd2db331690",
"assets/assets/law/move_extras.txt": "f780f072f89297cff63fda7dfb44682d",
"assets/assets/law/move_guard_frames.txt": "0a3a2cc55b9102c2c188917a7640a487",
"assets/assets/law/move_hit_frames.txt": "6223df4d0a0a242f8fd0f842adf92d5f",
"assets/assets/law/move_names.txt": "1421b1939da4d7b9c4e16daf8e37d178",
"assets/assets/law/move_names_en.txt": "a786aef7302879b0443e7360846a057c",
"assets/assets/law/move_ranges.txt": "4452cbe4aa5ee2851b171b64369044e3",
"assets/assets/law/move_start_frames.txt": "caaff63bc1f2e10ceccfb83049f42806",
"assets/assets/law/throw_after_break_frames.txt": "ef6a3c3b7f76561d389598dac3676198",
"assets/assets/law/throw_break_commands.txt": "f0ef39302f2425356bf79bdf0d3db806",
"assets/assets/law/throw_commands.txt": "817bab106711a36a619558edab135071",
"assets/assets/law/throw_damages.txt": "ab56a1b19b7aea48977cde1b0a5436d5",
"assets/assets/law/throw_extras.txt": "89b425c98674b21082781eb619f14b0f",
"assets/assets/law/throw_names.txt": "91682d6b93039037d619668fd1597edc",
"assets/assets/law/throw_ranges.txt": "0fcb0aa52bab289d10dc43c21424c626",
"assets/assets/law/throw_start_frames.txt": "27344227e389307d1b3dc55afbe45878",
"assets/assets/lee/move_commands.txt": "45c81180ecbc24149e805f7422ae5eed",
"assets/assets/lee/move_counter_frames.txt": "7c3ce8986fe03c5f4875fd26fe2ee532",
"assets/assets/lee/move_damages.txt": "1000d190981a9e23587f7e211d5ca7da",
"assets/assets/lee/move_extras.txt": "4f1e006d7a7c8bb22f7ff7bde14a95a2",
"assets/assets/lee/move_guard_frames.txt": "04c3f46134b626ba16a1ff5c44fbbf84",
"assets/assets/lee/move_hit_frames.txt": "cd33b16d1af2131f5f1cffa97eaa94ce",
"assets/assets/lee/move_names.txt": "2d9ca3a8ba3cae407b55a0a94e278622",
"assets/assets/lee/move_names_en.txt": "3c97b69dd0a33a1de6b793ac957684da",
"assets/assets/lee/move_ranges.txt": "d2e38caa1a9186fd817a2901d676dded",
"assets/assets/lee/move_start_frames.txt": "af2535f654265f2e089900084b095bf6",
"assets/assets/lee/throw_after_break_frames.txt": "a32b3313c9c5422a68aad382df08c9c4",
"assets/assets/lee/throw_break_commands.txt": "ee7adb009cb64a0c65e8d1799d35540e",
"assets/assets/lee/throw_commands.txt": "7c65e9d627ca024d8ed3f8189b0fb4f3",
"assets/assets/lee/throw_damages.txt": "50bbb8ab6ad0d67b4292bfe2c7569228",
"assets/assets/lee/throw_extras.txt": "8358fddc80a9d484d47bf40571553241",
"assets/assets/lee/throw_names.txt": "0944c51c47b88d1113a297e81acfc703",
"assets/assets/lee/throw_ranges.txt": "6584d08359360cdc4e6f3124348f3b03",
"assets/assets/lee/throw_start_frames.txt": "ea5641dc32d5196d5e84c125eef44928",
"assets/assets/leo/move_commands.txt": "68c304884f0cbaea3de26c2264a38045",
"assets/assets/leo/move_counter_frames.txt": "6d3d0f5c91045b66d9cec9bb07d573bb",
"assets/assets/leo/move_damages.txt": "0800523c3dee91870e76b659e47f7bc8",
"assets/assets/leo/move_extras.txt": "ec3d481fe4b308705d06b95cd90a67c7",
"assets/assets/leo/move_guard_frames.txt": "3152327c3c6234d3cbb7e47c45346de9",
"assets/assets/leo/move_hit_frames.txt": "985b237517543d01d8632606232caa2c",
"assets/assets/leo/move_names.txt": "213b8ef4e92bc338342d4e50c3c29cf2",
"assets/assets/leo/move_names_en.txt": "62a2e57b596ac584e1d7d58dc918a953",
"assets/assets/leo/move_ranges.txt": "d2c89cac33176daea4f27f4759b4880e",
"assets/assets/leo/move_start_frames.txt": "a2d1c24197fcc05ad5d3d609fb218f4a",
"assets/assets/leo/throw_after_break_frames.txt": "9c7814b6c910f53efe3def6fab5da1fc",
"assets/assets/leo/throw_break_commands.txt": "d34418577253640410236df720c8aadf",
"assets/assets/leo/throw_commands.txt": "60592cd2eb4dceb5659251d072a0e145",
"assets/assets/leo/throw_damages.txt": "348a8a451ff5182ed77a83b30708d8cd",
"assets/assets/leo/throw_extras.txt": "65d6e62c1e18744c951127846dda2a14",
"assets/assets/leo/throw_names.txt": "719ab033296cb7a965fdb7ed2975472b",
"assets/assets/leo/throw_ranges.txt": "7205bf41d358273d800231694381f2e1",
"assets/assets/leo/throw_start_frames.txt": "57f7ebcaa2fbca04059f6617fc34ddab",
"assets/assets/leroy/move_commands.txt": "b914cd28d6d85a3055970d03f48dc38e",
"assets/assets/leroy/move_counter_frames.txt": "f325ab4e22ffe43c3f2c5e46fd93cd25",
"assets/assets/leroy/move_damages.txt": "10bc8f6ac514a2762339ee23f619c9fb",
"assets/assets/leroy/move_extras.txt": "db1aaf4ddf73405e2d40bb10cb4ed8e5",
"assets/assets/leroy/move_guard_frames.txt": "a805be7f0677d7c542b2c297e655dae5",
"assets/assets/leroy/move_hit_frames.txt": "b9626166d7362cf6bbaca4f8d813d3d7",
"assets/assets/leroy/move_names.txt": "301dca0f844536294f23c64b01294eb3",
"assets/assets/leroy/move_names_en.txt": "ddd2b93270db10b56e0a0c2152e53e83",
"assets/assets/leroy/move_ranges.txt": "ed17ccd1a5ed72f1b2380690ff85c8b7",
"assets/assets/leroy/move_start_frames.txt": "9f2254393f3ef2576cd9be126257d3c1",
"assets/assets/leroy/throw_after_break_frames.txt": "00d1de0e1b62d2b9efc8a282bb1e0fb5",
"assets/assets/leroy/throw_break_commands.txt": "3f76d1d2e0ac2a41b8cd8f115870716e",
"assets/assets/leroy/throw_commands.txt": "48ea95443a44a13503e48fc5b271a61e",
"assets/assets/leroy/throw_damages.txt": "c2b91cd2939dfac43e384aca46090e70",
"assets/assets/leroy/throw_extras.txt": "3bf1665074ee3ba96f2b7122ef75b0c5",
"assets/assets/leroy/throw_names.txt": "82b089d89cda0d39ae51c0d92a98cc59",
"assets/assets/leroy/throw_ranges.txt": "2107d34ec8af933ad1413339b37de2d4",
"assets/assets/leroy/throw_start_frames.txt": "0658ebbb0a3d01c78ac509ef30943700",
"assets/assets/lili/move_commands.txt": "7530bfa074e86949f8a6fbd9015090e2",
"assets/assets/lili/move_counter_frames.txt": "4a01c9f8f73ef182d005ec849df60497",
"assets/assets/lili/move_damages.txt": "921a1d1e40cad30152d8a7eed0e51f82",
"assets/assets/lili/move_extras.txt": "3402779d459729f6991d86509d084f68",
"assets/assets/lili/move_guard_frames.txt": "210aa1dafb2e590b5aa91d0550f10bb7",
"assets/assets/lili/move_hit_frames.txt": "8824a9a75dfb3afe2460af39e6de05f5",
"assets/assets/lili/move_names.txt": "d13905dd809ddf036d00af51db45773f",
"assets/assets/lili/move_names_en.txt": "890b47ba1ef3b1449ae7f04e086863e6",
"assets/assets/lili/move_ranges.txt": "1858fdbd996d87525a0718e5748f6afd",
"assets/assets/lili/move_start_frames.txt": "1e655c1927c139a85e5ec03754af3061",
"assets/assets/lili/throw_after_break_frames.txt": "e408a69c80b878df0e0e0e3758ead382",
"assets/assets/lili/throw_break_commands.txt": "ee7adb009cb64a0c65e8d1799d35540e",
"assets/assets/lili/throw_commands.txt": "f8823dc7488c113024e10d6191b79f1b",
"assets/assets/lili/throw_damages.txt": "8150a9dc8cb02da26e1fec53e3d9b2d0",
"assets/assets/lili/throw_extras.txt": "39da4f24ae20c576db74f2f3f74e9c67",
"assets/assets/lili/throw_names.txt": "037e01012d0cff88fd231de3da92c4a4",
"assets/assets/lili/throw_ranges.txt": "641c76f31f8cab9439b6112a94a84b6e",
"assets/assets/lili/throw_start_frames.txt": "83967942e456e7b79b8083594f563380",
"assets/assets/nina/move_commands.txt": "ac1014ec45e57e2120df9ded845c434e",
"assets/assets/nina/move_commands_en.txt": "5fe44bce36438b41460d75646e0eca4c",
"assets/assets/nina/move_counter_frames.txt": "65f977a0fbc1715b7bc676aa9860ae1d",
"assets/assets/nina/move_damages.txt": "3afc712172e6741646c68927760a0fdf",
"assets/assets/nina/move_extras.txt": "dd3bb9eb30bac9e2e1665807cd8a2348",
"assets/assets/nina/move_guard_frames.txt": "7912f7f79079a971b3d120e4ee000db5",
"assets/assets/nina/move_hit_frames.txt": "a2b0b3a46d69e4fadfee51541934d093",
"assets/assets/nina/move_names.txt": "8569c04f2f17b1157ea0e4d2f29ced47",
"assets/assets/nina/move_names_en.txt": "00a31093217297e08eb73440334243b3",
"assets/assets/nina/move_ranges.txt": "2293de40df0806d34357a820b8f8ad1f",
"assets/assets/nina/move_start_frames.txt": "e685bd3b3db658aebe6f83cff3df27b2",
"assets/assets/nina/throw_after_break_frames.txt": "21aa09e079e9579bb648da1bcf77a2d1",
"assets/assets/nina/throw_break_commands.txt": "ceed0fb2dbae33fbc3c6702ab67f0067",
"assets/assets/nina/throw_commands.txt": "eeb8d6bc9d30295d19320f3efc4965d8",
"assets/assets/nina/throw_damages.txt": "a1e687975347f1b0d69a0e0ce9ba98cf",
"assets/assets/nina/throw_extras.txt": "a781c5d798014a80476114b3f2d78668",
"assets/assets/nina/throw_names.txt": "6d462a0236323c75095e84748b409762",
"assets/assets/nina/throw_names_en.txt": "55b8970e6a4a927948bee63af15667a2",
"assets/assets/nina/throw_ranges.txt": "3903c40b6ca701289e624dd0a46f5425",
"assets/assets/nina/throw_start_frames.txt": "5470d94d83ca50d44cdf09c45d91a1f2",
"assets/assets/panda/move_commands.txt": "edec1d75ace17d4a100a7d521cb9c7f3",
"assets/assets/panda/move_counter_frames.txt": "c5071391414789d66b068deaaef796a6",
"assets/assets/panda/move_damages.txt": "c4b884b1d2cd550d06fad999c0364a4c",
"assets/assets/panda/move_extras.txt": "fcf5dd9bdca74947820ac11d333c7023",
"assets/assets/panda/move_guard_frames.txt": "d3de553d2d0b323dae7f5b7947ce0549",
"assets/assets/panda/move_hit_frames.txt": "cb1100d8cf7085f2a6ae4f36768622b7",
"assets/assets/panda/move_names.txt": "d90f402faaa16446d0fecca9e20ff186",
"assets/assets/panda/move_names_en.txt": "3d9581c4ab9ae60d28be9f99594c6572",
"assets/assets/panda/move_ranges.txt": "009c1c4469020871312d537a39f96269",
"assets/assets/panda/move_start_frames.txt": "238847221c41b11dd7e63614769f2436",
"assets/assets/panda/throw_after_break_frames.txt": "e9a637697d3c25a34b019fd72923b4e6",
"assets/assets/panda/throw_break_commands.txt": "3de93156e54b70db94383253af424a89",
"assets/assets/panda/throw_commands.txt": "198b86c52a823bd972ebc53cac45f691",
"assets/assets/panda/throw_damages.txt": "8eec83e8f0eb58a49dc2a1cffaf7a528",
"assets/assets/panda/throw_extras.txt": "f326a69ea24f9083c81eede232f3b868",
"assets/assets/panda/throw_names.txt": "53694042ab6d700381dc206e06c0fb73",
"assets/assets/panda/throw_ranges.txt": "ceef1226b9b43c221ee79f5f4ea13e09",
"assets/assets/panda/throw_start_frames.txt": "31d1ff3be48f78a0e72f65800262936e",
"assets/assets/paul/move_commands.txt": "88248c11e41c41caf386d24e92ff0bb9",
"assets/assets/paul/move_counter_frames.txt": "20009e6fe270cfcc8e8556cb7e8b6f29",
"assets/assets/paul/move_damages.txt": "e9244cbf67cc4e4cb9cc3c6ba157d5a5",
"assets/assets/paul/move_extras.txt": "69d1c91eb4c0f41cd6ec1ccaa14a1c47",
"assets/assets/paul/move_guard_frames.txt": "2c3768a39cd5069bf745ca21c5720e42",
"assets/assets/paul/move_hit_frames.txt": "e6e4e77b1c413e1f7715c7cdd57bfeaf",
"assets/assets/paul/move_names.txt": "08afef99cd4613be18f7a6bbbdf2c0ca",
"assets/assets/paul/move_names_en.txt": "f76f6653626d7517cd4ceddcef5799e7",
"assets/assets/paul/move_ranges.txt": "f0dc48db9b0336c1f7bf058da00e0701",
"assets/assets/paul/move_start_frames.txt": "748b9849461e58b45eb97bf31ce2ca97",
"assets/assets/paul/throw_after_break_frames.txt": "d4ee536446db910f24ca031cb0e661c5",
"assets/assets/paul/throw_break_commands.txt": "45524c921b63a399adb3bcdb578571ff",
"assets/assets/paul/throw_commands.txt": "4b65d6b0dc054b36cb6e5de1f27912b6",
"assets/assets/paul/throw_damages.txt": "c2c09994d3d359cc3f542d057a9c1bf3",
"assets/assets/paul/throw_extras.txt": "c54416e0f6a97d2a762dbaa113496018",
"assets/assets/paul/throw_names.txt": "ebc7e7816ba2b04177559dd9841c415e",
"assets/assets/paul/throw_ranges.txt": "52a211393897d5b97e9371b0c794677f",
"assets/assets/paul/throw_start_frames.txt": "4d7551aa2d26d4d1938566fe2c57b13e",
"assets/assets/raven/move_commands.txt": "ca6bcb59099618e2afaa9833ef08ba20",
"assets/assets/raven/move_counter_frames.txt": "741a5b4c453afa64eb11777ca6bf0407",
"assets/assets/raven/move_damages.txt": "68ae30909c1c53a87137a2066f5e7d19",
"assets/assets/raven/move_extras.txt": "a1e52b240924e7bd14bb0ad214d88f7a",
"assets/assets/raven/move_guard_frames.txt": "4a7ec482985befe7cfda87e77890fff3",
"assets/assets/raven/move_hit_frames.txt": "499180f131d89766f685f6ecc0ece946",
"assets/assets/raven/move_names.txt": "fe43aedf1848a4a100d3cf56b49264c1",
"assets/assets/raven/move_names_en.txt": "63af1cd0eccc279cfd51e88e65c785e2",
"assets/assets/raven/move_ranges.txt": "83c0c13fed39533dbbd467021e83ab15",
"assets/assets/raven/move_start_frames.txt": "f4ef704fd292fa1284f41b6380f86732",
"assets/assets/raven/throw_after_break_frames.txt": "202ceb1d983f20f0d990cafbc9a4bf0a",
"assets/assets/raven/throw_break_commands.txt": "8be009b49b2cc0ddaa1f8d375b159196",
"assets/assets/raven/throw_commands.txt": "cc5cb685e7751c04cb71da55d13618c0",
"assets/assets/raven/throw_damages.txt": "c738ea715af8b050e2cea57342ebd2c6",
"assets/assets/raven/throw_extras.txt": "721bfe9bc55054a50a9e5c30aff811d1",
"assets/assets/raven/throw_names.txt": "0b32b91e8409822585008aad7077047f",
"assets/assets/raven/throw_ranges.txt": "12960a5e530e1784172ece306590d08e",
"assets/assets/raven/throw_start_frames.txt": "f8fa0d17e8700203c6a6fb6684724ca0",
"assets/assets/reina/move_commands.txt": "18cf658ea1491ec853d6bb770c626bbd",
"assets/assets/reina/move_counter_frames.txt": "9bdd20e7950b1ea57802f7d92f7275bc",
"assets/assets/reina/move_damages.txt": "a7e90af0cd9ba64dd82ae8b6f0b67c15",
"assets/assets/reina/move_extras.txt": "73bdd2e0e6b4669f9f35fcdf9cad1f84",
"assets/assets/reina/move_guard_frames.txt": "06fd8b3f0bef853ea02711b041ac9c63",
"assets/assets/reina/move_hit_frames.txt": "400eb2b1712209487df9699b7f4e62c3",
"assets/assets/reina/move_names.txt": "c8ad8bdabd3df5d90c83de949ad15415",
"assets/assets/reina/move_names_en.txt": "7d8eb4b5c82546ddf75fb3ef9380456b",
"assets/assets/reina/move_ranges.txt": "aed664a33b92e32112e8c6736080efeb",
"assets/assets/reina/move_start_frames.txt": "ce674f6fa09419c499fcff371006b67a",
"assets/assets/reina/throw_after_break_frames.txt": "fe622aadf55456b2cdaa462252d82e09",
"assets/assets/reina/throw_break_commands.txt": "b8a1ab8a9a8406becea9af3f3ffddabe",
"assets/assets/reina/throw_commands.txt": "049d45c40f1906738a95e20489de6ddc",
"assets/assets/reina/throw_damages.txt": "ea4edb8c28cfe34ca3890fc399b0be1d",
"assets/assets/reina/throw_extras.txt": "1ce81f233e587b9a859a16f67a192b6d",
"assets/assets/reina/throw_names.txt": "e1dad00f8babc35e7b8d5691668e6830",
"assets/assets/reina/throw_ranges.txt": "07e645b5bc186711fce7175c2cf3583a",
"assets/assets/reina/throw_start_frames.txt": "0cfd9d26873700bee208fd19c48a1a06",
"assets/assets/shaheen/move_commands.txt": "6733c0c340834a8e11831157962a9967",
"assets/assets/shaheen/move_counter_frames.txt": "02c944adfe7d13981ff1396126d2e29b",
"assets/assets/shaheen/move_damages.txt": "b2686f9348bec4dd2dd71df9357bc333",
"assets/assets/shaheen/move_extras.txt": "67d0a9e25715989463e9c610a4d75495",
"assets/assets/shaheen/move_guard_frames.txt": "ffecac3abefb2763ac009f3195063bd0",
"assets/assets/shaheen/move_hit_frames.txt": "6d6e7c38a2006f8bbdc77a0eec964101",
"assets/assets/shaheen/move_names.txt": "b069b4dce433d2074ae3b185245bad0e",
"assets/assets/shaheen/move_names_en.txt": "6bab0d169b685cf742652440c4af2502",
"assets/assets/shaheen/move_ranges.txt": "132b5ab014b4448c320cbbcdd6e60356",
"assets/assets/shaheen/move_start_frames.txt": "af882e99a8ab017d36973555f67920ab",
"assets/assets/shaheen/throw_after_break_frames.txt": "8f8005984638881280417e0723008151",
"assets/assets/shaheen/throw_break_commands.txt": "24ebe47049c8117e97a34fdce065cd1e",
"assets/assets/shaheen/throw_commands.txt": "7a20bc66aa4f374940dc38c34f8688b9",
"assets/assets/shaheen/throw_damages.txt": "ae1c08b1e08e8015fc5eb7655d40c16d",
"assets/assets/shaheen/throw_extras.txt": "2708ceb5c48dbe9ab8fd87e7522ec010",
"assets/assets/shaheen/throw_names.txt": "8fac936f145782a44916cd2b80065d4f",
"assets/assets/shaheen/throw_ranges.txt": "4d398cf37e00f11261af5c5869b0c4d1",
"assets/assets/shaheen/throw_start_frames.txt": "087d1a6bbbac2a0a775faef63a366cac",
"assets/assets/steve/move_commands.txt": "354ce44ece6a8d2255d4477b8bd3709b",
"assets/assets/steve/move_counter_frames.txt": "6a6c2f9678156f0e07ac5c2bd1e7dd77",
"assets/assets/steve/move_damages.txt": "186fa50e7729670fe967cd6f0af254c3",
"assets/assets/steve/move_extras.txt": "7f2e4b69b472975376f4a82291e16482",
"assets/assets/steve/move_guard_frames.txt": "c60c6d7eb72876aad3f426380fd60bb7",
"assets/assets/steve/move_hit_frames.txt": "f1dca118520236aa036cbe819f575fc1",
"assets/assets/steve/move_names.txt": "9f51f5b29e72e32d9b2ac3299b42d356",
"assets/assets/steve/move_names_en.txt": "c979ca137bb2aa325df3cc68bfa60a57",
"assets/assets/steve/move_ranges.txt": "e99b09fe45455e8c97d2c36e839c01fc",
"assets/assets/steve/move_start_frames.txt": "924a3d74990808103d9433570ac4e59e",
"assets/assets/steve/throw_after_break_frames.txt": "256c5cc6621a715b1fa08f9be27181f4",
"assets/assets/steve/throw_break_commands.txt": "4a4b412ffc8b5e7a18ea667b4be4e3d2",
"assets/assets/steve/throw_commands.txt": "b0429d28d1dc7064459c1ff71c6a2965",
"assets/assets/steve/throw_damages.txt": "5eec35aaf4f30be969151bca379f1e0d",
"assets/assets/steve/throw_extras.txt": "d81e8d585ccd380bf27416d7efe890a5",
"assets/assets/steve/throw_names.txt": "be29a7a0423c143487e7f7a7a8385ff2",
"assets/assets/steve/throw_ranges.txt": "c82bf7a98a0c74e16d4cf76c3319f9b6",
"assets/assets/steve/throw_start_frames.txt": "731e037d999a5c231a55b06c6b92eee8",
"assets/assets/victor/move_commands.txt": "2bbd887e0460d54a169d91f0b94fe3cc",
"assets/assets/victor/move_counter_frames.txt": "a68cb4c8b5814b4061ed70b608699088",
"assets/assets/victor/move_damages.txt": "06316011710852cc23a6d948bce6a5da",
"assets/assets/victor/move_extras.txt": "f447ed791a5c937702eefd145e1a91ab",
"assets/assets/victor/move_guard_frames.txt": "8a60bab8be6a59972ff10b899ef113d9",
"assets/assets/victor/move_hit_frames.txt": "99e375a69c1143208d7b3b61c917751f",
"assets/assets/victor/move_names.txt": "36625a0c0d25e8b2e24cd815085ac3cc",
"assets/assets/victor/move_names_en.txt": "4bbeea720e64b6961da460f8a4c73644",
"assets/assets/victor/move_ranges.txt": "02f1524aa9e21909092d61206aa760b4",
"assets/assets/victor/move_start_frames.txt": "39395e43140c81499d93dac634a6375d",
"assets/assets/victor/throw_after_break_frames.txt": "9dd79b75a4d6cd887055fe46c28ae139",
"assets/assets/victor/throw_break_commands.txt": "24ebe47049c8117e97a34fdce065cd1e",
"assets/assets/victor/throw_commands.txt": "0651de977de5ea914686cf309bea8195",
"assets/assets/victor/throw_damages.txt": "ec555c60237d710856ff8f6133209a21",
"assets/assets/victor/throw_extras.txt": "8a4291c67705ac697b0bd0d46b0651d6",
"assets/assets/victor/throw_names.txt": "9e0b2b892ec4c8da66b670b84a48871b",
"assets/assets/victor/throw_ranges.txt": "4d398cf37e00f11261af5c5869b0c4d1",
"assets/assets/victor/throw_start_frames.txt": "03911f184cfe33cb6a2e7b79ce81a7cc",
"assets/assets/xiaoyu/move_commands.txt": "489ffd500698f4ce6059dfbb1801ad94",
"assets/assets/xiaoyu/move_counter_frames.txt": "e8d62443e07cd7cbe71c2c531dd6ad97",
"assets/assets/xiaoyu/move_damages.txt": "ef182cb95ede5a2d83e85704975db629",
"assets/assets/xiaoyu/move_extras.txt": "fc2419161d67c5e4f1f0575f3a3dfcb3",
"assets/assets/xiaoyu/move_guard_frames.txt": "20e2c18612bb94974bc67d3c0f49b590",
"assets/assets/xiaoyu/move_hit_frames.txt": "1d30c39bd0ebd53fc7ded174a37c5fa6",
"assets/assets/xiaoyu/move_names.txt": "cbb78fd1b6ac6aa9e328d3a20e9f6f6f",
"assets/assets/xiaoyu/move_names_en.txt": "2579b05fed3af6798852b15a225cd255",
"assets/assets/xiaoyu/move_ranges.txt": "7b5fc3eb4071c573eb684bf58ce0b98d",
"assets/assets/xiaoyu/move_start_frames.txt": "17a1f122c0817ffea55b241071694cd9",
"assets/assets/xiaoyu/throw_after_break_frames.txt": "e973cbe1d74ebce7420ac84e818b2644",
"assets/assets/xiaoyu/throw_break_commands.txt": "ad8d0896bbaf84169ef394e8ca6deb4a",
"assets/assets/xiaoyu/throw_commands.txt": "bef9def242012363ee5eac9afa87b0ef",
"assets/assets/xiaoyu/throw_damages.txt": "5c0fce1de87ef6cd6d36fa638be71c3a",
"assets/assets/xiaoyu/throw_extras.txt": "90bfdca6d16a15ab9835afab82f0eb15",
"assets/assets/xiaoyu/throw_names.txt": "cdaf30bf0101d91d8be794762ba8fb7b",
"assets/assets/xiaoyu/throw_ranges.txt": "24bfbb85e4fad1173c8d9f2b25cc2462",
"assets/assets/xiaoyu/throw_start_frames.txt": "a3595f3d88d44ca570c0f817cbeae4d9",
"assets/assets/yoshimitsu/move_commands.txt": "092f1cffdcbb3a370c8bcb3f0c19b882",
"assets/assets/yoshimitsu/move_counter_frames.txt": "5def023883673a02cdf5c5e829de9579",
"assets/assets/yoshimitsu/move_damages.txt": "a0cc2dddf17d753dcd9a64e6c7a4b8ec",
"assets/assets/yoshimitsu/move_extras.txt": "d7b088e6da6411d6fc039db170b552ed",
"assets/assets/yoshimitsu/move_guard_frames.txt": "3755829badd48faf03a08e854cc2f993",
"assets/assets/yoshimitsu/move_hit_frames.txt": "39e5bb584d1aa16479f2f32fc54d606e",
"assets/assets/yoshimitsu/move_names.txt": "fa91612d7f85c94451edfbdd7c67a945",
"assets/assets/yoshimitsu/move_names_en.txt": "c38d72851594f6e6776b1be51594bc9a",
"assets/assets/yoshimitsu/move_ranges.txt": "fe4a3b17993962913843e30d183b7d3b",
"assets/assets/yoshimitsu/move_start_frames.txt": "5e11976b38119b370b1b7eef8b009882",
"assets/assets/yoshimitsu/throw_after_break_frames.txt": "698c944e8b7d63569c2daa09fadab83d",
"assets/assets/yoshimitsu/throw_break_commands.txt": "3de93156e54b70db94383253af424a89",
"assets/assets/yoshimitsu/throw_commands.txt": "d7f3238d0f8e5aa9fb908e852b4016ad",
"assets/assets/yoshimitsu/throw_damages.txt": "b280134c367bd9ab99a4ffd4b4ec9d78",
"assets/assets/yoshimitsu/throw_extras.txt": "071d4ad260e7f9fe8cabeb64c82e12e8",
"assets/assets/yoshimitsu/throw_names.txt": "50e1bbf46e7b7ca918f51f4e787faaf0",
"assets/assets/yoshimitsu/throw_ranges.txt": "ceef1226b9b43c221ee79f5f4ea13e09",
"assets/assets/yoshimitsu/throw_start_frames.txt": "a7b6a14fca82afedc829bfeb91dafea6",
"assets/assets/zafina/move_commands.txt": "0211108a4e22d152930c85083b6d6896",
"assets/assets/zafina/move_counter_frames.txt": "42acd2c5b6b9518dc881293f2cde6896",
"assets/assets/zafina/move_damages.txt": "0875d0c2bdcd619a0301573f85092db7",
"assets/assets/zafina/move_extras.txt": "9367de86cbdf6fc7bf6bc4c5ec3faa8e",
"assets/assets/zafina/move_guard_frames.txt": "eeffc3605cd42c517b5f275adcdd11bf",
"assets/assets/zafina/move_hit_frames.txt": "3d850e111706c800c7c0b161fe867625",
"assets/assets/zafina/move_names.txt": "45170581517e9d53d6316050e3044f40",
"assets/assets/zafina/move_names_en.txt": "f896d06c55603e3a1d889ee7d9882351",
"assets/assets/zafina/move_ranges.txt": "f8f36875a1142d78c883be3a0a0e498d",
"assets/assets/zafina/move_start_frames.txt": "1ae4b9ca2117a59db19c5d8af7d70ca8",
"assets/assets/zafina/throw_after_break_frames.txt": "d20bb46b942b12b8b08ffeb09eb4da95",
"assets/assets/zafina/throw_break_commands.txt": "24ebe47049c8117e97a34fdce065cd1e",
"assets/assets/zafina/throw_commands.txt": "05a1375c2aca8b10abd74f1537ef10c3",
"assets/assets/zafina/throw_damages.txt": "7705fa919f8cc28c96376d7e50d2ebb8",
"assets/assets/zafina/throw_extras.txt": "795fffaf8f2e3b9a92323e12fac8a61d",
"assets/assets/zafina/throw_names.txt": "87ba0473880e864967c274d40a15e9bd",
"assets/assets/zafina/throw_ranges.txt": "4d398cf37e00f11261af5c5869b0c4d1",
"assets/assets/zafina/throw_start_frames.txt": "4674033b884a92bd3cad1f13db530d04",
"assets/FontManifest.json": "1f515b8460fc0c33254529b1b27f54ae",
"assets/fonts/MaterialIcons-Regular.otf": "0680fd15867123434944153ffedce909",
"assets/NOTICES": "9eb690f6dc007dcefac94aa4c967108b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "131daacd79f28a2a8f34c7f0be975090",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c2916fd3d1d007da20559d33dbb8c946",
"/": "c2916fd3d1d007da20559d33dbb8c946",
"main.dart.js": "bff0ead2b0d196d8b2a5c81882cc2464",
"manifest.json": "42f6fe540936c3a2553c386687aaf37f",
"version.json": "7f1fee15ab772dbc4b3cf4e3ebb847b5"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
