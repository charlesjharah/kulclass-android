import 'package:get/get.dart';
import 'package:auralive/pages/preview_message_request_page/controller/preview_message_request_controller.dart';

class PreviewMessageRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewMessageRequestController>(() => PreviewMessageRequestController());
  }
}
