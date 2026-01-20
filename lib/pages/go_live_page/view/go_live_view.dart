import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/ui/circle_icon_button_ui.dart';

import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/go_live_page/controller/go_live_controller.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';

import '../../../utils/request.dart';

class GoLiveView extends StatelessWidget {
  const GoLiveView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 300),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      },
    );
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColor.black,
        child: Stack(
          children: [
              GetBuilder<GoLiveController>(
                  id: "onInitializeCamera",
                  builder: (controller) {
                    if (controller.cameraController != null &&
                        (controller.cameraController?.value.isInitialized ?? false)) {
                      final mediaSize = MediaQuery.of(context).size;
                      final scale = 1 / (controller.cameraController!.value.aspectRatio * mediaSize.aspectRatio);
                      log("mediaSize.aspectRatio:::::::${mediaSize.aspectRatio}");
                      log("controller.cameraController!.value.aspectRatio:::::::${controller.cameraController!.value.aspectRatio}");
                      log("mediaSize:::::::$mediaSize");
                      log("scale:::::::$scale");
                      return ClipRect(
                        clipper: _MediaSizeClipper(mediaSize),
                        child: Transform.scale(
                          scale: scale,
                          alignment: Alignment.topCenter,
                          child: CameraPreview(controller.cameraController!),
                        ),
                      );
                    } else {
                      return const LoadingUi();
                    }
                  }),
            Positioned(
              bottom: 0,
              child: Container(
                height: 150,
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
              top: 50,
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        color: AppColor.white.withOpacity(0.1),
                        icon: AppAsset.icClose,
                        iconColor: AppColor.white,
                        callback: () => Get.back(),
                      ),
                      20.height,
                      GetBuilder<GoLiveController>(
                        id: "onSwitchFlash",
                        builder: (controller) => CircleIconButtonUi(
                          circleSize: 40,
                          iconSize: 20,
                          gradient: AppColor.primaryLinearGradient,
                          icon: controller.isFlashOn ? AppAsset.icFlashOn : AppAsset.icFlashOff,
                          iconColor: AppColor.white,
                          callback: controller.onSwitchFlash,
                        ),
                      ),
                      20.height,
                      GetBuilder<GoLiveController>(
                        builder: (controller) => CircleIconButtonUi(
                          circleSize: 40,
                          iconSize: 20,
                          gradient: AppColor.primaryLinearGradient,
                          icon: AppAsset.icRotateCamera,
                          iconColor: AppColor.white,
                          callback: controller.onSwitchCamera,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                  child: GetBuilder<GoLiveController>(
                    builder: (controller) => AppButtonUi(
                      fontSize: 18,
                      gradient: AppColor.primaryLinearGradient,
                      title: EnumLocal.txtGoLive.name.tr,
                      callback: () {
                        AppRequest.requestLiveStreamingPermissions(onGranted: () {
                          controller.onClickGoLive();
                        });
                      },

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
