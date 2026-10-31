import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDependency {
  static Future<void> supabaseInitDependency() async {
    await Supabase.initialize(
      url: 'https://jyomsmpghllqjhibbrmx.supabase.co',
      publishableKey: 'sb_publishable_2zupaeN0zwg-K4Mgg5rfjg_pvd8ZxYK',
    );
  }
}
