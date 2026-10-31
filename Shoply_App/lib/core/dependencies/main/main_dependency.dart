import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/core/dependencies/easy_localization/easy_localization_dependency.dart';
import 'package:shoply_app/core/dependencies/firebase/firebase_dependency.dart';
import 'package:shoply_app/core/dependencies/local_storage/local_storage_dependency.dart';
import 'package:shoply_app/core/dependencies/supabase/supabase_dependency.dart';

class MainDependency {
  static Future<void> mainInitDependency() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageDependency.initloaclStoradeDependency();
    await FirebaseDependency.inttFirebaseDependency();
    final projectId = Firebase.app().options.projectId;
    final local = LocalStorage.instance;
    if (local.getFirebaseProject() != projectId) {
      // A session from a different Firebase project cannot authenticate here.
      await FirebaseAuth.instance.signOut();
      await local.setIsLogin(isLogin: false);
      await local.setFirebaseProject(projectId);
    }
    await SupabaseDependency.supabaseInitDependency();
    await EasyLocalizationDependency.inttEasyLocalizationDependency();
  }
}
