import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/constant.dart';

class AppButtonUi extends StatelessWidget {
  const AppButtonUi({
    super.key,
    this.height,
    required this.title,
    this.color,
    this.icon,
    this.gradient,
    required this.callback,
    this.iconSize,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
    this.iconColor,
  });

  final double? height;
  final double? iconSize;
  final double? fontSize;
  final String title;
  final Color? color;
  final Color? fontColor;
  final Color? iconColor;
  final String? icon;
  final Gradient? gradient;
  final FontWeight? fontWeight;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
          gradient: gradient,
        ),
        height: height ?? 56,
        width: Get.width,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Image.asset(icon!, width: iconSize ?? 30, color: iconColor).paddingOnly(right: 10)
                  : const Offstage(),
              Text(
                title,
                style: TextStyle(
                  color: fontColor ?? AppColor.white,
                  fontFamily: AppConstant.appFontMedium,
                  fontSize: fontSize ?? 18,
                  letterSpacing: 0.3,
                  fontWeight: fontWeight ?? FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
