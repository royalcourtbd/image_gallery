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
    apiKey: 'AIzaSyBLhWf_R9PIsw2M9GIqzMq_SfzWps1iXS8',
    appId: '1:214167247821:web:dd4deb801b00c64b7d4284',
    messagingSenderId: '214167247821',
    projectId: 'imagegallery-13c30',
    authDomain: 'imagegallery-13c30.firebaseapp.com',
    storageBucket: 'imagegallery-13c30.appspot.com',
    measurementId: 'G-PFRB24FK1H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxOJcr9wGPyjmZhTJZ5Ro2hKPADoxLrb0',
    appId: '1:214167247821:android:eb369a82f7ac4f0f7d4284',
    messagingSenderId: '214167247821',
    projectId: 'imagegallery-13c30',
    storageBucket: 'imagegallery-13c30.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCywcQzdTZ5tHCMgC1nbGWkvvGVAE3wWZo',
    appId: '1:214167247821:ios:3888a7e0890e28947d4284',
    messagingSenderId: '214167247821',
    projectId: 'imagegallery-13c30',
    storageBucket: 'imagegallery-13c30.appspot.com',
    iosBundleId: 'com.royalcourtbd.imageGallery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCywcQzdTZ5tHCMgC1nbGWkvvGVAE3wWZo',
    appId: '1:214167247821:ios:234cee10253fa1617d4284',
    messagingSenderId: '214167247821',
    projectId: 'imagegallery-13c30',
    storageBucket: 'imagegallery-13c30.appspot.com',
    iosBundleId: 'com.royalcourtbd.imageGallery.RunnerTests',
  );
}
