// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBO55dLTMZTpr8yqga8MPs8FwsmtU_8y1A',
    appId: '1:317350571036:web:ce58b22288dcb74b1003d9',
    messagingSenderId: '317350571036',
    projectId: 'shopar-3f662',
    authDomain: 'shopar-3f662.firebaseapp.com',
    storageBucket: 'shopar-3f662.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-zRjuuTbpKvgI0mqhC3sN9gteeoKM6ks',
    appId: '1:317350571036:android:44dc1edcfb276ac11003d9',
    messagingSenderId: '317350571036',
    projectId: 'shopar-3f662',
    storageBucket: 'shopar-3f662.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEJFu5PFSaaOp6VlLqaAQvdQUEqpJXPv4',
    appId: '1:317350571036:ios:f0569ea356dcba811003d9',
    messagingSenderId: '317350571036',
    projectId: 'shopar-3f662',
    storageBucket: 'shopar-3f662.appspot.com',
    iosClientId: '317350571036-86nnfq8r7euk1426n1uq3h3rvhr9d7ud.apps.googleusercontent.com',
    iosBundleId: 'com.shopar.app',
  );
}