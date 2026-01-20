import 'package:flutter/material.dart';
import 'package:auralive/pages/splash_screen_page/api/admin_setting_api.dart';
import 'package:auralive/utils/color.dart';
import 'package:get/get.dart';
import 'package:auralive/custom/custom_capitalize_first_letter.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/withdraw_page/controller/withdraw_controller.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class RadioItem extends StatelessWidget {
  const RadioItem({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColor.transparent,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? null : AppColor.transparent,
              gradient: isSelected ? AppColor.primaryLinearGradient : null,
            ),
            child: Container(
              height: 18,
              width: 18,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? null : AppColor.colorGreyBg,
                border: Border.all(
                  color: isSelected ? AppColor.white : AppColor.primary.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WithdrawDetailsItemUi extends StatelessWidget {
  const WithdrawDetailsItemUi({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CustomCapitalizeFirstLetter.convert(title),
          style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
        ),
        5.height,
        Container(
          height: 54,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: AppColor.colorBorder.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.colorBorder.withOpacity(0.6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  controller: controller,
                  style: AppFontStyle.styleW700(AppColor.black, 14),
                  cursorColor: AppColor.colorTextGrey,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your ${title.toLowerCase()}...",
                    hintStyle: AppFontStyle.styleW400(AppColor.colorTextGrey, 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EnterCoinFieldUi extends GetView<WithdrawController> {
  const EnterCoinFieldUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocal.txtEnterCoin.name.tr,
          style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
        ),
        5.height,
        Container(
          height: 54,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColor.colorBorder.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.colorBorder.withOpacity(0.6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 54,
                width: 60,
                decoration: BoxDecoration(
                  gradient: AppColor.primaryLinearGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
                child: Center(child: Image.asset(AppAsset.icWithdrawCoin, width: 25)),
              ),
              15.width,
              Expanded(
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  controller: controller.coinController,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                  cursorColor: AppColor.colorTextGrey,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: EnumLocal.txtEnterWithdrawCoin.name.tr,
                    hintStyle: AppFontStyle.styleW400(AppColor.colorTextGrey, 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        2.height,
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${EnumLocal.txtMinimumWithdraw.name.tr} ${AdminSettingsApi.adminSettingModel?.data?.minWithdrawalRequestedCoin ?? 0} Coin",
            style: AppFontStyle.styleW600(AppColor.colorRedContainer, 11.5),
          ),
        ),
      ],
    );
  }
}
