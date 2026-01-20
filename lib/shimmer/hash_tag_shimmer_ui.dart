import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';

class HashTagShimmerUi extends StatelessWidget {
  const HashTagShimmerUi({super.key});

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
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 150,
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    ),
                    Spacer(),
                    10.width,
                    Container(
                      height: 38,
                      width: 85,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ],
                ),
              ),
              10.height,
              Container(
                height: 176,
                width: Get.width,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(15)),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
