import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeController extends GetxController {
  MobileScannerController mobileScannerController = MobileScannerController();

  @override
  void onClose() {
    mobileScannerController.dispose();
    super.onClose();
  }
}
