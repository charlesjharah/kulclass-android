import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/help_page/controller/help_controller.dart';
import 'package:auralive/pages/help_page/widget/help_widget.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          shadowColor: AppColor.black.withValues(alpha: 0.4),
          flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtHelp.name.tr),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HelpTextFieldUi(
                height: 250,
                maxLines: 10,
                title: EnumLocal.txtComplaintOrSuggestion.name.tr,
                keyboardType: TextInputType.text,
                controller: controller.complaintController,
              ),
              15.height,
              HelpTextFieldUi(
                maxLines: 1,
                title: EnumLocal.txtContact.name.tr,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                controller: controller.contactController,
              ),
              30.height,
              RichText(
                text: TextSpan(
                  text: EnumLocal.txtAttachYourImageOrScreenshot.name.tr,
                  style: AppFontStyle.styleW500(AppColor.coloGreyText, 15),
                  children: [
                    TextSpan(
                      text: " ${EnumLocal.txtOptionalInBrackets.name.tr}",
                      style: AppFontStyle.styleW400(AppColor.coloGreyText, 12),
                    ),
                  ],
                ),
              ),
              15.height,
              GestureDetector(
                onTap: () => controller.onPickImage(context),
                child: GradiantBorderContainer(
                  height: 40,
                  width: 130,
                  radius: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAsset.icLink, width: 24),
                      10.width,
                      Container(
                        width: 1.5,
                        height: 25,
                        decoration: BoxDecoration(
                          color: AppColor.colorUnselectedIcon.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      10.width,
                      Text(
                        EnumLocal.txtBrowse.name.tr,
                        style: AppFontStyle.styleW700(AppColor.black, 16),
                      ),
                    ],
                  ),
                ),
              ),
              20.height,
              GetBuilder<HelpController>(
                id: "onPickImage",
                builder: (controller) => Visibility(
                  visible: controller.pickImage != null,
                  child: SizedBox(
                    width: 150,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.file(File(controller.pickImage ?? ""), fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: -8,
                          right: -8,
                          child: GestureDetector(
                            onTap: controller.onCancelImage,
                            child: Container(
                              height: 60,
                              width: 60,
                              color: AppColor.transparent,
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 28,
                                width: 28,
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButtonUi(
          height: 56,
          title: EnumLocal.txtSubmit.name.tr,
          gradient: AppColor.primaryLinearGradient,
          callback: controller.onSendComplaint,
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
        // padding: const EdgeInsets.all(1.3),
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
