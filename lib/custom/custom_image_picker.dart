import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/utils.dart';

class CustomImagePicker {
  static Future<String?> pickImage(ImageSource imageSource) async {
    try {
      Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...
      final image = await ImagePicker().pickImage(source: imageSource);
      Get.back(); // Stop Loading...

      if (image != null) {
        Utils.showLog("Pick Image Path => ${image.path}");
        return image.path;
      } else {
        Utils.showLog("Image Not Selected !!");
        return null;
      }
    } catch (e) {
      Utils.showLog("Image Picker Error => $e");
      return null;
    }
  }
}
