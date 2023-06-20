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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD3g-Hy9ZQFj7--1EctPruLl8y6-Uup41o',
    appId: '1:581104884832:web:f3ddce64bffdd6c2413705',
    messagingSenderId: '581104884832',
    projectId: 'tracking-system-c87dd',
    authDomain: 'tracking-system-c87dd.firebaseapp.com',
    storageBucket: 'tracking-system-c87dd.appspot.com',
    measurementId: 'G-676S9JNG1B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUJZNJKZPWn6foH7Idcg4mXYvbdP6Ft6E',
    appId: '1:581104884832:android:6f94e88d7f01d38e413705',
    messagingSenderId: '581104884832',
    projectId: 'tracking-system-c87dd',
    storageBucket: 'tracking-system-c87dd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5JKiVSTLGYMxJcCqPuCpW9GZs3lAAJo4',
    appId: '1:581104884832:ios:91ad82696600371a413705',
    messagingSenderId: '581104884832',
    projectId: 'tracking-system-c87dd',
    storageBucket: 'tracking-system-c87dd.appspot.com',
    iosClientId: '581104884832-ip1qhnqur978k68q8u1d4b6ho8gsohg9.apps.googleusercontent.com',
    iosBundleId: 'com.example.budgetTrackerUi',
  );
}
