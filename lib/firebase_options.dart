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
    apiKey: 'AIzaSyC4mkGs6_Zw5yQCwckj1M6T60J5m-sawPU',
    appId: '1:851985988122:web:58d64bbc60ef2341552fa3',
    messagingSenderId: '851985988122',
    projectId: 'proyecto-modular-7e78c',
    authDomain: 'proyecto-modular-7e78c.firebaseapp.com',
    storageBucket: 'proyecto-modular-7e78c.appspot.com',
    measurementId: 'G-S4QF6GD7H7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCz2NZyeiu7G-RFDPlgv_dZO0oaew0v4Cc',
    appId: '1:851985988122:android:0f805eb1636f505e552fa3',
    messagingSenderId: '851985988122',
    projectId: 'proyecto-modular-7e78c',
    storageBucket: 'proyecto-modular-7e78c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASt79HaLqwOC_nNEuRFIJhR35BKQUjWT4',
    appId: '1:851985988122:ios:89a023db3fcd2f62552fa3',
    messagingSenderId: '851985988122',
    projectId: 'proyecto-modular-7e78c',
    storageBucket: 'proyecto-modular-7e78c.appspot.com',
    iosBundleId: 'com.example.proyectoModular',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASt79HaLqwOC_nNEuRFIJhR35BKQUjWT4',
    appId: '1:851985988122:ios:89a023db3fcd2f62552fa3',
    messagingSenderId: '851985988122',
    projectId: 'proyecto-modular-7e78c',
    storageBucket: 'proyecto-modular-7e78c.appspot.com',
    iosBundleId: 'com.example.proyectoModular',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4mkGs6_Zw5yQCwckj1M6T60J5m-sawPU',
    appId: '1:851985988122:web:75ebefe4ba8ee057552fa3',
    messagingSenderId: '851985988122',
    projectId: 'proyecto-modular-7e78c',
    authDomain: 'proyecto-modular-7e78c.firebaseapp.com',
    storageBucket: 'proyecto-modular-7e78c.appspot.com',
    measurementId: 'G-G30TZHMPQP',
  );
}
