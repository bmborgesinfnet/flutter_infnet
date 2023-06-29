// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDRfxrArZAwcKb7r9t6FX-yzmVWFj2uOGw',
    appId: '1:634960354592:web:e24b0c1edfd289ef784b45',
    messagingSenderId: '634960354592',
    projectId: 'projectflutter-6fa48',
    authDomain: 'projectflutter-6fa48.firebaseapp.com',
    databaseURL: 'https://projectflutter-6fa48-default-rtdb.firebaseio.com',
    storageBucket: 'projectflutter-6fa48.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoNrEuJlDmSca430RWdD-QyITCGylFXgo',
    appId: '1:634960354592:android:ae14eb5f115f4a49784b45',
    messagingSenderId: '634960354592',
    projectId: 'projectflutter-6fa48',
    databaseURL: 'https://projectflutter-6fa48-default-rtdb.firebaseio.com',
    storageBucket: 'projectflutter-6fa48.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuL1T_x68LCZDax29ma6EGxhUJyuvUeWU',
    appId: '1:634960354592:ios:3eb287005dd86167784b45',
    messagingSenderId: '634960354592',
    projectId: 'projectflutter-6fa48',
    databaseURL: 'https://projectflutter-6fa48-default-rtdb.firebaseio.com',
    storageBucket: 'projectflutter-6fa48.appspot.com',
    iosClientId: '634960354592-uvmobtq5uqlsac61vr2q98uv547km3h2.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuL1T_x68LCZDax29ma6EGxhUJyuvUeWU',
    appId: '1:634960354592:ios:b66b54b8134cca62784b45',
    messagingSenderId: '634960354592',
    projectId: 'projectflutter-6fa48',
    databaseURL: 'https://projectflutter-6fa48-default-rtdb.firebaseio.com',
    storageBucket: 'projectflutter-6fa48.appspot.com',
    iosClientId: '634960354592-lmp799m02h73k3n1o97rj1ug4vplcste.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
