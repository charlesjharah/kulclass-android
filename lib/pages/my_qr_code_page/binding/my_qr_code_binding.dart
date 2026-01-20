import 'package:get/get.dart';
import 'package:auralive/pages/my_qr_code_page/controller/my_qr_code_controller.dart';

class MyQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyQrCodeController>(() => MyQrCodeController());
  }
}
