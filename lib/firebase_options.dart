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
    apiKey: 'AIzaSyBH3rNR7gS9fQs7OakLODD3gykj_6RylGs',
    appId: '1:207793070467:web:a1576e25055fbe0dbed6b6',
    messagingSenderId: '207793070467',
    projectId: 'projectkranair',
    authDomain: 'projectkranair.firebaseapp.com',
    storageBucket: 'projectkranair.appspot.com',
    measurementId: 'G-B8X97BQPET',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-hzUFm58ccBd5FEal5lNWNh5Cs7NkirY',
    appId: '1:207793070467:android:82d51d0e0e6f44c4bed6b6',
    messagingSenderId: '207793070467',
    projectId: 'projectkranair',
    storageBucket: 'projectkranair.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCtpzKv_Kq5_CQM5GXc6aeELPPrDGiv7eM',
    appId: '1:207793070467:ios:0b67f383ecd242b7bed6b6',
    messagingSenderId: '207793070467',
    projectId: 'projectkranair',
    storageBucket: 'projectkranair.appspot.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCtpzKv_Kq5_CQM5GXc6aeELPPrDGiv7eM',
    appId: '1:207793070467:ios:0b67f383ecd242b7bed6b6',
    messagingSenderId: '207793070467',
    projectId: 'projectkranair',
    storageBucket: 'projectkranair.appspot.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBH3rNR7gS9fQs7OakLODD3gykj_6RylGs',
    appId: '1:207793070467:web:b907c26e9d19743bbed6b6',
    messagingSenderId: '207793070467',
    projectId: 'projectkranair',
    authDomain: 'projectkranair.firebaseapp.com',
    storageBucket: 'projectkranair.appspot.com',
    measurementId: 'G-DH8W42TYBB',
  );
}