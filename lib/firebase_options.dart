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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBW2cbYykGrZEp4d4y3PR6RIM1M8I1mNl8',
    appId: '1:298864058693:android:fcb0e7faa4cb61a3a95e2c',
    messagingSenderId: '298864058693',
    projectId: 'gymvita-connect-88697',
    storageBucket: 'gymvita-connect-88697.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJ-UMVhOTqpdj00KSeObYnb2LW6-cj5TE',
    appId: '1:298864058693:ios:6c181bb6faa4ebada95e2c',
    messagingSenderId: '298864058693',
    projectId: 'gymvita-connect-88697',
    storageBucket: 'gymvita-connect-88697.appspot.com',
    iosBundleId: 'com.example.gymvitaConnect',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDCDJl2Jezd2k3pycVoCZ88tmK6qkMh9ec',
    appId: '1:298864058693:web:d5e37e6f2387c812a95e2c',
    messagingSenderId: '298864058693',
    projectId: 'gymvita-connect-88697',
    authDomain: 'gymvita-connect-88697.firebaseapp.com',
    storageBucket: 'gymvita-connect-88697.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJ-UMVhOTqpdj00KSeObYnb2LW6-cj5TE',
    appId: '1:298864058693:ios:6c181bb6faa4ebada95e2c',
    messagingSenderId: '298864058693',
    projectId: 'gymvita-connect-88697',
    storageBucket: 'gymvita-connect-88697.appspot.com',
    iosBundleId: 'com.example.gymvitaConnect',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDCDJl2Jezd2k3pycVoCZ88tmK6qkMh9ec',
    appId: '1:298864058693:web:8e2a5fc2a4cc79e9a95e2c',
    messagingSenderId: '298864058693',
    projectId: 'gymvita-connect-88697',
    authDomain: 'gymvita-connect-88697.firebaseapp.com',
    storageBucket: 'gymvita-connect-88697.appspot.com',
  );

}