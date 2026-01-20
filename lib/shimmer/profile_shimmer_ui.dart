import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class ProfileShimmerUi extends StatelessWidget {
  const ProfileShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.height,
          Row(
            children: [
              15.width,
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
              ),
              15.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 22,
                      width: 175,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                    ),
                    Container(
                      height: 22,
                      width: 250,
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                        ),
                        5.width,
                        Container(
                          height: 22,
                          width: 100,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: Get.width,
            margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(12)),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(color: AppColor.black),
                ),
              ),
              5.width,
              Expanded(
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(color: AppColor.black),
                ),
              ),
              5.width,
              Expanded(
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(color: AppColor.black),
                ),
              ),
            ],
          ),
          Container(
            height: 75,
            width: Get.width,
            margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }
}
