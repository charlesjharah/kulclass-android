import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/custom/custom_icon_button.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/trim_video_page/controller/trim_video_controller.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimVideoView extends GetView<TrimVideoController> {
  const TrimVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 300),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: AppColor.black,
      body: GestureDetector(
        onTap: controller.onToggleIcon,
        child: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GetBuilder<TrimVideoController>(
                id: "onLoadVideo",
                builder: (controller) => controller.isLoading
                    ? LoadingUi()
                    : SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            height: controller.trimmer.videoPlayerController?.value.size.height ?? 0,
                            width: controller.trimmer.videoPlayerController?.value.size.width ?? 0,
                            child: VideoViewer(
                              trimmer: controller.trimmer,
                              padding: EdgeInsets.zero,
                              borderWidth: 0,
                            ),
                          ),
                        ),
                      ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: 200,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.black.withOpacity(0.7), AppColor.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 200,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.transparent, AppColor.black.withOpacity(0.7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                child: SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        CustomIconButton(
                          icon: AppAsset.icBack,
                          iconColor: AppColor.white,
                          callback: () {
                            Get.back();
                          },
                        ),
                        15.width,
                        Text(
                          "Trim Video",
                          style: AppFontStyle.styleW700(AppColor.white, 20),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: controller.onClickSave,
                          child: Container(
                            height: 40,
                            width: 85,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: AppColor.primaryLinearGradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Save",
                              style: AppFontStyle.styleW700(AppColor.white, 15.5),
                            ),
                          ),
                        ),
                        5.width,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: TrimViewer(
                  trimmer: controller.trimmer,
                  viewerHeight: 60.0,
                  viewerWidth: MediaQuery.of(context).size.width,
                  onChangeStart: controller.onChangeStart,
                  onChangeEnd: controller.onChangeEnd,
                  onChangePlaybackState: controller.onChangePlaybackState,
                ),
              ),
              GetBuilder<TrimVideoController>(
                id: "onToggleIcon",
                builder: (controller) => Visibility(
                  visible: controller.isShowIcon,
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: controller.onTogglePlayButton,
                      child: GetBuilder<TrimVideoController>(
                        id: "onChangePosition",
                        builder: (controller) => Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.only(left: controller.isPlaying ? 0 : 2),
                          decoration: BoxDecoration(color: AppColor.black.withOpacity(0.2), shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(
                              controller.isPlaying ? AppAsset.icPause : AppAsset.icPlay,
                              width: 30,
                              height: 30,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
