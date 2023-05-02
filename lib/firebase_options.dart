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
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAbqW7X77MZBrVI5I2CJd0GfQQJ2uhfH0c',
    appId: '1:158576154553:web:a4881527ce2a9684bb8868',
    messagingSenderId: '158576154553',
    projectId: 'podium-78b4e',
    authDomain: 'podium-78b4e.firebaseapp.com',
    databaseURL: 'https://podium-78b4e-default-rtdb.firebaseio.com',
    storageBucket: 'podium-78b4e.appspot.com',
    measurementId: 'G-NG6RZE5X1N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIX2ljqTjgTtFRF0jbOifVJfZXHoWoQeo',
    appId: '1:158576154553:android:234a19ec99c8b9b8bb8868',
    messagingSenderId: '158576154553',
    projectId: 'podium-78b4e',
    databaseURL: 'https://podium-78b4e-default-rtdb.firebaseio.com',
    storageBucket: 'podium-78b4e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgtfuOjEhLJC6kODXyg7J2Cox2eIwvqiU',
    appId: '1:158576154553:ios:953e4b3e19ccbc70bb8868',
    messagingSenderId: '158576154553',
    projectId: 'podium-78b4e',
    databaseURL: 'https://podium-78b4e-default-rtdb.firebaseio.com',
    storageBucket: 'podium-78b4e.appspot.com',
    iosClientId:
        '''158576154553-9ubij3hn8i4uavchk5lbdar01057ge8t.apps.googleusercontent.com''',
    iosBundleId: 'com.podium',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgtfuOjEhLJC6kODXyg7J2Cox2eIwvqiU',
    appId: '1:158576154553:ios:f165f7f94d28d432bb8868',
    messagingSenderId: '158576154553',
    projectId: 'podium-78b4e',
    databaseURL: 'https://podium-78b4e-default-rtdb.firebaseio.com',
    storageBucket: 'podium-78b4e.appspot.com',
    iosClientId:
        '''158576154553-10p4tuinalhluulb2nk7hmk5elr6s4ih.apps.googleusercontent.com''',
    iosBundleId: 'com.masterRepo.RunnerTests',
  );
}
