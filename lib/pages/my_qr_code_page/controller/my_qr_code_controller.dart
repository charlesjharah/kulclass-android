import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:auralive/custom/custom_share.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/branch_io_services.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MyQrCodeController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();

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

  Future<void> onClickDownload() async {
    Get.dialog(LoadingUi(), barrierDismissible: false); // Show Loading...
    try {
      final filePath = await onCaptureImage();
      if (filePath != null) {
        await GallerySaver.saveImage(filePath);
        Utils.showToast(EnumLocal.txtDownloadSuccess.name.tr);
      }
    } catch (e) {
      Utils.showLog("Download Screen Shorts Failed => $e");
    }
    Get.back(); // Stop Loading...
  }

  Future<void> onClickWhatsapp() async {
    Get.dialog(LoadingUi(), barrierDismissible: false); // Show Loading...
    try {
      await BranchIoServices.onCreateBranchIoLink(
        id: Database.fetchLoginUserProfileModel?.user?.id ?? "",
        name: Database.fetchLoginUserProfileModel?.user?.name ?? "",
        userId: Database.fetchLoginUserProfileModel?.user?.id ?? "",
        image: Database.fetchLoginUserProfileModel?.user?.image ?? "",
        pageRoutes: "Profile",
      );
      final link = await BranchIoServices.onGenerateLink();
      if (link != null) {
        final Uri _url = Uri.parse('https://wa.me/?text=${link}');
        await launchUrl(_url);
      }
    } catch (e) {
      Utils.showLog("Launch Url Failed => $e");
    }
    Get.back(); // Stop Loading...
  }

  Future<void> onClickCopy() async {
    try {
      await BranchIoServices.onCreateBranchIoLink(
        id: Database.fetchLoginUserProfileModel?.user?.id ?? "",
        name: Database.fetchLoginUserProfileModel?.user?.name ?? "",
        userId: Database.fetchLoginUserProfileModel?.user?.id ?? "",
        image: Database.fetchLoginUserProfileModel?.user?.image ?? "",
        pageRoutes: "Profile",
      );
      final link = await BranchIoServices.onGenerateLink();
      if (link != null) {
        Clipboard.setData(ClipboardData(text: link));
        Utils.showToast("Copied on clipboard");
      }
    } catch (e) {
      Utils.showToast("Copy Text Failed => $e");
    }
  }

  Future<void> onClickShare() async {
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
}
