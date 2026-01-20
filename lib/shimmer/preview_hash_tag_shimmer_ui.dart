import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class PreviewHashTagShimmerUi extends StatelessWidget {
  const PreviewHashTagShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: GridView.builder(
        itemCount: 24,
        padding: const EdgeInsets.all(12),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: AppColor.black,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
