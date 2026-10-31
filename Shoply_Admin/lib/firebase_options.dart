// Android configuration registered in the Shoply Store Firebase project.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    throw UnsupportedError(
      'Firebase is currently configured for Android only.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAN-s9fux3W5h1Q-EVVvMUhDUXECOVhK0A',
    appId: '1:178467748885:android:8eadd6005384bb730fe21c',
    messagingSenderId: '178467748885',
    projectId: 'shoply-store-2aef6',
    storageBucket: 'shoply-store-2aef6.firebasestorage.app',
  );
}
