import 'package:shoply_app/core/local/local_storage.dart';

class LocalStorageDependency {
  static Future<void> initloaclStoradeDependency() async {
    await LocalStorage.instance.initSharedPreferences();
  }
}
