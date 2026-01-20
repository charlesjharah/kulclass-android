import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/on_boarding_page/controller/on_boarding_controller.dart';
import 'package:auralive/pages/on_boarding_page/widget/on_boarding_widget.dart';
import 'package:auralive/ui/gradient_text_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/constant.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => controller.onPopScope(),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Image.asset(AppAsset.imgGradiantBg, fit: BoxFit.cover),
            ),
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GetBuilder<OnBoardingController>(
                      id: "onChangePage",
                      builder: (controller) => PageView.builder(
                        itemCount: controller.pages.length,
                        onPageChanged: (value) => controller.onChangePage(value),
                        itemBuilder: (context, index) => controller.pages[controller.currentPage],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: AppColor.primaryLinearGradient,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        32.height,
                        GetBuilder<OnBoardingController>(
                          id: "onChangePage",
                          builder: (controller) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              controller.pageTitle[controller.currentPage],
                              style: TextStyle(
                                color: AppColor.white,
                                fontFamily: AppConstant.appFontBold,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                        17.height,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GetBuilder<OnBoardingController>(
                            id: "onChangePage",
                            builder: (controller) => Text(
                              controller.pageSubTitle[controller.currentPage],
                              textAlign: TextAlign.center,
                              style: AppFontStyle.styleW400(AppColor.white.withOpacity(0.9), 15),
                            ),
                          ),
                        ),
                        22.height,
                        GetBuilder<OnBoardingController>(
                          id: "onChangePage",
                          builder: (controller) => DotIndicatorUi(index: controller.currentPage),
                        ),
                        27.height,
                        GestureDetector(
                          onTap: () => controller.onClickNext(),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                            margin: EdgeInsets.only(bottom: 32),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(color: AppColor.black.withOpacity(0.4), blurRadius: 2),
                              ],
                            ),
                            child: GradientTextUi(
                              EnumLocal.txtNext.name.tr,
                              gradient: AppColor.primaryLinearGradient,
                              style: AppFontStyle.styleW700(AppColor.white, 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
