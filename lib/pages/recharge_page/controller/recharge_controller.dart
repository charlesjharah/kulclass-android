import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/recharge_page/api/fetch_banner_api.dart';
import 'package:auralive/pages/recharge_page/api/fetch_coin_plan_api.dart';
import 'package:auralive/pages/recharge_page/model/fetch_banner_model.dart';
import 'package:auralive/pages/recharge_page/model/fetch_coin_plan_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/utils.dart';

class RechargeController extends GetxController {
  bool isLoading = false;

  List<Data> coinPlanCollection = [];
  FetchCoinPlanModel? fetchCoinPlanModel;

  List<BannerData> bannerCollection = [];
  FetchBannerModel? fetchBannerModel;

  int currentBannerIndex = 0;

  PageController pageController = PageController();

  Timer? timer;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> init() async {
    coinPlanCollection.clear();
    bannerCollection.clear();
    onGetCoinPlan();
  }

  Future<void> onGetCoinPlan() async {
    isLoading = true;

    fetchCoinPlanModel = await FetchCoinPlanApi.callApi();

    if (fetchCoinPlanModel?.data != null) {
      coinPlanCollection.addAll(fetchCoinPlanModel?.data ?? []);
      onGetBanner();
    }
  }

  Future<void> onGetBanner() async {
    fetchBannerModel = await FetchBannerApi.callApi();

    if (fetchCoinPlanModel?.data != null) {
      bannerCollection.addAll(fetchBannerModel?.data ?? []);
    }
    isLoading = false;
    update(["onChangeLoading"]);

    if (bannerCollection.isNotEmpty) {
      onChangeBanner();
    }
  }

  Future<void> onChangeBanner() async {
    try {
      timer = Timer.periodic(
        Duration(milliseconds: 3000),
        (timer) async {
          if (Get.currentRoute == AppRoutes.rechargePage) {
            if ((currentBannerIndex + 1) < bannerCollection.length) {
              currentBannerIndex++;
              update(["onChangeBanner"]);
              await pageController.animateToPage(currentBannerIndex, duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
            } else {
              currentBannerIndex = 0;
              update(["onChangeBanner"]);
              await pageController.animateToPage(currentBannerIndex, duration: Duration(milliseconds: 10), curve: Curves.fastOutSlowIn);
            }
          } else {
            timer.cancel();
          }
        },
      );
    } catch (e) {
      Utils.showLog("On Banner Change Error => $e");
    }
  }
}
