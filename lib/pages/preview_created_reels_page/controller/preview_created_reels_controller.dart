import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/utils.dart';
import 'package:video_player/video_player.dart';

class PreviewCreatedReelsController extends GetxController {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  bool isPlaying = true;
  bool isVideoLoading = true;
  bool isShowPlayPauseIcon = false;

  int videoTime = 0;
  String videoUrl = "";
  String videoThumbnail = "";
  String songId = "";

  @override
  void onInit() {
    final arguments = Get.arguments;
    Utils.showLog("Selected Video => $arguments");
    videoUrl = arguments["video"];
    videoThumbnail = arguments["image"];
    videoTime = arguments["time"];
    songId = arguments["songId"] ?? "";
    initializeVideoPlayer(videoUrl);

    Utils.showLog("Selected Song Id => $songId");
    super.onInit();
  }

  Future<void> initializeVideoPlayer(String videoPath) async {
    try {
      await onDisposeVideoPlayer();

      videoPlayerController = VideoPlayerController.file(File(videoPath));
      await videoPlayerController?.initialize();

      if (videoPlayerController != null &&
          (videoPlayerController?.value.isInitialized ?? false)) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          looping: true,
          allowedScreenSleep: false,
          allowMuting: false,
          showControlsOnInitialize: false,
          showControls: false,
          autoPlay: true,
        );

        if (chewieController != null) {
          onChangeLoading(false);
        } else {
          onChangeLoading(true);
        }
      }
    } catch (e) {
      await onDisposeVideoPlayer();
      Utils.showLog("Reels Video Initialization Failed !!! => $e");
    }
  }

  void onStopVideo() {
    onChangePlayPauseIcon(false);
    videoPlayerController?.pause();
  }

  void onPlayVideo() {
    onChangePlayPauseIcon(true);
    videoPlayerController?.play();
  }

  void onClickVideo() async {
    if (isVideoLoading == false) {
      videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
      onShowPlayPauseIcon(true);
      await 2.seconds.delay();
      onShowPlayPauseIcon(false);
    }
  }

  void onClickPlayPause() async {
    videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
  }

  void onChangeLoading(bool value) {
    isVideoLoading = value;
    update(["onChangeLoading"]);
  }

  void onChangePlayPauseIcon(bool value) {
    isPlaying = value;
    update(["onChangePlayPauseIcon"]);
  }

  void onShowPlayPauseIcon(bool value) {
    isShowPlayPauseIcon = value;
    update(["onShowPlayPauseIcon"]);
  }

  Future<void> onDisposeVideoPlayer() async {
    try {
      onStopVideo();

      if (videoPlayerController != null) {
        await videoPlayerController!.dispose(); // ✅ video_player is async
        videoPlayerController = null;
      }

      if (chewieController != null) {
        chewieController!.dispose(); // ✅ remove await, returns void
        chewieController = null;
      }

      onChangeLoading(true);
      Utils.showLog("Video Dispose Success");
    } catch (e) {
      Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
    }
  }


  @override
  void onClose() async {
    await 500.milliseconds.delay();
    await onDisposeVideoPlayer();
    super.onClose();
  }

  void onClickNext() {
    onStopVideo();

    if (Utils.shortsDuration > videoTime) {
      Get.toNamed(
        AppRoutes.uploadReelsPage,
        arguments: {
          "video": videoUrl,
          "image": videoThumbnail,
          "time": videoTime,
          "songId": songId
        },
      );
    } else {
      Utils.showToast(
          "your duration of Video greater than decided by the admin !!");
    }
  }
}
