import 'package:get/get.dart';
import 'package:auralive/pages/terms_of_use_page/controller/terms_of_use_controller.dart';

class TermsOfUseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsOfUseController>(() => TermsOfUseController());
  }
}
