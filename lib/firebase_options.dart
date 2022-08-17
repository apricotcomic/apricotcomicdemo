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
    apiKey: 'AIzaSyBu7gy-xSaSXLXqq2kZSczGZGez35NgR-Y',
    appId: '1:27856468215:web:a722fc07a5d35cc0efbbf2',
    messagingSenderId: '27856468215',
    projectId: 'apricotcomic-demo-e19d5',
    authDomain: 'apricotcomic-demo-e19d5.firebaseapp.com',
    storageBucket: 'apricotcomic-demo-e19d5.appspot.com',
    measurementId: 'G-53HEXWTGLR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuXv3zMj2pnZFipGbdVwJarq7W9GpD9Io',
    appId: '1:27856468215:android:21b1fa54ed04ca0befbbf2',
    messagingSenderId: '27856468215',
    projectId: 'apricotcomic-demo-e19d5',
    storageBucket: 'apricotcomic-demo-e19d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrtQ6m_w7xT07XwYJwS5jw-rkI2lk2haM',
    appId: '1:27856468215:ios:4cf673b06ad51131efbbf2',
    messagingSenderId: '27856468215',
    projectId: 'apricotcomic-demo-e19d5',
    storageBucket: 'apricotcomic-demo-e19d5.appspot.com',
    iosClientId: '27856468215-ikooli71r6u6li53q8gfg3qu3r84bnou.apps.googleusercontent.com',
    iosBundleId: 'com.example.apricotcomicdemo',
  );
}