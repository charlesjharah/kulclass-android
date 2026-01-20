import 'package:get/get.dart';
import 'package:auralive/pages/preview_hash_tag_page/controller/preview_hash_tag_controller.dart';

class PreviewHashTagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewHashTagController>(() => PreviewHashTagController());
  }
}
