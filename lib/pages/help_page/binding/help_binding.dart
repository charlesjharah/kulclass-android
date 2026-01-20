import 'package:get/get.dart';
import 'package:auralive/pages/help_page/controller/help_controller.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpController>(() => HelpController());
  }
}
