import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class RechargeShimmerUi extends StatelessWidget {
  const RechargeShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            Container(
              height: 35,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(30)),
            ),
            Container(
              height: 35,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(30)),
            ),
            Container(
              height: 180,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(30)),
            ),
            Container(
              height: 30,
              width: 200,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(30)),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 20,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.88,
                ),
                itemBuilder: (context, index) => Container(
                  height: 54,
                  width: Get.width,
                  decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
