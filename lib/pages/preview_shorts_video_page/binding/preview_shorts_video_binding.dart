import 'package:get/get.dart';
import 'package:auralive/pages/preview_shorts_video_page/controller/preview_shorts_video_controller.dart';

class PreviewShortsVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewShortsVideoController>(() => PreviewShortsVideoController());
  }
}
