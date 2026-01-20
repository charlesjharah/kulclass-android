import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/connection_page/api/follow_unfollow_api.dart';
import 'package:auralive/pages/fake_live_page/widget/fake_comment_data.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class FakeLiveController extends GetxController {
  bool isFrontCamera = false;
  bool isFlashOn = false;
  bool isMicOn = true;
  Timer? time;

  String userId = "";
  String image = "";
  String name = "";
  String userName = "";
  bool isFollow = false;
  String videoUrl = "";
  int countTime = 0;
  bool isLivePage = false;

  ScrollController scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();

  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;
  bool isVideoLoading = true;

  Future<void> onSwitchMic() async {
    isMicOn = !isMicOn;
    ZegoExpressEngine.instance.enableAudioCaptureDevice(isMicOn);
    update(["onSwitchMic"]);
  }

  Future<void> onSwitchCamera() async {
    Get.dialog(const LoadingUi(), barrierDismissible: false);
    if (isFrontCamera) {
      ZegoExpressEngine.instance.useFrontCamera(isFrontCamera);
      isFrontCamera = !isFrontCamera;
      await 200.milliseconds.delay();
      ZegoExpressEngine.instance.useFrontCamera(isFrontCamera);
    } else {
      ZegoExpressEngine.instance.useFrontCamera(isFrontCamera);
      isFrontCamera = !isFrontCamera;
      await 200.milliseconds.delay();
      ZegoExpressEngine.instance.useFrontCamera(isFrontCamera);
    }
    Get.back();
  }

  @override
  void onInit() {
    addFakeComment();
    super.onInit();
  }

  void addFakeComment() {
    log("object::::initState");
    time = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      log("object::::initState");
      addItems();
    });
  }

  @override
  Future<void> onClose() async {
    time?.cancel();
    scrollController.dispose();
    commentController.dispose(); // ✅ must be disposed
    await onDisposeVideoPlayer(); // ✅ await async cleanup
    super.onClose();
  }

  Future<void> initializeVideoPlayer() async {
    try {
      log("Video Url =>'${Api.baseUrl + videoUrl}'");

      // clean up before re-initializing
      await onDisposeVideoPlayer();

      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(Api.baseUrl + videoUrl),
      );

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
          maxScale: 1,
        );
        videoPlayerController?.play();
        update(["initializeVideoPlayer"]);
      }
    } catch (e) {
      await onDisposeVideoPlayer();
      Utils.showLog("FakeLive Video Initialization Failed !!! => $e");
    }
  }

  /// ✅ async disposal
  Future<void> onDisposeVideoPlayer() async {
    try {
      if (videoPlayerController != null) {
        await videoPlayerController!.dispose();
        videoPlayerController = null;
      }

      if (chewieController != null) {
        chewieController!.dispose();
        chewieController = null;
      }
    } catch (e) {
      Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
    }
  }

  void addItems() {
    fakeHostCommentList.shuffle();
    log("object::::  1${fakeHostCommentList.first.message}");

    fakeHostCommentListBlank.add(fakeHostCommentList.first);
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeOut,
    );
    update();
  }

  Future<void> onSendComment() async {
    if (commentController.text.trim().isNotEmpty) {
      fakeHostCommentListBlank.add(
        HostComment(
          message: commentController.text.toString(),
          user: Database.fetchLoginUserProfileModel?.user?.name ?? "",
          image: (Api.baseUrl +
              (Database.fetchLoginUserProfileModel?.user?.image ?? "")),
        ),
      );
    }
    commentController.clear();
  }

  Future<void> onClickFollow() async {
    if (userId != Database.loginUserId) {
      isFollow = !isFollow;
      update(["onClickFollow"]);
      await FollowUnfollowApi.callApi(
        loginUserId: Database.loginUserId,
        userId: userId,
      );
    } else {
      Utils.showToast(EnumLocal.txtYouCantFollowYourOwnAccount.name.tr);
    }
  }

  void onChangeTime() {
    isLivePage = true;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isLivePage) {
        countTime++;
        Utils.showLog(
            "Live Streaming Time => ${onConvertSecondToHMS(countTime)}");
        update(["onChangeTime"]);
      } else {
        timer.cancel();
        countTime = 0;
        update(["onChangeTime"]);
      }
    });
  }

  String onConvertSecondToHMS(int totalSeconds) {
    Duration duration = Duration(seconds: totalSeconds);

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
