import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/edit_profile_page/controller/edit_profile_controller.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/pages/edit_profile_page/widget/edit_profile_widget.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtEditProfile.name.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.height,
              GestureDetector(
                onTap: () async => await controller.onPickImage(context),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColor.primaryLinearGradient,
                    ),
                    child: Container(
                      height: 124,
                      width: 124,
                      margin: const EdgeInsets.all(2),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.white,
                        border: Border.all(color: AppColor.white, width: 1.5),
                      ),
                      child: Stack(
                        children: [
                          GetBuilder<EditProfileController>(
                            id: "onPickImage",
                            builder: (controller) => Container(
                              height: 125,
                              width: 125,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.white,
                              ),
                              child: controller.pickImage == null
                                  ? controller.profileImage != ""
                                      ? Stack(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: Image.asset(AppAsset.icProfilePlaceHolder),
                                            ),
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: PreviewNetworkImageUi(
                                                image: controller.profileImage,
                                              ),
                                            ),
                                            Visibility(
                                              visible: controller.isBanned,
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(shape: BoxShape.circle),
                                                child: BlurryContainer(
                                                  height: 124,
                                                  width: 124,
                                                  blur: 3,
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: AppColor.black.withOpacity(0.3),
                                                  child: Offstage(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Image.asset(AppAsset.icProfilePlaceHolder, fit: BoxFit.cover)
                                  : Image.file(File(controller.pickImage!), fit: BoxFit.cover),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 36,
                              width: 36,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColor.colorBorder, width: 1.5),
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(AppAsset.icCameraGradiant),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              40.height,
              EditProfileFieldUi(
                enabled: true,
                title: EnumLocal.txtFullName.name.tr,
                maxLines: 1,
                keyboardType: TextInputType.name,
                controller: controller.fullNameController,
                contentPadding: 15,
                suffixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
                    child: Image.asset(AppAsset.icEditPen, height: 20, width: 20),
                  ),
                ),
              ),
              15.height,
              UserNameFieldUi(
                enabled: true,
                contentPadding: 15,
                keyboardType: TextInputType.name,
                controller: controller.userNameController,
                title: EnumLocal.txtUserName.name.tr,
                maxLines: 1,
                onChange: (p0) => controller.onChangeUserName(),
                suffixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Obx(
                        () => Center(
                      child: controller.isCheckingUserName.value
                          ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: CircularProgressIndicator(color: AppColor.primary, strokeWidth: 3),
                      )
                          : controller.isValidUserName == null
                          ? Image.asset(AppAsset.icEditPen, height: 20, width: 20)
                          : controller.isValidUserName == true
                          ? Icon(
                        Icons.done_all,
                        color: AppColor.colorClosedGreen,
                      )
                          : Image.asset(AppAsset.icClose, color: Colors.red, height: 20, width: 20),
                    ),
                  ),
                ),
              ),
              15.height,
              Obx(
                    () => UserNameFieldUi(
                  enabled: true,
                  contentPadding: 15,
                  keyboardType: TextInputType.number,
                  controller: controller.subController,
                  maxLines: 1,
                  onChange: (p0) => controller.onChangeSub(),
                  titleWidget: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${EnumLocal.txtSubscriptionFee.name.tr} ",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        TextSpan(
                          text: "(${controller.subscriptionTitle.value})",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Obx(
                          () => Center(
                        child: controller.isCheckingSub.value
                            ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: CircularProgressIndicator(
                            color: AppColor.primary,
                            strokeWidth: 3,
                          ),
                        )
                            : controller.isValidSub == null
                            ? Image.asset(AppAsset.icEditPen, height: 20, width: 20)
                            : controller.isValidSub == true
                            ? Icon(
                          Icons.done_all,
                          color: AppColor.colorClosedGreen,
                        )
                            : Image.asset(
                          AppAsset.icClose,
                          color: Colors.red,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),



              15.height,
              EditProfileFieldUi(
                enabled: false,
                contentPadding: 5,
                keyboardType: TextInputType.number,
                controller: controller.idCodeController,
                title: EnumLocal.txtIdentificationCode.name.tr,
                maxLines: 1,
              ),
              15.height,
              CountyField(
                title: EnumLocal.txtCountry.name.tr,
                flag: "",
                country: "",
              ),
              15.height,
              EditProfileFieldUi(
                enabled: true,
                contentPadding: 10,
                keyboardType: TextInputType.text,
                controller: controller.bioDetailsController,
                title: EnumLocal.txtBioDetails.name.tr,
                height: 100,
                isOptional: true,
                maxLines: 3,
              ),
              15.height,
              Text(
                EnumLocal.txtGender.name.tr,
                style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
              ),
              5.height,
              GetBuilder<EditProfileController>(
                id: "onChangeGender",
                builder: (logic) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RadioItem(
                      isSelected: logic.selectedGender == "male",
                      title: EnumLocal.txtMale.name.tr,
                      callback: () => logic.onChangeGender("male"),
                    ),
                    RadioItem(
                      isSelected: logic.selectedGender == "female",
                      title: EnumLocal.txtFemale.name.tr,
                      callback: () => logic.onChangeGender("female"),
                    ),
                    RadioItem(
                      isSelected: logic.selectedGender == "other",
                      title: EnumLocal.txtOther.name.tr,
                      callback: () => logic.onChangeGender("other"),
                    ),
                  ],
                ),
              ),
              15.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: AppButtonUi(
          height: 56,
          color: AppColor.primary,
          title: EnumLocal.txtSaveProfile.name.tr,
          gradient: AppColor.primaryLinearGradient,
          fontSize: 18,
          callback: controller.onSaveProfile,
        ),
      ),
    );
  }
}
