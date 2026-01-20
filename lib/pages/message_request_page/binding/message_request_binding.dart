import 'package:get/get.dart';
import 'package:auralive/pages/message_request_page/controller/message_request_controller.dart';

class MessageRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageRequestController>(() => MessageRequestController());
  }
}
