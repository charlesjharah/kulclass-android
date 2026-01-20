import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/utils.dart';

class CustomVideoPicker {
  static Future<String?> pickVideo() async {
    try {
      Get.dialog(barrierDismissible: false, const LoadingUi());
      final videoPath = await ImagePicker().pickVideo(source: ImageSource.gallery);
      Get.back();

      if (videoPath != null) {
        return videoPath.path;
      } else {
        Utils.showLog("Video Not Selected !!");
        return null;
      }
    } catch (e) {
      Utils.showLog("Video Picker Error => $e");
      return null;
    }
  }
}
