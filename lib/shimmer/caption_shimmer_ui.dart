import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';

class CaptionShimmerUi extends StatelessWidget {
  const CaptionShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: AppColor.shimmer,
        highlightColor: AppColor.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  height: 15,
                  width: Get.width / 1.2,
                  margin: const EdgeInsets.only(top: 4, right: 0),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              Container(
                height: 15,
                width: Get.width / 1.8,
                margin: const EdgeInsets.only(top: 4, right: 0),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
