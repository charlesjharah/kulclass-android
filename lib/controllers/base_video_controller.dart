import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:auralive/utils/utils.dart';

class BaseVideoController extends GetxController {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  bool isVideoLoading = true;
  bool isPlaying = false;

  /// Initialize from file
  Future<void> initFromFile(String videoPath, {bool autoPlay = true}) async {
    try {
      videoPlayerController = VideoPlayerController.file(File(videoPath));
      await videoPlayerController?.initialize();

      if (videoPlayerController!.value.isInitialized) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          autoPlay: autoPlay,
          looping: true,
          showControls: false,
          showControlsOnInitialize: false,
          allowMuting: false,
          allowedScreenSleep: false,
        );
        isVideoLoading = false;
        update();
      }
    } catch (e) {
      Utils.showLog("BaseVideoController init error => $e");
      disposeVideo();
    }
  }

  void play() {
    videoPlayerController?.play();
    isPlaying = true;
    update();
  }

  void pause() {
    videoPlayerController?.pause();
    isPlaying = false;
    update();
  }

  void togglePlayPause() {
    if (videoPlayerController?.value.isPlaying ?? false) {
      pause();
    } else {
      play();
    }
  }

  void disposeVideo() {
    try {
      videoPlayerController?.dispose();
      chewieController?.dispose();
      videoPlayerController = null;
      chewieController = null;
      isVideoLoading = true;
      isPlaying = false;
      Utils.showLog("BaseVideoController dispose success");
    } catch (e) {
      Utils.showLog("BaseVideoController dispose error => $e");
    }
  }

  @override
  void onClose() {
    disposeVideo();
    super.onClose();
  }
}
