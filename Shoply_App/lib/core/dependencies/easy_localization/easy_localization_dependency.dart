import 'package:easy_localization/easy_localization.dart';

class EasyLocalizationDependency {
  static Future<void> inttEasyLocalizationDependency() async {
    await EasyLocalization.ensureInitialized();
  }
}
