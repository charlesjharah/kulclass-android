import 'package:get/get.dart';
import 'package:auralive/pages/my_wallet_page/controller/my_wallet_controller.dart';

class MyWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWalletController>(() => MyWalletController());
  }
}
