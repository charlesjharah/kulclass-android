import 'package:get/get.dart';
import 'package:auralive/pages/reels_page/controller/reels_controller.dart';

class ReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReelsController>(() => ReelsController());
  }
}
