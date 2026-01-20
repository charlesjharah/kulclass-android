import 'package:get/get.dart';
import 'package:auralive/pages/recharge_page/controller/recharge_controller.dart';

class RechargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargeController>(() => RechargeController());
  }
}
