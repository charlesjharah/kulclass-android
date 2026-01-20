import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/my_qr_code_page/controller/my_qr_code_controller.dart';
import 'package:auralive/pages/my_qr_code_page/widget/my_qr_code_widget.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/asset.dart';

import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class MyQrCodeView extends GetView<MyQrCodeController> {
  const MyQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtMyQRCode.name.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.height,
              Screenshot(
                controller: controller.screenshotController,
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 11),
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
                              Visibility(
                                visible: Database.fetchLoginUserProfileModel?.user?.isProfileImageBanned ?? false,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: BlurryContainer(
                                      blur: 3,
                                      borderRadius: BorderRadius.zero,
                                      color: AppColor.black.withOpacity(0.3),
                                      child: Offstage(),
                                    ),
                                  ),
                                ),
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
              ),
              30.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QrCodeItemUi(
                    icon: AppAsset.icDownload,
                    callback: () async => controller.onClickDownload(),
                  ),
                  QrCodeItemUi(
                    icon: AppAsset.icWhatsapp,
                    callback: () async => controller.onClickWhatsapp(),
                  ),
                  QrCodeItemUi(
                    icon: AppAsset.icCopy,
                    callback: () async => controller.onClickCopy(),
                  ),
                  QrCodeItemUi(
                    icon: AppAsset.icMore,
                    callback: () async => controller.onClickShare(),
                  ),
                ],
              ),
              30.height,
              Center(
                child: Text(
                  EnumLocal.txtScanQRCode.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 22),
                ),
              ),
              10.height,
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  EnumLocal.txtMyQRCodeText.name.tr,
                  style: AppFontStyle.styleW400(AppColor.colorGreyHasTagText, 12),
                ),
              ),
              50.height,
            ],
          ),
        ),
      ),
    );
  }
}
