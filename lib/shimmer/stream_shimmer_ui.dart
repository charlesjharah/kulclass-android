import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:auralive/utils/color.dart';
import 'package:flutter/widgets.dart';

class StreamShimmerUi extends StatelessWidget {
  const StreamShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: 24,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.80,
          ),
          itemBuilder: (context, index) => Container(
            height: 22,
            width: 175,
            decoration: BoxDecoration(
              // color: AppColor.black,
              border: Border.all(color: AppColor.black, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.5),
                        topRight: Radius.circular(18.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      margin: EdgeInsets.only(left: 5, right: 3),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 16,
                            margin: EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                          ),
                          Container(
                            height: 16,
                            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      margin: EdgeInsets.only(left: 3, right: 5),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
