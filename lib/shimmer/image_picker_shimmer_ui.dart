import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class ImagePickerShimmerUi extends StatelessWidget {
  const ImagePickerShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: 24,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) => Container(
            height: 22,
            width: 175,
            decoration: BoxDecoration(color: AppColor.black),
          ),
        ),
      ),
    );
  }
}
