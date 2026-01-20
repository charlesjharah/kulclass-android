import 'dart:io';

import 'package:get/get.dart';
import 'package:auralive/custom/custom_thumbnail.dart';
import 'package:auralive/custom/custom_video_time.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimVideoController extends GetxController {
  final Trimmer trimmer = Trimmer();

  double startValue = 0.0;
  double endValue = 0.0;

  bool isLoading = false;
  bool isPlaying = false;
  bool isShowIcon = false;

  String videoPath = "";
  String saveVideoPath = "";
  String songId = "";

  @override
  void onInit() {
    videoPath = Get.arguments["videoPath"];
    songId = Get.arguments["songId"] ?? "";
    onLoadVideo();
    Utils.showLog("Selected Song Id => $songId");
    super.onInit();
  }

  @override
  void onClose() {
    trimmer.dispose();
    super.onClose();
  }

  Future<void> onLoadVideo() async {
    try {
      isLoading = true;
      update(["onLoadVideo"]);
      await trimmer.loadVideo(videoFile: File(videoPath));
      isLoading = false;
      update(["onLoadVideo"]);
    } catch (e) {
      Utils.showLog("Load Video Failed => $e");
    }
  }

  void onClickSave() async {
    Get.dialog(LoadingUi(), barrierDismissible: false);
    try {
      await trimmer.saveTrimmedVideo(
        startValue: startValue,
        endValue: endValue,
        onSave: (String? outputPath) async {
          saveVideoPath = outputPath ?? "";
          Get.back();
          Utils.showLog("Trim Video Path => $saveVideoPath");

          if (saveVideoPath != "") {
            final videoTime = await CustomVideoTime.onGet(saveVideoPath);
            final videoImage = await CustomThumbnail.onGet(saveVideoPath);

            if (videoTime != null && videoImage != null) {
              Utils.showLog("Video Path => ${saveVideoPath}");
              Utils.showLog("Video Image => ${videoImage}");
              Utils.showLog("Video Time => ${videoTime}");

              Get.offAndToNamed(
                AppRoutes.previewTrimVideoPage,
                arguments: {
                  "video": saveVideoPath,
                  "image": videoImage,
                  "time": videoTime,
                  "songId": songId,
                },
              );
            } else {
              Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
            }
          } else {
            Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
          }
        },
      );
    } catch (e) {
      Get.back();
      Utils.showLog("Trim Video Saving Failed => $e");
    }
  }

  void onToggleIcon() {
    isShowIcon = !isShowIcon;
    update(["onToggleIcon"]);
  }

  void onChangeStart(double value) {
    startValue = value;
    update(["onChangePosition"]);
  }

  void onChangeEnd(double value) {
    endValue = value;
    update(["onChangePosition"]);
  }

  void onChangePlaybackState(bool value) {
    isPlaying = value;
    update(["onChangePosition"]);
  }

  void onTogglePlayButton() async {
    isPlaying = await trimmer.videoPlaybackControl(startValue: startValue, endValue: endValue);
    update(["onChangePosition"]);
  }
}
