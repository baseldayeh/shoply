import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadImageService {
  static Future<String?> uplaodImage({required File imageFile}) async {
    try {
      final imageName = imageFile.uri.pathSegments.last;
      final supasbase = Supabase.instance.client;
      final uplaodImage = await supasbase.storage
          .from('profile-image')
          .upload('uploads/$imageName', imageFile);

      if (uplaodImage.isNotEmpty) {
        return supasbase.storage
            .from('profile-image')
            .getPublicUrl('uploads/$imageName');
      } else {
        return null;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
