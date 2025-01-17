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
    apiKey: 'AIzaSyCT7AoSj2w4RnPl-G4z35iXGNpQsELwrmg',
    appId: '1:117528305984:web:691a4eb3134904b11e1aa5',
    messagingSenderId: '117528305984',
    projectId: 'fininfotech-66a30',
    authDomain: 'fininfotech-66a30.firebaseapp.com',
    storageBucket: 'fininfotech-66a30.appspot.com',
    measurementId: 'G-982WBFWEYZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6nZ9alq6-cJ97Eocp_JkyDIKIkAiHcL4',
    appId: '1:117528305984:android:6e24414194c300651e1aa5',
    messagingSenderId: '117528305984',
    projectId: 'fininfotech-66a30',
    storageBucket: 'fininfotech-66a30.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2qYkvepDhluhU62pJu-XM-yeXAvyCKsU',
    appId: '1:117528305984:ios:d6c96a855030d3d01e1aa5',
    messagingSenderId: '117528305984',
    projectId: 'fininfotech-66a30',
    storageBucket: 'fininfotech-66a30.appspot.com',
    iosBundleId: 'com.example.flutterFirestoreApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2qYkvepDhluhU62pJu-XM-yeXAvyCKsU',
    appId: '1:117528305984:ios:d6c96a855030d3d01e1aa5',
    messagingSenderId: '117528305984',
    projectId: 'fininfotech-66a30',
    storageBucket: 'fininfotech-66a30.appspot.com',
    iosBundleId: 'com.example.flutterFirestoreApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCT7AoSj2w4RnPl-G4z35iXGNpQsELwrmg',
    appId: '1:117528305984:web:ecdf9bef3f414a821e1aa5',
    messagingSenderId: '117528305984',
    projectId: 'fininfotech-66a30',
    authDomain: 'fininfotech-66a30.firebaseapp.com',
    storageBucket: 'fininfotech-66a30.appspot.com',
    measurementId: 'G-0Z71TXVESF',
  );
}
