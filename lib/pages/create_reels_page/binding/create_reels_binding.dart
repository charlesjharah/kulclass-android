import 'package:get/get.dart';
import 'package:auralive/pages/create_reels_page/controller/create_reels_controller.dart';

class CreateReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateReelsController>(() => CreateReelsController());
  }
}
