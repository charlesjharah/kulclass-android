import 'dart:async';
import 'package:get/get.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/pages/feed_page/controller/feed_controller.dart';
import 'package:auralive/pages/message_page/controller/message_controller.dart';
import 'package:auralive/pages/profile_page/controller/profile_controller.dart';
import 'package:auralive/pages/reels_page/controller/reels_controller.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomBarController());
    Get.put(ReelsController());
    Get.put(StreamController());
    Get.put(FeedController());
    Get.put(MessageController());
    Get.put(ProfileController());
  }
}
