import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:tekken8_framedata/main.dart';
import 'package:tekken8_framedata/playerDetailsScreen.dart';
import 'modules.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<PlayerInfo> resultList = [];
  bool isSearching = false;

  Future<List<PlayerInfo>> search() async{
    List<PlayerInfo> playerInfoList = [];

    if(searchController.text != ""){
      final uri = Uri.https("tekkenstats.gg", "/search/", {'q': searchController.text});
      setState(() {
        searchController.text = "";
        isSearching = true;
      });
      final response = await http.get(uri);
      final dom.Document document = parser.parse(response.body);
      final playerList = document.querySelectorAll('main > div > table > tbody > tr');

      for (var player in playerList) {
        final playerInfo = player.querySelectorAll('td');
        final number = playerInfo[0].querySelector('a')?.attributes['href']!.replaceAll('https://tekkenstats.gg/player/', '');
        playerInfoList.add(
          PlayerInfo(polarisId: playerInfo[0].text, name: playerInfo[1].text, onlineId: playerInfo[2].text, platform: playerInfo[3].text.replaceAll("\n", "").replaceAll(" ", ""), number : number!)
        );
      }

      setState(() {
        isSearching = false;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("검색어를 입력해 주세요."),
        )
      );
    }

    return playerInfoList;
  }

  final TextStyle headingStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "플레이어 검색"
                            ),
                            maxLines: null,
                            controller: searchController,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value)async{
                              resultList = await search();
                            },
                          ),
                        ),
                        IconButton(onPressed: ()async{
                          resultList = await search();
                          inspect(resultList);
                        }, icon: Icon(Icons.search)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 100, child: Text("폴라리스 ID", textAlign: TextAlign.center, style: headingStyle,)),
              SizedBox(width: 80, child: Text("이름", textAlign: TextAlign.center, style: headingStyle)),
              SizedBox(width: 100, child: Text("온라인 ID", textAlign: TextAlign.center, style: headingStyle)),
              SizedBox(width: 70, child: Text("플랫폼", textAlign: TextAlign.center, style: headingStyle))
            ],
          ),
          SizedBox(height: 5,),
          Container(height: 1, color: Colors.grey,),
          SizedBox(height: 4,),
          Expanded(
            child: isSearching ? Center(child: Text("검색중...")) : ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 100,
                        child: GestureDetector(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerDetailsPage(playerInfo: resultList[index])));
                          },
                          child: Text(resultList[index].polarisId, textAlign: TextAlign.center, style: TextStyle(color: CustomThemeMode.currentThemeData.value.primaryColor),),
                        ),
                      ),
                      SizedBox(width: 80, child: Text(resultList[index].name, textAlign: TextAlign.center,)),
                      SizedBox(width: 100, child: Text(resultList[index].onlineId, textAlign: TextAlign.center,)),
                      SizedBox(width: 70, child: Text(resultList[index].platform, textAlign: TextAlign.center,)),
                    ]
                  ),
                );
              },
              itemCount: resultList.length
            ),
          )
        ],
      ),
    );
  }
}
