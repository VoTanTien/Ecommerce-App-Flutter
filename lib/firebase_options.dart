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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKQ_WxcVl6Fx2Mg0uM7iPuQ1Z0J3nxeVc',
    appId: '1:128982238934:android:e887db8cb961df2325eb77',
    messagingSenderId: '128982238934',
    projectId: 'twottech-957c4',
    databaseURL: 'https://twottech-957c4-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'twottech-957c4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaNdox1Kj3ihUsiBgrtneqo71Cgu8hsxM',
    appId: '1:128982238934:ios:50e8477c01938e2525eb77',
    messagingSenderId: '128982238934',
    projectId: 'twottech-957c4',
    databaseURL: 'https://twottech-957c4-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'twottech-957c4.firebasestorage.app',
    iosBundleId: 'com.example.tTProject',
  );

}