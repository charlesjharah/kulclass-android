import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class SoundShimmerUi extends StatelessWidget {
  const SoundShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: ListView.builder(
        itemCount: 15,
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 76,
                width: 76,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(8)),
              ),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                    ),
                    for (int i = 0; i < 3; i++)
                      Container(
                        height: 14,
                        width: Get.width,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(3)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
