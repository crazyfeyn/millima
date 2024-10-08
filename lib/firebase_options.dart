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
    apiKey: 'AIzaSyCi62DHK78QHZkyJ5eG0Wp6ipiE02ISr2U',
    appId: '1:492603061234:web:d7fb34239e0e71d21db16b',
    messagingSenderId: '492603061234',
    projectId: 'darsxona-ebb7d',
    authDomain: 'darsxona-ebb7d.firebaseapp.com',
    storageBucket: 'darsxona-ebb7d.appspot.com',
    measurementId: 'G-ZENXHS98FS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgIJ4NlMr0RZAudeLO76GcDgiZR1yDV60',
    appId: '1:492603061234:android:f85a2b833ba5a7b21db16b',
    messagingSenderId: '492603061234',
    projectId: 'darsxona-ebb7d',
    storageBucket: 'darsxona-ebb7d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBi3s1SSKKeqaHIlEWiNLqHo4UexsWH9PM',
    appId: '1:492603061234:ios:20399f75358397371db16b',
    messagingSenderId: '492603061234',
    projectId: 'darsxona-ebb7d',
    storageBucket: 'darsxona-ebb7d.appspot.com',
    iosClientId: '492603061234-59uq1evdgn3mlmdk3k1vpqa25hngvcf4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication',
  );
}
