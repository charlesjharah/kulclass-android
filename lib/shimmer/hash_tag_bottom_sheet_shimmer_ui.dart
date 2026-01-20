import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class HashTagBottomSheetShimmerUi extends StatelessWidget {
  const HashTagBottomSheetShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(10)),
              ),
              10.width,
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              10.width,
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
