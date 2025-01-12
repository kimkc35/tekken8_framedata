import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:tekken8_framedata/main.dart';
import 'package:tekken8_framedata/profileScreen.dart';
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

    String formatString(String input) {
      return '${input.substring(0, 4)}-${input.substring(4, 8)}-${input.substring(8, 12)}';
    }

    if(searchController.text != ""){
      try {
        final uri = Uri.https(
            "kekken.com", "/search", {'q': searchController.text});
        setState(() {
          searchController.text = "";
          isSearching = true;
        });
        final response = await http.get(uri, headers: {"Accept": "text/vnd.turbo-stream.html"});
        final dom.Document document = parser.parse(response.body);
        final playerList = document.querySelectorAll('turbo-stream > template > div > div').last.querySelectorAll("a");


        for (var player in playerList) {
          final playerPolarisId = player.querySelector("svg") != null ? player.attributes['href'].toString().replaceAll("/@", "") : formatString(player.attributes['href'].toString().replaceAll("/@", ""));
          final playerName = player.text.replaceAll("\n", "").trim();
          final isVerified = player.querySelector("svg") != null ? true : false;

          playerInfoList.add(PlayerInfo(name: playerName, isVerified: isVerified, polarisId: playerPolarisId));
        }
      }catch(e){
        throw ErrorDescription(e.toString());
      }

      setState(() {
        isSearching = false;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("searchProfile.noTextError").tr(),
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
                                hintText: "searchProfile.hintText".tr()
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
              Expanded(flex: 2, child: Text("searchProfile.name".tr(), textAlign: TextAlign.center, style: headingStyle)),
              Expanded(flex: 2, child: Text("searchProfile.polarisId".tr(), textAlign: TextAlign.center, style: headingStyle,)),
              Expanded(flex: 1, child: Text("searchProfile.verified".tr(), textAlign: TextAlign.center, style: headingStyle)),
            ],
          ),
          SizedBox(height: 5,),
          Container(height: 1, color: Colors.grey,),
          SizedBox(height: 4,),
          Expanded(
            child: isSearching ? Center(child: Text("searchProfile.loading".tr())) : ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(flex: 2, child: Text(resultList[index].name, textAlign: TextAlign.center,)),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(playerInfo: resultList[index])));
                          },
                          child: Text(resultList[index].polarisId, textAlign: TextAlign.center, style: TextStyle(color: CustomThemeMode.currentThemeData.value.primaryColor),),
                        ),
                      ),
                      Expanded(flex: 1, child: resultList[index].isVerified ? Icon(Icons.check_circle, color: Colors.blue,) : SizedBox()),
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
