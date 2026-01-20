import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/ui/gradient_text_ui.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/recharge_page/controller/recharge_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/shimmer/recharge_shimmer_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class RechargeView extends StatelessWidget {
  const RechargeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        elevation: 0.5,
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtRecharge.name.tr),
      ),
      body: GetBuilder<RechargeController>(
        id: "onChangeLoading",
        builder: (controller) => controller.isLoading
            ? RechargeShimmerUi()
            : NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      pinned: false,
                      floating: true,
                      backgroundColor: AppColor.transparent,
                      expandedHeight: controller.bannerCollection.isEmpty ? 195 : 365,
                      automaticallyImplyLeading: false,
                      surfaceTintColor: AppColor.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              15.height,
                              GradientTextUi(
                                EnumLocal.txtPurchasePremiumPlanAndGetAllAccess.name.tr,
                                maxLines: 2,
                                gradient: AppColor.primaryLinearGradient,
                                style: AppFontStyle.styleW900(AppColor.primary, 30),
                              ),
                              5.height,
                              Text(
                                EnumLocal.txtRechargePageSubTitle.name.tr,
                                maxLines: 3,
                                style: AppFontStyle.styleW400(AppColor.colorDarkGrey, 12),
                              ),
                              controller.bannerCollection.isEmpty
                                  ? Offstage()
                                  : Column(
                                      children: [
                                        15.height,
                                        Container(
                                          height: 160,
                                          width: Get.width,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: AppColor.black,
                                            borderRadius: BorderRadius.circular(26),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColor.colorTextGrey.withOpacity(0.3),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: GetBuilder<RechargeController>(
                                            id: "onChangeBanner",
                                            builder: (controller) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                PageView.builder(
                                                  controller: controller.pageController,
                                                  itemCount: controller.bannerCollection.length,
                                                  itemBuilder: (context, index) => PreviewNetworkImageUi(
                                                      image: controller.bannerCollection[index].image ?? ""),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.only(
                                                        bottomLeft: Radius.circular(14),
                                                        bottomRight: Radius.circular(14),
                                                      ),
                                                      gradient: LinearGradient(
                                                        colors: [AppColor.transparent, AppColor.black.withOpacity(0.6)],
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  child: DotIndicatorUi(
                                                    index: controller.currentBannerIndex,
                                                    length: controller.bannerCollection.length,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              20.height,
                              Text(
                                EnumLocal.txtPurchasePlan.name.tr,
                                style: AppFontStyle.styleW700(AppColor.coloGreyText, 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: GetBuilder<RechargeController>(
                  id: "onChangeLoading",
                  builder: (controller) => controller.isLoading
                      ? LoadingUi()
                      : controller.coinPlanCollection.isEmpty
                          ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                          : SingleChildScrollView(
                              child: GridView.builder(
                                itemCount: controller.coinPlanCollection.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(15),
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  mainAxisExtent: 210,
                                ),
                                itemBuilder: (context, index) {
                                  final planIndex = controller.coinPlanCollection[index];
                                  return CoinPlanItemUi(
                                    coin: planIndex.coin ?? 0,
                                    amount: (planIndex.amount ?? 0).toDouble(),
                                    isPopular: planIndex.isPopular ?? false,
                                    callback: () => Get.toNamed(
                                      AppRoutes.paymentPage,
                                      arguments: {
                                        "id": planIndex.id ?? "",
                                        "amount": planIndex.amount ?? 0,
                                        "productKey": planIndex.productKey ?? "",
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ),
      ),
    );
  }
}

class CoinPlanItemUi extends StatelessWidget {
  const CoinPlanItemUi({
    super.key,
    required this.coin,
    required this.amount,
    required this.isPopular,
    required this.callback,
  });

  final int coin;
  final double amount;
  final bool isPopular;
  final Callback callback;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Stack(
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.secondary.withOpacity(0.1), width: 2),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                12.height,
                Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      gradient: AppColor.yellowGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.white, width: 3),
                        ),
                        child: Image.asset(AppAsset.icWithdrawCoin, width: 58),
                      ),
                    ),
                  ),
                ),
                8.height,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.colorOrangeBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "${CustomFormatNumber.convert(coin)} Coin",
                    style: AppFontStyle.styleW700(AppColor.colorOrange, 11),
                  ),
                ),
                5.height,
                Text(
                  "\₦ ${CustomFormatNumber.convert(amount.toInt())}",
                  style: AppFontStyle.styleW800(AppColor.colorTabBar, 20),
                ),
                5.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: AppButtonUi(
                    title: EnumLocal.txtPayNow.name.tr,
                    height: 40,
                    fontSize: 14,
                    gradient: AppColor.primaryLinearGradient,
                    callback: callback,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isPopular,
            child: Positioned(
              top: 20,
              right: -22,
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  height: 18,
                  width: 100,
                  decoration: BoxDecoration(gradient: AppColor.primaryLinearGradient),
                  child: Center(
                    child: Text(
                      EnumLocal.txtMostPopularPlan.name.tr,
                      style: AppFontStyle.styleW700(AppColor.white, 8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicatorUi extends StatelessWidget {
  const DotIndicatorUi({super.key, required this.index, required this.length});

  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: Get.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < length; i++)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 8,
              width: i == index ? 30 : 10,
              margin: EdgeInsets.only(left: 4),
              child: Container(
                decoration: BoxDecoration(
                  shape: i == index ? BoxShape.rectangle : BoxShape.circle,
                  color: i == index ? AppColor.white : AppColor.white.withOpacity(0.3),
                  borderRadius: i == index ? BorderRadius.circular(20) : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
