import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';

class FeedShimmerUi extends StatelessWidget {
  const FeedShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: ListView.builder(
        itemCount: 15,
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                  ),
                  10.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: Get.width,
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                        ),
                        Container(
                          height: 20,
                          width: Get.width,
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ),
                  10.width,
                  Container(
                    height: 40,
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              8.height,
              Container(
                height: 210,
                width: 175,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              3.height,
              Container(
                height: 25,
                width: 300,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
              ),
              3.height,
              Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    Container(
                      height: 35,
                      width: 85,
                      margin: const EdgeInsets.only(bottom: 5, right: 10),
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                ],
              ),
              3.height,
              Container(
                height: 25,
                width: 100,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
              ),
              3.height,
              Row(
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(bottom: 5, right: 10),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              5.height,
              Divider(color: AppColor.black)
            ],
          ),
        ),
      ),
    );
  }
}
