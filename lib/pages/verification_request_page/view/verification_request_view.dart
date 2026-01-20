import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/verification_request_page/controller/verification_request_controller.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/asset.dart';

import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/pages/verification_request_page/widget/verification_request_widget.dart';

class VerificationRequestView extends StatelessWidget {
  const VerificationRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationRequestController());
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtVerificationRequest.name.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.height,
              Row(
                children: [
                  Expanded(
                    child: GetBuilder<VerificationRequestController>(
                      id: "onChangeProfileImage",
                      builder: (controller) => GradiantBorderContainer(
                        height: 210,
                        radius: 20,
                        child: controller.profileImage != null
                            ? Container(
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                          child: Stack(
                            children: [
                              Image.file(
                                File(controller.profileImage ?? ""),
                                height: 210,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                right: 6,
                                child: GestureDetector(
                                  onTap: controller.onCancelProfileImage,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    color: AppColor.transparent,
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.black,
                                        border: Border.all(color: AppColor.colorGreyBg, width: 2),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          AppAsset.icClose,
                                          color: AppColor.white,
                                          width: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                            : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(AppAsset.icYourImage, width: 72),
                              Column(
                                children: [
                                  Text(
                                    EnumLocal.txtUploadYourImages.name.tr,
                                    style: AppFontStyle.styleW500(AppColor.colorUnselectedIcon, 14),
                                  ),
                                  Text(
                                    "(${EnumLocal.txtPersonalPhotos.name.tr})",
                                    style: AppFontStyle.styleW500(AppColor.colorUnselectedIcon, 12),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 22),
                                child: AppButtonUi(
                                  height: 38,
                                  fontSize: 14,
                                  gradient: AppColor.primaryLinearGradient,
                                  title: EnumLocal.txtCapture.name.tr,
                                  callback: () => controller.onPickProfileImage(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  15.width,
                  Expanded(
                    child: GetBuilder<VerificationRequestController>(
                      id: "onChangeDocumentImage",
                      builder: (controller) => GradiantBorderContainer(
                        height: 210,
                        radius: 20,
                        child: controller.documentImage != null
                            ? Container(
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                          child: Stack(
                            children: [
                              Image.file(
                                File(controller.documentImage ?? ""),
                                height: 210,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                right: 6,
                                child: GestureDetector(
                                  onTap: controller.onCancelDocumentImage,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    color: AppColor.transparent,
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.black,
                                        border: Border.all(color: AppColor.colorGreyBg, width: 2),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          AppAsset.icClose,
                                          color: AppColor.white,
                                          width: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                            : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(AppAsset.icIdImage, width: 72),
                              Column(
                                children: [
                                  Text(
                                    EnumLocal.txtUploadIDPhotos.name.tr,
                                    style: AppFontStyle.styleW500(AppColor.colorUnselectedIcon, 14),
                                  ),
                                  Text(
                                    "(${EnumLocal.txtClearPhotos.name.tr})",
                                    style: AppFontStyle.styleW500(AppColor.colorUnselectedIcon, 12),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 22),
                                child: AppButtonUi(
                                  height: 38,
                                  fontSize: 14,
                                  gradient: AppColor.primaryLinearGradient,
                                  title: EnumLocal.txtAttach.name.tr,
                                  callback: () => controller.onPickDocumentImage(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              25.height,
              ProfileField(
                keyboardType: TextInputType.name,
                controller: controller.idController,
                title: EnumLocal.txtIDNumber.name.tr,
                hintText: "",
                contentTopPadding: 0,
              ),
              15.height,
              ProfileField(
                keyboardType: TextInputType.name,
                controller: controller.nameController,
                title: EnumLocal.txtNameOnID.name.tr,
                hintText: "",
                contentTopPadding: 0,
              ),
              15.height,
              ProfileField(
                keyboardType: TextInputType.emailAddress,
                controller: controller.addressController,
                height: 150,
                title: EnumLocal.txtFullAddress.name.tr,
                hintText: "",
                maxLines: 4,
                contentTopPadding: 2,
              ),
              25.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 7, vertical: 25),
        child: AppButtonUi(
          height: 56,
          fontSize: 18,
          gradient: AppColor.primaryLinearGradient,
          title: EnumLocal.txtSubmit.name.tr,
          callback: controller.onSendRequest,
        ),
      ),
    );
  }
}

class GradiantBorderContainer extends StatelessWidget {
  const GradiantBorderContainer({super.key, required this.height, this.width, required this.radius, this.child});

  final double height;
  final double? width;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColor.primaryLinearGradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: DottedBorder(
        // dashPattern: const [3, 6],
        // borderType: BorderType.RRect,
        // color: AppColor.colorScaffold,
        // radius: Radius.circular(radius),
        // padding: const EdgeInsets.all(1),
        // strokeWidth: 5,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColor.colorScaffold,
            borderRadius: BorderRadius.circular(radius - 1),
          ),
          child: child,
        ),
      ),
    );
  }
}
