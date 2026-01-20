import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class MyWalletShimmerUi extends StatelessWidget {
  const MyWalletShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          20.height,
          Container(
            height: 160,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
          ),
          Container(
            height: 30,
            width: 150,
            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(35)),
          ),
          5.height,
          Container(
            height: 30,
            width: 225,
            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(35)),
          ),
          10.height,
          Container(
            height: 54,
            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(35)),
          ),
          5.height,
        ],
      ),
    );
  }
}
