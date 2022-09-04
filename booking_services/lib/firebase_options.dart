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
    apiKey: 'AIzaSyAYy8qVxMjxmWDcgnRdizL1Gnu4D_T596E',
    appId: '1:237010053920:web:041522ac0251c464d28545',
    messagingSenderId: '237010053920',
    projectId: 'booking-services-a19ac',
    authDomain: 'booking-services-a19ac.firebaseapp.com',
    storageBucket: 'booking-services-a19ac.appspot.com',
    measurementId: 'G-32NCBMT69Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCq-36FxHjv5AaumOyU-I575nLWckf6oWE',
    appId: '1:237010053920:android:8d4089d4b66b1f64d28545',
    messagingSenderId: '237010053920',
    projectId: 'booking-services-a19ac',
    storageBucket: 'booking-services-a19ac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAv1G9Cls-l4jrTp2Tlsv_H0A-lnoe_Ss0',
    appId: '1:237010053920:ios:b1807412594f0028d28545',
    messagingSenderId: '237010053920',
    projectId: 'booking-services-a19ac',
    storageBucket: 'booking-services-a19ac.appspot.com',
    androidClientId: '237010053920-ptn8ke1fseb9taqq20gooa32lfsdvdqt.apps.googleusercontent.com',
    iosClientId: '237010053920-mfnt1naue879b3p0hhocqftehuilaa2a.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookingServices',
  );
}
