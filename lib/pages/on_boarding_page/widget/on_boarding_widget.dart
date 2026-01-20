import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';

class OnBoardingScreen_1 extends StatelessWidget {
  const OnBoardingScreen_1({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          AppAsset.imgOnBoarding_1,
          width: Get.width,
        ),
      ),
    );
  }
}

class OnBoardingScreen_2 extends StatelessWidget {
  const OnBoardingScreen_2({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 30),
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          AppAsset.imgOnBoarding_2,
          width: Get.width,
        ),
      ),
    );
  }
}

class OnBoardingScreen_3 extends StatelessWidget {
  const OnBoardingScreen_3({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        top: 30,
      ), //30
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          AppAsset.imgOnBoarding_3,
          width: 400,
        ),
      ),
    );
  }
}

class DotIndicatorUi extends StatelessWidget {
  const DotIndicatorUi({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: Get.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 3; i++)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 8,
              width: i == index ? 35 : 10,
              margin: EdgeInsets.only(left: 5),
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
