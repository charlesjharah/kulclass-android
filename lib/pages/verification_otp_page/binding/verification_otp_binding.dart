import 'package:get/get.dart';
import 'package:auralive/pages/verification_otp_page/controller/verification_otp_controller.dart';

class VerificationOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationOtpController>(() => VerificationOtpController());
  }
}
