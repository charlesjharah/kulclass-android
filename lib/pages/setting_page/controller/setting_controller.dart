import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:auralive/custom/custom_share.dart';
import 'package:auralive/main.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/pages/setting_page/api/delete_user_api.dart';
import 'package:auralive/pages/setting_page/model/delete_user_model.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/branch_io_services.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';

class SettingController extends GetxController {
  bool isShowNotification = false;

  ScreenshotController screenshotController = ScreenshotController();

  DeleteUserModel? deleteUserModel;

  @override
  void onInit() {
    isShowNotification = Database.isShowNotification;
    super.onInit();
  }

  Future<void> onSwitchNotification() async {
    isShowNotification = !isShowNotification;
    Database.onSetNotification(isShowNotification);
    update(["onSwitchNotification"]);
  }

  Future<void> onDeleteAccount() async {
    Get.back(); // Close Dialog...

    Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...

    deleteUserModel = await DeleteUserApi.callApi(loginUserId: Database.loginUserId);

    Get.back(); // Stop Loading...

    if (deleteUserModel?.status ?? false) {
      Database.onLogOut();
    }
  }

  Future<String?> onCaptureImage() async {
    try {
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final String filePath = '$directory/$fileName.png';

      final image = await screenshotController.capture();
      if (image != null) {
        final file = File(filePath);
        await file.writeAsBytes(image);

        Utils.showLog("Capture Screen Shorts => $filePath");

        return filePath;
      } else {
        Utils.showLog("Capture Screen Shorts Failed => No image captured");
      }
    } catch (e) {
      Utils.showLog("Capture Screen Shorts Failed => $e");
    }

    return null;
  }

  Future<void> onClickShareProfile() async {
    Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...
    final filePath = await onCaptureImage();

    await BranchIoServices.onCreateBranchIoLink(
      id: Database.fetchLoginUserProfileModel?.user?.id ?? "",
      name: Database.fetchLoginUserProfileModel?.user?.name ?? "",
      userId: Database.fetchLoginUserProfileModel?.user?.id ?? "",
      image: Database.fetchLoginUserProfileModel?.user?.image ?? "",
      pageRoutes: "Profile",
    );
    final link = await BranchIoServices.onGenerateLink();

    if (link != null && filePath != null) {
      CustomShare.onShareFile(title: link, filePath: filePath);
    }

    Get.back(); // Stop Loading...
  }

  Widget profileImage() {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        width: Get.width,
        height: 350,
        margin: EdgeInsets.symmetric(horizontal: Get.width / 7),
        decoration: BoxDecoration(
          gradient: AppColor.primaryLinearGradient,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Column(
          children: [
            40.height,
            QrImageView(
              data: "${Database.loginUserId},${true}",
              version: QrVersions.auto,
              size: 140.0,
              eyeStyle: QrEyeStyle(color: AppColor.white, eyeShape: QrEyeShape.square),
              dataModuleStyle: QrDataModuleStyle(color: AppColor.white, dataModuleShape: QrDataModuleShape.square),
            ),
            12.height,
            Divider(
              indent: 30,
              endIndent: 30,
              thickness: 0.5,
              color: AppColor.white.withOpacity(0.5),
            ),
            Container(
              padding: EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.white, width: 1),
              ),
              child: Container(
                width: 60,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(AppAsset.icProfilePlaceHolder),
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: PreviewNetworkImageUi(image: Database.fetchLoginUserProfileModel?.user?.image ?? ""),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Database.fetchLoginUserProfileModel?.user?.name ?? "",
                  style: AppFontStyle.styleW700(AppColor.white, 18),
                ),
                Visibility(
                  visible: Database.fetchLoginUserProfileModel?.user?.isVerified ?? false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Image.asset(AppAsset.icBlueTick, width: 20),
                  ),
                ),
              ],
            ),
            Text(
              Database.fetchLoginUserProfileModel?.user?.userName ?? "",
              style: AppFontStyle.styleW400(AppColor.white, 13),
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
