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
    apiKey: 'AIzaSyCFLfdJla8lw9WOBnt1QSh87Lc0Ng_1mYE',
    appId: '1:610396238684:web:8d7dc2dbfe1e3a29218799',
    messagingSenderId: '610396238684',
    projectId: 'crypto-coins-fcce1',
    authDomain: 'crypto-coins-fcce1.firebaseapp.com',
    storageBucket: 'crypto-coins-fcce1.appspot.com',
    measurementId: 'G-GTZ2VFSH9R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBozEe5LRcafYZN0_9kizymYRo4wrlpEOM',
    appId: '1:610396238684:android:11f2d158fc848f48218799',
    messagingSenderId: '610396238684',
    projectId: 'crypto-coins-fcce1',
    storageBucket: 'crypto-coins-fcce1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzNqfPYctbp9zU-U6K1gCTfrlA8_EylJA',
    appId: '1:610396238684:ios:41e1f6ef2d203ded218799',
    messagingSenderId: '610396238684',
    projectId: 'crypto-coins-fcce1',
    storageBucket: 'crypto-coins-fcce1.appspot.com',
    iosClientId: '610396238684-u2vk2i757qghpdr7v4e744aj59tanpeh.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTestApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzNqfPYctbp9zU-U6K1gCTfrlA8_EylJA',
    appId: '1:610396238684:ios:fa9fbd78fbd5add4218799',
    messagingSenderId: '610396238684',
    projectId: 'crypto-coins-fcce1',
    storageBucket: 'crypto-coins-fcce1.appspot.com',
    iosClientId: '610396238684-dumbb12o3q18gol0mbipbjnck56n04hc.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTestApp.RunnerTests',
  );
}
