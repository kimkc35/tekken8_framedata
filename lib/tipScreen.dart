import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekken8_framedata/character_variables.dart';
import 'package:tekken8_framedata/main.dart';

import 'drawer.dart';

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => TipPageState();
}

class TipPageState extends State<TipPage> with TickerProviderStateMixin{
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController(text: "ALISA");
  final ScrollController scrollController = ScrollController();
  var filter = "likeCount";
  var tipLimit = 20;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    var storage;
    FirebaseFirestore.instance.collection(dropdownController.text).get().then((value) => storage = value);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && storage.docs.length > tipLimit){
        setState(() {
          tipLimit += 20;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final storage = FirebaseFirestore.instance.collection(dropdownController.text);
    final limitedStorage = storage.orderBy(filter, descending: true).limit(tipLimit).get();

    if(currentUser != null){
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: DropdownMenu(
                onSelected: (character){
                  setState(() {
                  });
                },
                controller: dropdownController,
                dropdownMenuEntries: [
                  for(var character in characterList.where((element) => element.name != "")) DropdownMenuEntry(value: character, label: character.name.toUpperCase())
                ]
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Text(currentUser!.displayName.toString(), style: TextStyle(fontSize: 20),)),
                          TextButton(onPressed: (){
                            if(filter != "likeCount"){
                              setState(() {
                                filter = "likeCount";
                              });
                            }
                          }, child: Text("tip.mostPopular".tr(), style: TextStyle(color: filter == "likeCount" ? CustomThemeMode.currentThemeData.value.primaryColor : CustomThemeMode.currentThemeData.value.secondaryHeaderColor),)),
                          TextButton(onPressed: (){
                            if(filter != "date"){
                              setState(() {
                                filter = "date";
                              });
                            }
                          }, child: Text("tip.latest".tr(), style: TextStyle(color: filter == "date" ? CustomThemeMode.currentThemeData.value.primaryColor : CustomThemeMode.currentThemeData.value.secondaryHeaderColor)))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "tip.hintText".tr()
                              ),
                              maxLines: null,
                              controller: textEditingController,
                            ),
                          ),
                          IconButton(onPressed: (){
                            textEditingController.text != ""?
                            setState(() {
                              storage.doc().set({
                                "author" : currentUser!.displayName,
                                "uid" : currentUser!.uid,
                                "version" : patchNotes["version"],
                                "context" : textEditingController.text,
                                "like" : [],
                                "likeCount" : 0,
                                "date" : DateTime.now()
                              });
                              textEditingController.text = "";
                            }) :
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("tip.emptyTextError").tr(),
                                )
                            );
                          }, icon: Icon(Icons.add)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(future: limitedStorage, builder: (BuildContext context, snapshot){
                if (snapshot.hasError) {
                  if (currentUser == null){
                    setState(() {
                    });
                  }
                  return const Text('tip.error').tr();
                }

                if(snapshot.hasData){
                  return ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, int index){
                      var currentDoc = snapshot.data!.docs[index];
                      return SizedBox(
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("${currentDoc["author"]}  "),
                                Text("${currentDoc["version"]}", style: TextStyle(color: CustomThemeMode.currentThemeData.value.primaryColor, fontSize: 15),)
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(height: 60, child: SingleChildScrollView(child: Text(currentDoc["context"]))),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(currentUser!.uid == currentDoc["uid"] || currentUser!.uid == "YFHOTFRFlfMlZip8jCysyz44XoK2")
                                  IconButton(onPressed: (){
                                    setState(() {
                                    });
                                    storage.doc(currentDoc.id).delete();
                                  }, icon: Icon(Icons.delete)),
                                if(currentDoc["like"].toString().contains(currentUser!.uid) || currentUser!.uid == currentDoc["uid"])...[
                                  IconButton(onPressed: (){
                                    if(currentUser!.uid != currentDoc["uid"]){
                                      setState(() {
                                      });
                                      storage.doc(currentDoc.id).update({
                                        "like": FieldValue.arrayRemove([currentUser!.uid]),
                                        "likeCount": FieldValue.increment(-1)
                                      });
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("tip.selfLikeError").tr(),
                                          )
                                      );
                                    }
                                  }, icon: Icon(Icons.thumb_up)),
                                ]else...[
                                  IconButton(onPressed: (){
                                    setState(() {
                                    });
                                    storage.doc(currentDoc.id).update({
                                      "like": FieldValue.arrayUnion([currentUser!.uid]),
                                      "likeCount": FieldValue.increment(1)
                                    });
                                  }, icon: Icon(Icons.thumb_up_outlined)),
                                ],
                                Text(currentDoc['like'].length.toString()),
                                SizedBox(width: 20,)
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, int index) => Container(height: 1, color: Colors.grey),
                    itemCount: snapshot.data!.docs.length,
                  );
                }

                return Center(child: Text("tip.loading").tr());


              }),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("tip.loginError").tr(),
          TextButton(
            onPressed: ()async{
              if(currentUser == null) kIsWeb ? await signInWithGoogleWeb() : await signInWithGoogle();
              setState(() {
              });
            },
            style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(CustomThemeMode.currentThemeData.value.primaryColor)
            ),
            child: Text("main.drawer.login").tr(),
          )
        ],
      ),
    );
  }
}
