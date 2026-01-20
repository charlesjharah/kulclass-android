import 'package:get/get.dart';
import 'package:auralive/pages/feed_page/controller/feed_controller.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(() => FeedController());
  }
}
