# Shoply Admin (Android)

This Flutter app manages the same Firestore catalog used by Shoply. It connects to the `shoply-store-2aef6` Firebase project. The owner account is created in Firebase Authentication and is granted access by an `admins/<user UID>` Firestore document. Sign in with the admin email and password created during setup.

## Run

Open this folder in Antigravity, select the Android emulator, and run `lib/main.dart`. Alternatively, from this folder run `flutter pub get` and `flutter run`. The generated debug APK is for development and testing; a separately configured release signing key is needed for publishing.

## Manage the store

- Products: add, edit, and delete products and control whether they appear in Trending. A product belongs to a category; to change its category, create it in the new category and remove the original.
- Categories: add and edit categories. Delete products in a category before deleting the category.
- Orders: inspect orders and update their status.
- Banner: add or edit the home-page image.
- Images use public HTTP(S) image URLs. This app does not upload images from the device.

The download icon offers a one-time import of the catalog saved during setup. It stops if the new database already contains categories or a banner. The initial import has already been completed.

The Firebase security rules are maintained in the customer project's `firestore.rules`. Only accounts with an administrator document can change the catalog or access all orders. Customer and order data from the previous Firebase project were not migrated.

## Project structure

The app uses feature-oriented MVVM. `lib/main.dart` initializes Firebase and composes dependencies; `lib/app` owns the app and dependency scope; `lib/core` contains shared models and widgets. Each feature under `lib/features` separates its views, view models, and data repositories. Firebase access is confined to repository implementations, and the repository interfaces let the view models be tested with fakes. `test/` contains focused authentication, catalog, and responsive sign-in tests.
