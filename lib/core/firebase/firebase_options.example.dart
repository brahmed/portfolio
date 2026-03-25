// Copy this file to firebase_options.dart and fill in your values.
// Run: flutterfire configure  OR  fill values manually below.
//
// NEVER commit firebase_options.dart — it is listed in .gitignore.
//
// Local development:
//   flutter run -d chrome \
//     --dart-define=FIREBASE_API_KEY=xxx \
//     --dart-define=FIREBASE_AUTH_DOMAIN=xxx.firebaseapp.com \
//     --dart-define=FIREBASE_PROJECT_ID=xxx \
//     --dart-define=FIREBASE_STORAGE_BUCKET=xxx.appspot.com \
//     --dart-define=FIREBASE_MESSAGING_SENDER_ID=xxx \
//     --dart-define=FIREBASE_APP_ID=xxx \
//     --dart-define=FIREBASE_MEASUREMENT_ID=G-xxx

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('Unsupported platform');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
    authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
    projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
    storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
    messagingSenderId:
        String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
    appId: String.fromEnvironment('FIREBASE_APP_ID'),
    measurementId: String.fromEnvironment('FIREBASE_MEASUREMENT_ID'),
  );
}
