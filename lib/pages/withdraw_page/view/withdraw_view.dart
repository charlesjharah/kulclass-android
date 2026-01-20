import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/custom/custom_fetch_user_coin.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/splash_screen_page/api/admin_setting_api.dart';
import 'package:auralive/pages/withdraw_page/controller/withdraw_controller.dart';
import 'package:auralive/shimmer/withdraw_shimmer_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/pages/withdraw_page/widget/withdraw_widget.dart';

class WithdrawView extends GetView<WithdrawController> {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtWithdraw.name.tr),
      ),
      body: GetBuilder<WithdrawController>(
        id: "onGetWithdrawMethods",
        builder: (controller) => controller.isLoading
            ? WithdrawShimmerUi()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      15.height,
                      Container(
                        height: 148,
                        width: Get.width,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          gradient: AppColor.primaryLinearGradient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 148,
                              width: Get.width,
                              child: Image.asset(
                                AppAsset.icWithdrawBg,
                                fit: BoxFit.cover,
                                opacity: AlwaysStoppedAnimation(0.6),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: SizedBox(
                                height: 148,
                                width: Get.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          EnumLocal.txtAvailableCoin.name.tr,
                                          style: AppFontStyle.styleW600(AppColor.white, 16),
                                        ),
                                        Obx(
                                          () => Text(
                                            "\$${CustomFormatNumber.convert(CustomFetchUserCoin.coin.value)} (USD)",
                                            style: AppFontStyle.styleW700(AppColor.white, 30),
                                          ),
                                        ),
                                        5.height,
                                        Container(
                                          height: 32,
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                " Withdrawal is in USD",
                                                style: AppFontStyle.styleW700(AppColor.colorOrange, 13),
                                              ),
                                              8.width,


                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColor.white, width: 6),
                                      ),
                                      child: Image.asset(AppAsset.icWithdrawCoin, width: 85),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      15.height,
                      EnterCoinFieldUi(),
                      10.height,
                      Text(
                        EnumLocal.txtSelectPaymentGateway.name.tr,
                        style: AppFontStyle.styleW500(AppColor.coloGreyText, 14),
                      ),
                      5.height,
                      GetBuilder<WithdrawController>(
                        id: "onSwitchWithdrawMethod",
                        builder: (controller) => GestureDetector(
                          onTap: controller.onSwitchWithdrawMethod,
                          child: Container(
                            height: 54,
                            width: Get.width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: AppColor.colorBorder.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColor.colorBorder.withOpacity(0.6)),
                            ),
                            child: controller.selectedPaymentMethod == null
                                ? Row(
                                    children: [
                                      5.width,
                                      Text(
                                        EnumLocal.txtSelectPaymentGateway.name.tr,
                                        style: AppFontStyle.styleW700(AppColor.coloGreyText, 14),
                                      ),
                                      Spacer(),
                                      Image.asset(AppAsset.icArrowDown, width: 16),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        child: Center(
                                          child: PreviewNetworkImageUi(
                                              image: controller
                                                      .withdrawMethods[controller.selectedPaymentMethod ?? 0].image ??
                                                  ""),
                                        ),
                                      ),
                                      15.width,
                                      Text(
                                        controller.withdrawMethods[controller.selectedPaymentMethod ?? 0].name ?? "",
                                        style: AppFontStyle.styleW700(AppColor.black, 15),
                                      ),
                                      Spacer(),
                                      Image.asset(AppAsset.icArrowDown, width: 16),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      GetBuilder<WithdrawController>(
                        id: "onChangePaymentMethod",
                        builder: (controller) => AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          height: controller.isShowPaymentMethod ? (controller.withdrawMethods.length * 70) : 0,
                          color: AppColor.transparent,
                          curve: Curves.linearToEaseOut,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                15.height,
                                for (int index = 0; index < controller.withdrawMethods.length; index++)
                                  GestureDetector(
                                    onTap: () => controller.onChangePaymentMethod(index),
                                    child: Container(
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
                                        children: [
                                          SizedBox(
                                            width: 35,
                                            child: Center(
                                              child: PreviewNetworkImageUi(
                                                image: controller.withdrawMethods[index].image ?? "",
                                              ),
                                            ),
                                          ),
                                          15.width,
                                          Text(
                                            controller.withdrawMethods[index].name ?? "",
                                            style: AppFontStyle.styleW700(AppColor.black, 15),
                                          ),
                                          Spacer(),
                                          RadioItem(isSelected: controller.selectedPaymentMethod == index),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      15.height,
                      GetBuilder<WithdrawController>(
                        id: "onChangePaymentMethod",
                        builder: (controller) => controller.selectedPaymentMethod == null
                            ? Offstage()
                            : Column(
                                children: [
                                  for (int i = 0;
                                      i <
                                          controller
                                              .withdrawMethods[controller.selectedPaymentMethod ?? 0].details!.length;
                                      i++)
                                    WithdrawDetailsItemUi(
                                      title: controller
                                              .withdrawMethods[controller.selectedPaymentMethod ?? 0].details?[i] ??
                                          "",
                                      controller: controller.withdrawPaymentDetails[i],
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: GetBuilder<WithdrawController>(
        id: "onGetWithdrawMethods",
        builder: (controller) => Visibility(
          visible: controller.isLoading == false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: AppButtonUi(
              height: 56,
              color: AppColor.primary,
              title: EnumLocal.txtWithdraw.name.tr,
              gradient: AppColor.primaryLinearGradient,
              iconSize: 24,
              fontSize: 18,
              callback: controller.onClickWithdraw,
            ),
          ),
        ),
      ),
    );
  }
}
