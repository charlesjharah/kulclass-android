// File generated manually for all platforms.
// ignore_for_file: type=lint

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for your Firebase apps.
///
/// Usage:
/// ```dart
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
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOko7VtNp2XBiNJ6GhaKrHIV8t_hU7SmY',
    appId: '1:1016864985057:android:6e85fa6d97b00225c38ca0',
    messagingSenderId: '1016864985057',
    projectId: 'aura-live-15d96',
    storageBucket: 'aura-live-15d96.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCi8o5nBIRvmHHw7ieSNxGPfH9aDy10Dfo',
    appId: '1:1016864985057:ios:591268d39ffb4996c38ca0',
    messagingSenderId: '1016864985057',
    projectId: 'aura-live-15d96',
    storageBucket: 'aura-live-15d96.firebasestorage.app',
    androidClientId: '1016864985057-cio9kdp6r06ps6ehg2oa17sc0nk4i24n.apps.googleusercontent.com',
    iosClientId: '1016864985057-areivp9fclavqubbchm37j6vavq8aask.apps.googleusercontent.com',
    iosBundleId: 'com.auraapp.shortieCode',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB-GdGe98yZIGvG7y9APj6IC4u8ir1esM0',
    appId: '1:1016864985057:web:44c3b63feef48b36c38ca0',
    messagingSenderId: '1016864985057',
    projectId: 'aura-live-15d96',
    authDomain: 'aura-live-15d96.firebaseapp.com',
    storageBucket: 'aura-live-15d96.firebasestorage.app',
    measurementId: 'G-45BT327X5T',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCi8o5nBIRvmHHw7ieSNxGPfH9aDy10Dfo',
    appId: '1:1016864985057:ios:5202335dfb941abac38ca0',
    messagingSenderId: '1016864985057',
    projectId: 'aura-live-15d96',
    storageBucket: 'aura-live-15d96.firebasestorage.app',
    androidClientId: '1016864985057-cio9kdp6r06ps6ehg2oa17sc0nk4i24n.apps.googleusercontent.com',
    iosClientId: '1016864985057-dqrr4j0qa11bnk2enrov2fdg3a9ne5u6.apps.googleusercontent.com',
    iosBundleId: 'com.auraapp.live',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB-GdGe98yZIGvG7y9APj6IC4u8ir1esM0',
    appId: '1:1016864985057:web:44c3b63feef48b36c38ca0',
    messagingSenderId: '1016864985057',
    projectId: 'aura-live-15d96',
    authDomain: 'aura-live-15d96.firebaseapp.com',
    storageBucket: 'aura-live-15d96.firebasestorage.app',
    measurementId: 'G-45BT327X5T',
  );

}