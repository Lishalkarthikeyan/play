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
    apiKey: 'AIzaSyCKj6OOa4t3PF0epVW1MCzWaEtjNu0_kaw',
    appId: '1:314067456150:web:1f8d40ca1241d05899f2b7',
    messagingSenderId: '314067456150',
    projectId: 'playmusic143-d2263',
    authDomain: 'playmusic143-d2263.firebaseapp.com',
    storageBucket: 'playmusic143-d2263.appspot.com',
    measurementId: 'G-14E5059GYT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhlTIp41yyJJmIVXrpsPdt3_3ukn08wvg',
    appId: '1:314067456150:android:33abe66a917a6ce099f2b7',
    messagingSenderId: '314067456150',
    projectId: 'playmusic143-d2263',
    storageBucket: 'playmusic143-d2263.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDewBBcxDk71dMGjyG_jH2p_svx0GQj5Ow',
    appId: '1:314067456150:ios:cec9ec657481650a99f2b7',
    messagingSenderId: '314067456150',
    projectId: 'playmusic143-d2263',
    storageBucket: 'playmusic143-d2263.appspot.com',
    iosBundleId: 'com.example.musicplay',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDewBBcxDk71dMGjyG_jH2p_svx0GQj5Ow',
    appId: '1:314067456150:ios:cec9ec657481650a99f2b7',
    messagingSenderId: '314067456150',
    projectId: 'playmusic143-d2263',
    storageBucket: 'playmusic143-d2263.appspot.com',
    iosBundleId: 'com.example.musicplay',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKj6OOa4t3PF0epVW1MCzWaEtjNu0_kaw',
    appId: '1:314067456150:web:a7a0f2dff3f9e7e599f2b7',
    messagingSenderId: '314067456150',
    projectId: 'playmusic143-d2263',
    authDomain: 'playmusic143-d2263.firebaseapp.com',
    storageBucket: 'playmusic143-d2263.appspot.com',
    measurementId: 'G-66DTNDF4YH',
  );

}