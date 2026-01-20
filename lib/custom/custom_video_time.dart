import 'dart:io';

import 'package:auralive/utils/utils.dart';
import 'package:video_player/video_player.dart';

class CustomVideoTime {
  static VideoPlayerController? _videoPlayerController;

  static Future<int?> onGet(String videoPath) async {
    try {
      // Dispose safely
      if (_videoPlayerController != null) {
        final oldController = _videoPlayerController;
        _videoPlayerController = null;
        await oldController?.dispose();
      }

      final controller = VideoPlayerController.file(File(videoPath));
      await controller.initialize();

      if (controller.value.isInitialized) {
        _videoPlayerController = controller;
        final videoTime = controller.value.duration.inSeconds;
        Utils.showLog("Get Video Time => $videoTime");
        return videoTime;
      } else {
        Utils.showLog("Get Video Time Error => Video Not Initialize");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Video Time Error => $e");
      return null;
    }
  }
}
