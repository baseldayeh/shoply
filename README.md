# Shoply

Shoply is a Flutter shopping application with a separate Android administration app. Both apps use the same Firebase project.

- [Shoply_App](Shoply_App/) — customer application for browsing products, managing a cart, and placing orders.
- [Shoply_Admin](Shoply_Admin/) — administration application for managing products, categories, banners, and orders. Its code is organized by feature using MVVM.

## Getting started

Install the Flutter SDK and Android tooling, open either application folder, then run:

```sh
flutter pub get
flutter run
```

Choose an Android emulator or connected Android device. Each app has its own `pubspec.yaml` and is run from its own folder. See the app READMEs for Firebase configuration and platform details. The checked-in Firebase client configuration connects to the existing shared project; database access is controlled by Firebase Authentication and Firestore security rules.
