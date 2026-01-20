import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/verification_otp_page/controller/verification_otp_controller.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/constant.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class VerificationOtpView extends GetView<VerificationOtpController> {
  const VerificationOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          shadowColor: AppColor.black.withOpacity(0.4),
          surfaceTintColor: AppColor.white,
          flexibleSpace: SimpleAppBarUi(title: ""),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.transparent,
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    EnumLocal.txtEnterVerificationCode.name.tr,
                    textAlign: TextAlign.start,
                    style: AppFontStyle.styleW900(AppColor.black, 36),
                  ),
                  5.height,
                  Text(
                    EnumLocal.txtEnterVerificationCodeAsUnder.name.tr,
                    textAlign: TextAlign.start,
                    style: AppFontStyle.styleW400(AppColor.coloGreyText, 16),
                  ),
                  15.height,
                  SizedBox(
                    width: Get.width,
                    child: Text(
                      "${controller.phoneNumber} ${EnumLocal.txtSendCodeThisNumber.name.tr}",
                      textAlign: TextAlign.start,
                      style: AppFontStyle.styleW500(AppColor.black, 15),
                    ),
                  ),
                  35.height,
                  OtpTextField(
                    numberOfFields: 6,
                    fillColor: AppColor.transparent,
                    borderRadius: BorderRadius.circular(8),
                    fieldWidth: 45,
                    cursorColor: AppColor.primary,
                    focusedBorderColor: AppColor.primary,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      if (code.isEmpty) {
                        controller.otpController.clear();
                      }
                    },
                    onSubmit: (String otpCode) => controller.otpController.text = otpCode,
                  ),
                  20.height,
                  GetBuilder<VerificationOtpController>(
                    id: "onCountTime",
                    builder: (controller) => GestureDetector(
                      onTap: controller.otpCountTime == 30 ? controller.onResendCode : null,
                      child: Text(
                        controller.otpCountTime == 30 ? EnumLocal.txtResendCode.name.tr : "00:${controller.otpCountTime}",
                        textAlign: TextAlign.start,
                        style: controller.otpCountTime == 30
                            ? TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.colorRedContainer,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.colorRedContainer,
                                fontFamily: AppConstant.appFontMedium,
                              )
                            : TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                                decorationColor: AppColor.colorRedContainer,
                                fontFamily: AppConstant.appFontMedium,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 86,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: controller.onClickSubmit,
            child: Container(
              height: 56,
              width: Get.width / 1.5,
              margin: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: AppColor.primaryLinearGradient,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                EnumLocal.txtSubmit.name.tr,
                style: AppFontStyle.styleW600(AppColor.white, 19),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
