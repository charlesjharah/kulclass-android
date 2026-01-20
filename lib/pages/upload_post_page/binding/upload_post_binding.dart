import 'package:get/get.dart';
import 'package:auralive/pages/upload_post_page/controller/upload_post_controller.dart';

class UploadPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadPostController>(() => UploadPostController());
  }
}
