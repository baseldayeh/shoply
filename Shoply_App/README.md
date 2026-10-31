# Shoply customer app (Android)

Open this folder in Antigravity, choose an Android emulator and run `lib/main.dart`. The Android app is configured for the `shoply-store-2aef6` Firebase project, shared with the separate Shoply Admin app. The project uses Firebase's Spark plan and a US (`nam5`) Firestore database.

The catalog was copied from the previous project. Accounts, carts, favorites and orders were not transferred; existing customers need accounts in the new Firebase project. A previous local login is signed out once when the app switches Firebase projects.

The included `firestore.rules` and `firestore.indexes.json` describe the published database rules and trending-products index. Catalog and banner data are publicly readable; customer data is restricted to its owner; catalog writes and order management require an administrator account. Configure and review security rules before changing the data model.

Android is the configured and tested platform. The iOS configuration has not been moved to the new Firebase project. The existing optional profile-image uploader uses the original Supabase service; product and category images use URLs and are not uploaded to Firebase Storage.

The build uses `kotlin.incremental=false` to avoid a Kotlin cache error when the Flutter package cache and project are on different Windows drives. The debug APK is for testing; production distribution requires release signing.
