import 'package:get/get.dart';
import 'package:auralive/pages/on_boarding_page/controller/on_boarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }
}
