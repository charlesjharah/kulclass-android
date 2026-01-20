import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/pages/edit_profile_page/controller/edit_profile_controller.dart';
import 'package:auralive/utils/utils.dart';

class EditProfileFieldUi extends StatelessWidget {
  const EditProfileFieldUi({
    super.key,
    required this.title,
    required this.maxLines,
    required this.controller,
    required this.keyboardType,
    this.suffixIcon,
    this.height,
    required this.enabled,
    required this.contentPadding,
    this.isOptional,
  });

  final String title;
  final int? maxLines;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool enabled;
  final double? height;
  final bool? isOptional;
  final Widget? suffixIcon;
  final double contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (isOptional ?? false)
            ? RichText(
                text: TextSpan(
                  text: title,
                  style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
                  children: [
                    TextSpan(
                      text: " ${EnumLocal.txtOptionalInBrackets.name.tr}",
                      style: AppFontStyle.styleW400(AppColor.coloGreyText, 12),
                    ),
                  ],
                ),
              )
            : Text(
                title,
                style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
              ),
        5.height,
        Container(
          height: height ?? 55,
          width: Get.width,
          padding: const EdgeInsets.only(left: 15),
          // alignment: height == null ? Alignment.center : null,

          decoration: BoxDecoration(
            color: AppColor.colorBorder.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
          ),
          child: TextFormField(
            enabled: enabled,
            keyboardType: keyboardType,
            controller: controller,
            maxLines: maxLines ?? 1,
            cursorColor: AppColor.colorTextGrey,
            style: AppFontStyle.styleW600(AppColor.black, 15),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.only(top: contentPadding),
              hintStyle: AppFontStyle.styleW500(AppColor.coloGreyText, 15),
            ),
          ),
        ),
      ],
    );
  }
}

class UserNameFieldUi extends StatelessWidget {
  const UserNameFieldUi({
    super.key,
    this.title,
    this.titleWidget, // New optional widget
    required this.maxLines,
    required this.controller,
    required this.keyboardType,
    this.suffixIcon,
    this.height,
    required this.enabled,
    required this.contentPadding,
    this.isOptional,
    required this.onChange,
  });

  final String? title;
  final Widget? titleWidget; // optional widget
  final int? maxLines;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool enabled;
  final double? height;
  final bool? isOptional;
  final Widget? suffixIcon;
  final double contentPadding;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Use titleWidget if provided, else fallback to title
        if (titleWidget != null)
          titleWidget!
        else if (isOptional ?? false)
          RichText(
            text: TextSpan(
              text: title ?? '',
              style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
              children: [
                TextSpan(
                  text: " ${EnumLocal.txtOptionalInBrackets.name.tr}",
                  style: AppFontStyle.styleW400(AppColor.coloGreyText, 12),
                ),
              ],
            ),
          )
        else
          Text(
            title ?? '',
            style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
          ),
        5.height,
        Container(
          height: height ?? 55,
          width: Get.width,
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: AppColor.colorBorder.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
          ),
          child: TextFormField(
            enabled: enabled,
            keyboardType: keyboardType,
            controller: controller,
            maxLines: maxLines ?? 1,
            cursorColor: AppColor.colorTextGrey,
            style: AppFontStyle.styleW600(AppColor.black, 15),
            onChanged: onChange,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.only(top: contentPadding),
              hintStyle: AppFontStyle.styleW500(AppColor.coloGreyText, 15),
            ),
          ),
        ),
      ],
    );
  }
}


class RadioItem extends StatelessWidget {
  const RadioItem({super.key, required this.isSelected, required this.title, required this.callback});

  final bool isSelected;
  final String title;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: AppColor.transparent,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? null : AppColor.colorBorder.withOpacity(0.2),
                gradient: isSelected ? AppColor.primaryLinearGradient : null,
              ),
              child: Container(
                height: 25,
                width: 25,
                margin: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? null : AppColor.colorGreyBg,
                  border: Border.all(color: isSelected ? AppColor.white : AppColor.primary.withOpacity(0.3), width: 1.5),
                ),
              ),
            ),
            12.width,
            Text(
              title,
              style: AppFontStyle.styleW600(AppColor.black, 15),
            ),
          ],
        ),
      ),
    );
  }
}

class CountyField extends StatelessWidget {
  const CountyField({super.key, required this.flag, required this.title, required this.country});

  final String title;
  final String flag;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
        ),
        5.height,
        GetBuilder<EditProfileController>(
          id: "onChangeCountry",
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                controller.onChangeCountry(context);
              },
              child: Container(
                height: 55,
                width: Get.width,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: AppColor.colorBorder.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
                ),
                child: Row(
                  children: [
                    Text(
                      Utils.flagController.text,
                      style: AppFontStyle.styleW500(AppColor.coloGreyText, 20),
                    ),
                    10.width,
                    Text(
                      Utils.countryController.text,
                      style: AppFontStyle.styleW600(AppColor.black, 15),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(AppAsset.icArrowDown, height: 14, width: 14),
                    ),
                    10.width,
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CustomCountryPicker {
  static void pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: AppColor.white,
        textStyle: AppFontStyle.styleW500(AppColor.black, 15),
        bottomSheetHeight: Get.height / 1.5,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          labelText: EnumLocal.txtSearch.name.tr,
          hintText: EnumLocal.txtTypeSomething.name.tr,
          prefixIcon: const Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: AppColor.grey_400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: AppColor.grey_400),
          ),
        ),
      ),
      onSelect: (Country country) {
        Utils.countryController = TextEditingController(text: country.name);
        Utils.flagController = TextEditingController(text: country.flagEmoji);
      },
    );
  }
}
