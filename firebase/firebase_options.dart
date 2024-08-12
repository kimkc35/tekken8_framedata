// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAVsNmNWOf92n3fORCJMsVx7NF_MZ-Z6Dg',
    appId: '1:648481478664:web:d51debef5b9b43a26919bd',
    messagingSenderId: '648481478664',
    projectId: 'tk8-framedata-pro',
    authDomain: 'tk8-framedata-pro.firebaseapp.com',
    databaseURL: 'https://tk8-framedata-pro-default-rtdb.firebaseio.com',
    storageBucket: 'tk8-framedata-pro.appspot.com',
    measurementId: 'G-SJ6Y10EPFS',
  );

  static const FirebaseOptions androidVpro = FirebaseOptions(
    apiKey: 'AIzaSyBwdg9HPq1EML2VPQT9eE2sI-8SNfkjBgo',
    appId: '1:648481478664:android:734e178062681bfb6919bd',
    messagingSenderId: '648481478664',
    projectId: 'tk8-framedata-pro',
    databaseURL: 'https://tk8-framedata-pro-default-rtdb.firebaseio.com',
    storageBucket: 'tk8-framedata-pro.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwdg9HPq1EML2VPQT9eE2sI-8SNfkjBgo',
    appId: '1:648481478664:android:624b10e0ed4b2ace6919bd',
    messagingSenderId: '648481478664',
    projectId: 'tk8-framedata-pro',
    databaseURL: 'https://tk8-framedata-pro-default-rtdb.firebaseio.com',
    storageBucket: 'tk8-framedata-pro.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqlmos6OPqDHAFwWrxOEzxCjCi_1kBhIg',
    appId: '1:648481478664:ios:168ea2cb8842085c6919bd',
    messagingSenderId: '648481478664',
    projectId: 'tk8-framedata-pro',
    databaseURL: 'https://tk8-framedata-pro-default-rtdb.firebaseio.com',
    storageBucket: 'tk8-framedata-pro.appspot.com',
    androidClientId: '648481478664-7rrvkmvusun8ss8c1v3icc94bmrbsv90.apps.googleusercontent.com',
    iosClientId: '648481478664-f4pu4bu998sra1o3rfk76iu632669dk1.apps.googleusercontent.com',
    iosBundleId: 'com.example.tekken8Framedata',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqlmos6OPqDHAFwWrxOEzxCjCi_1kBhIg',
    appId: '1:648481478664:ios:168ea2cb8842085c6919bd',
    messagingSenderId: '648481478664',
    projectId: 'tk8-framedata-pro',
    databaseURL: 'https://tk8-framedata-pro-default-rtdb.firebaseio.com',
    storageBucket: 'tk8-framedata-pro.appspot.com',
    androidClientId: '648481478664-7rrvkmvusun8ss8c1v3icc94bmrbsv90.apps.googleusercontent.com',
    iosClientId: '648481478664-f4pu4bu998sra1o3rfk76iu632669dk1.apps.googleusercontent.com',
    iosBundleId: 'com.example.tekken8Framedata',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAVsNmNWOf92n3fORCJMsVx7NF_MZ-Z6Dg',
    appId: '1:648481478664:web:5bbd459cf3499cdb6919bd',
    messagingSenderId: '648481478664',
    projectId: 'tk8-framedata-pro',
    authDomain: 'tk8-framedata-pro.firebaseapp.com',
    databaseURL: 'https://tk8-framedata-pro-default-rtdb.firebaseio.com',
    storageBucket: 'tk8-framedata-pro.appspot.com',
    measurementId: 'G-5XLFKGMZCQ',
  );

}