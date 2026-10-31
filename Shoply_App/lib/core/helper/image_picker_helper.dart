import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final _picker = ImagePicker();

  static Future<XFile?> pickImageGallery() async {
    final pickImage = await _picker.pickImage(source: ImageSource.gallery);
    return pickImage;
  }
}
