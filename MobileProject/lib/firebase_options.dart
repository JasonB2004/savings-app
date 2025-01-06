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
    apiKey: 'AIzaSyC2Q9IPx7Kpt-Z0MpWHwhudeWNsOK_Wpo8',
    appId: '1:119144992456:web:9f6e159c322adbf5781ffd',
    messagingSenderId: '119144992456',
    projectId: 'mobileproject-2d63a',
    authDomain: 'mobileproject-2d63a.firebaseapp.com',
    storageBucket: 'mobileproject-2d63a.firebasestorage.app',
    measurementId: 'G-VDS0GETLQX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWbwFYV_HDHRzbOTokfeJkJfOWLy-EuHA',
    appId: '1:119144992456:android:4da18584d376dd72781ffd',
    messagingSenderId: '119144992456',
    projectId: 'mobileproject-2d63a',
    storageBucket: 'mobileproject-2d63a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA608mwZrdY4qJ42N53PnO6fQN9QGFfVD4',
    appId: '1:119144992456:ios:6e6a3f979877e352781ffd',
    messagingSenderId: '119144992456',
    projectId: 'mobileproject-2d63a',
    storageBucket: 'mobileproject-2d63a.firebasestorage.app',
    iosBundleId: 'com.example.mobileproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA608mwZrdY4qJ42N53PnO6fQN9QGFfVD4',
    appId: '1:119144992456:ios:6e6a3f979877e352781ffd',
    messagingSenderId: '119144992456',
    projectId: 'mobileproject-2d63a',
    storageBucket: 'mobileproject-2d63a.firebasestorage.app',
    iosBundleId: 'com.example.mobileproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2Q9IPx7Kpt-Z0MpWHwhudeWNsOK_Wpo8',
    appId: '1:119144992456:web:78652be4cb4e4848781ffd',
    messagingSenderId: '119144992456',
    projectId: 'mobileproject-2d63a',
    authDomain: 'mobileproject-2d63a.firebaseapp.com',
    storageBucket: 'mobileproject-2d63a.firebasestorage.app',
    measurementId: 'G-Y9GWF8VG8E',
  );

}