import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  final signIn = await FirebaseAuth.instance.signInWithCredential(credential);

  currentUser = FirebaseAuth.instance.currentUser;
  // Once signed in, return the UserCredential
  return signIn;
}

Future<UserCredential> signInWithGoogleWeb() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({
    'login_hint': 'user@example.com'
  });
  final signIn = await FirebaseAuth.instance.signInWithPopup(googleProvider);

  currentUser = FirebaseAuth.instance.currentUser;
  // Once signed in, return the UserCredential
  return signIn;

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}

User? currentUser;

class DrawerWidget extends StatefulWidget {
  final TabController tabController;
  DrawerWidget({super.key, required this.tabController});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {

    InkWell signInButton(){

      Widget profileContainer(Image profileImage){
        return Container(
          padding: EdgeInsets.all(10),
          height: 72,
          child: ClipOval(
            child: profileImage,
          ),
        );
      }

      if(currentUser != null){
        return InkWell(
          onTap: ()async{
            await FirebaseAuth.instance.signOut();
            setState(() {
              currentUser = FirebaseAuth.instance.currentUser;
            });
          },
          child: Row(
            children: [
              profileContainer(Image.network(currentUser!.providerData[0].photoURL.toString())),
              Text(currentUser!.providerData[0].displayName.toString())
            ],
          ),
        );
      }

      return InkWell(
        onTap: ()async{
          kIsWeb ? await signInWithGoogleWeb() : await signInWithGoogle();
          setState(() {
          });
        },
        child: Row(
          children: [
            profileContainer(Image.asset("assets/icons/${isPro? "pro" : "free"}.png")),
            Text("main.drawer.login").tr()
          ],
        ),
      );
    }

    final tabNameList = [
      "main.drawer.moveList".tr(),
      "main.drawer.tips".tr(),
      "main.drawer.searchProfile".tr()
    ];

    drawerTabButton(String name, int index){
      return SizedBox(
        height: 40,
        child: TextButton(child: Text(name),onPressed: () {
          widget.tabController.animateTo(index);
          FirebaseAnalytics.instance.logScreenView(screenName: firebaseScreenName[index]);
          Navigator.pop(context);
        }),
      );
    }

    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            signInButton(),
            for(int i = 0; i < tabNameList.length; i++)...[
              drawerTabButton(tabNameList[i], i)
            ]
          ],
        )
      ),
    );
  }
}
