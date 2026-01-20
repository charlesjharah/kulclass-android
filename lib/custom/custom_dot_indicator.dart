import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/utils/color.dart';

class CustomDotIndicator extends StatelessWidget {
  const CustomDotIndicator({super.key, required this.index, required this.length});

  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: Get.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < length; i++)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 8,
              width: i == index ? 35 : 10,
              margin: EdgeInsets.only(right: 5),
              child: Container(
                decoration: BoxDecoration(
                  shape: i == index ? BoxShape.rectangle : BoxShape.circle,
                  color: i == index ? AppColor.primary : AppColor.white.withOpacity(0.3),
                  borderRadius: i == index ? BorderRadius.circular(20) : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
