import 'package:get/get.dart';
import 'package:auralive/pages/preview_trim_video_page/controller/preview_trim_video_controller.dart';

class PreviewTrimVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewTrimVideoController>(() => PreviewTrimVideoController());
  }
}
