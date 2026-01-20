import 'package:get/get.dart';
import 'package:auralive/pages/mobile_num_login_page/controller/mobile_num_login_controller.dart';

class MobileNumLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileNumLoginController>(() => MobileNumLoginController());
  }
}
