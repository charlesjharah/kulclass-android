import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class PreviewProfileBottomSheetShimmerUi extends StatelessWidget {
  const PreviewProfileBottomSheetShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            8.height,
            Container(
              height: 124,
              width: 124,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
            ),
            Container(
              height: 25,
              width: 175,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              height: 25,
              width: 250,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 33,
                  width: 33,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                ),
                8.width,
                Container(
                  height: 33,
                  width: 100,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 54,
                    width: Get.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                15.width,
                Container(
                  height: 54,
                  width: 54,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
