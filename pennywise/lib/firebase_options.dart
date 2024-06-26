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
    apiKey: 'AIzaSyBiMY_sdcfXQkTKzf61e0zIS3N1earT8l8',
    appId: '1:1080302292858:web:4397c12b105dc1cfc1d0c3',
    messagingSenderId: '1080302292858',
    projectId: 'pennywise-95fbd',
    authDomain: 'pennywise-95fbd.firebaseapp.com',
    storageBucket: 'pennywise-95fbd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjTDGfjgax3rNfh-JPmydC1tLMwMsnypM',
    appId: '1:1080302292858:android:b056a0378785194fc1d0c3',
    messagingSenderId: '1080302292858',
    projectId: 'pennywise-95fbd',
    storageBucket: 'pennywise-95fbd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjkCiBsV4jV0cNmyHKfcoafcPWGxCVsE0',
    appId: '1:1080302292858:ios:87b4acb79951e117c1d0c3',
    messagingSenderId: '1080302292858',
    projectId: 'pennywise-95fbd',
    storageBucket: 'pennywise-95fbd.appspot.com',
    iosBundleId: 'com.example.pennywise',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjkCiBsV4jV0cNmyHKfcoafcPWGxCVsE0',
    appId: '1:1080302292858:ios:87b4acb79951e117c1d0c3',
    messagingSenderId: '1080302292858',
    projectId: 'pennywise-95fbd',
    storageBucket: 'pennywise-95fbd.appspot.com',
    iosBundleId: 'com.example.pennywise',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBiMY_sdcfXQkTKzf61e0zIS3N1earT8l8',
    appId: '1:1080302292858:web:0170904262409381c1d0c3',
    messagingSenderId: '1080302292858',
    projectId: 'pennywise-95fbd',
    authDomain: 'pennywise-95fbd.firebaseapp.com',
    storageBucket: 'pennywise-95fbd.appspot.com',
  );
}
