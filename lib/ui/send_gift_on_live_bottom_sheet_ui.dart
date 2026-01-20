import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/custom/custom_fetch_user_coin.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/pages/splash_screen_page/api/send_gift_to_live_api.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/splash_screen_page/api/fetch_gift_api.dart';
import 'package:auralive/pages/splash_screen_page/model/fetch_gift_model.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';
import 'package:flutter_svga/flutter_svga.dart';
import 'package:auralive/custom/svga_simple_image.dart';


class SendGiftOnLiveBottomSheetUi {
  static RxBool isLoading = false.obs;
  static FetchGiftModel? fetchGiftModel;
  static List<Data> giftCollection = [];

  static RxBool isShowGift = false.obs;

  static RxInt sendGiftIndex = 0.obs;

  static Future<void> onGetGift() async {
    // This Method Call First Time On Bottom Bar Page...
    if (giftCollection.isEmpty) {
      isLoading.value = true;
      fetchGiftModel = await FetchGiftApi.callApi();
      if (fetchGiftModel?.data != null) {
        isLoading.value = false;
        giftCollection.addAll(fetchGiftModel?.data ?? []);
      }
    }
  }

  static Future<void> onSendGift() async {
    if (CustomFetchUserCoin.coin == 0 || CustomFetchUserCoin.coin < (giftCollection[sendGiftIndex.value].coin ?? 0)) {
      Utils.showToast(EnumLocal.txtYouDonHaveSufficientCoinsToSendTheGift.name.tr, AppColor.colorTextDarkGrey.withOpacity(0.85));
    } else {
      Get.back();
      isShowGift.value = true;
      giftCollection[sendGiftIndex.value].type == 1 || giftCollection[sendGiftIndex.value].type == 2 ? await 1500.milliseconds.delay() : await 8000.milliseconds.delay();

      isShowGift.value = false;
      await SendGiftToLiveApi.callApi(
        loginUserId: Database.loginUserId,
        giftId: giftCollection[sendGiftIndex.value].id ?? "",
      );
      CustomFetchUserCoin.init();
    }
  }

  static Widget onShowGift() {
    return Obx(
      () => isShowGift.value
          ? giftCollection[sendGiftIndex.value].type == 1 || giftCollection[sendGiftIndex.value].type == 2
              ? SizedBox(height: 200, width: 200, child: PreviewNetworkImageUi(image: giftCollection[sendGiftIndex.value].image ?? ""))
              : SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SVGAImageWrapper(resUrl: giftCollection[sendGiftIndex.value].image ?? ""),
                    ),
                  ),
                )
          : Offstage(),
    );
  }

  static void show({required BuildContext context}) {
    onGetGift();
    CustomFetchUserCoin.init();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => Container(
        height: 450,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 65,
              decoration: const BoxDecoration(gradient: AppColor.primaryLinearGradient),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  15.width,
                  Container(
                    height: 34,
                    padding: EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                      color: AppColor.white.withOpacity(0.1),
                      border: Border.all(color: AppColor.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(AppAsset.icCoin, width: 22),
                        5.width,
                        Obx(
                          () => Text(
                            CustomFormatNumber.convert(CustomFetchUserCoin.coin.value),
                            style: AppFontStyle.styleW700(AppColor.white, 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        15.height,
                        Text(
                          EnumLocal.txtSendGift.name.tr,
                          style: AppFontStyle.styleW700(AppColor.white, 17),
                        ),
                      ],
                    ).paddingOnly(right: 48),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.transparent,
                        border: Border.all(color: AppColor.white),
                      ),
                      child: Center(
                        child: Image.asset(width: 15, AppAsset.icClose, color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => isLoading.value
                    ? LoadingUi()
                    : GridView.builder(
                        itemCount: giftCollection.length,
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.88,
                        ),
                        itemBuilder: (context, index) => Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: AppColor.colorBorder),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              5.height,
                              giftCollection[index].type == 1 || giftCollection[index].type == 2
                                  ? Expanded(child: PreviewNetworkImageUi(image: giftCollection[index].image ?? ""))
                                  : Expanded(child: SVGAImageWrapper(resUrl: (giftCollection[index].image) != null ? (Api.baseUrl + (giftCollection[index].image ?? "")) : "")),
                              5.height,
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColor.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "${CustomFormatNumber.convert(giftCollection[index].coin ?? 0)} USD",
                                  style: AppFontStyle.styleW700(AppColor.primary, 12),
                                ),
                              ),
                              8.height,
                              GestureDetector(
                                onTap: () {
                                  sendGiftIndex.value = index;
                                  onSendGift();
                                },
                                child: Container(
                                  height: 35,
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                    gradient: AppColor.primaryLinearGradient,
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      EnumLocal.txtSend.name.tr,
                                      style: AppFontStyle.styleW600(AppColor.white, 16),
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
            10.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.rechargePage);
                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.white, width: 1.5),
                            ),
                            child: Image.asset(AppAsset.icCoin, width: 25)),
                        5.width,
                        Text(
                          EnumLocal.txtRecharge.name.tr,
                          style: AppFontStyle.styleW600(AppColor.white, 15),
                        ),
                        5.width,
                        Image.asset(AppAsset.icArrowRight, width: 15, color: AppColor.white),
                      ],
                    ),
                  ),
                ),
                15.width,
              ],
            ),
            10.height,
          ],
        ),
      ),
    );
  }
}
