import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/on_boarding_page/widget/on_boarding_widget.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/enums.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();
  final List pages = [
    OnBoardingScreen_1(),
    OnBoardingScreen_2(),
    OnBoardingScreen_3(),
  ];

  final List pageTitle = [
    EnumLocal.txtOnBoardingTitle_1.name.tr,
    EnumLocal.txtOnBoardingTitle_2.name.tr,
    EnumLocal.txtOnBoardingTitle_3.name.tr,
  ];

  final List pageSubTitle = [
    EnumLocal.txtOnBoardingSubTitle_1.name.tr,
    EnumLocal.txtOnBoardingSubTitle_2.name.tr,
    EnumLocal.txtOnBoardingSubTitle_3.name.tr,
  ];

  int currentPage = 0;

  void onChangePage(int index) async {
    currentPage = index;
    update(["onChangePage"]);
  }

  void onClickNext() {
    if (currentPage < 2) {
      final next = currentPage + 1;
      onChangePage(next);
    } else if (currentPage == 2) {
      Get.offAllNamed(AppRoutes.loginPage);
    }
  }

  void onPopScope() {
    if (currentPage > 0) {
      final back = currentPage - 1;
      onChangePage(back);
    }
  }
}
