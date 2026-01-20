import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/mobile_num_login_page/controller/mobile_num_login_controller.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class MobileNumLoginView extends GetView<MobileNumLoginController> {
  const MobileNumLoginView({super.key});

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
                    EnumLocal.EnterMobileNumber.name.tr,
                    textAlign: TextAlign.start,
                    style: AppFontStyle.styleW900(AppColor.black, 36),
                  ),
                  Text(
                    EnumLocal.txtEnterYourMobileNumberHereAndContinue.name.tr,
                    textAlign: TextAlign.start,
                    style: AppFontStyle.styleW400(AppColor.coloGreyText, 16),
                  ),
                  25.height,
                  MobileLoginFieldUi(
                    hintText: EnumLocal.txtMobileNumHintTest.name.tr,
                    controller: controller.mobileController,
                  )
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
            onTap: controller.onVerify,
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
                EnumLocal.txtVerify.name.tr,
                style: AppFontStyle.styleW600(AppColor.white, 19),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileLoginFieldUi extends StatelessWidget {
  const MobileLoginFieldUi({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final mobileNumLoginController = Get.find<MobileNumLoginController>();
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.colorBorder.withOpacity(0.2),
        border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
      ),
      child: IntlPhoneField(
        flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 5),
        dropdownIconPosition: IconPosition.trailing,
        showCountryFlag: true,
        showDropdownIcon: true,
        controller: controller,
        onCountryChanged: (value) {
          mobileNumLoginController.countryCode = value.dialCode;
        },
        style: AppFontStyle.styleW600(AppColor.black, 15),
        dropdownTextStyle: AppFontStyle.styleW600(AppColor.black, 15),
        dropdownDecoration: BoxDecoration(),
        pickerDialogStyle: PickerDialogStyle(
          searchFieldPadding: EdgeInsets.all(10),
          searchFieldInputDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 40),
            hintText: "Search",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.black),
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColor.black.withOpacity(0.6),
            ),
          ),
        ),
        decoration: InputDecoration(
          hintText: EnumLocal.txtMobileNumHintTest.name.tr,
          hintStyle: AppFontStyle.styleW500(AppColor.coloGreyText, 15),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          counterText: "",
          border: InputBorder.none,
        ),
        autovalidateMode: AutovalidateMode.disabled,
        initialCountryCode: 'IN',
        validator: (p0) => null,
      ),
    );
  }
}
