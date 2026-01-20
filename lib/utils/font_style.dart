import 'package:flutter/material.dart';
import 'constant.dart';

abstract class AppFontStyle {
  static styleW400(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.appFontRegular,
    );
  }

  static styleW500(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstant.appFontMedium,
    );
  }

  static styleW600(Color color, double fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.appFontMedium,
    );
  }

  static styleW700(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      fontFamily: AppConstant.appFontBold,
    );
  }

  static styleW800(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      fontFamily: AppConstant.appFontBold,
    );
  }

  static styleW900(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      fontFamily: AppConstant.appFontBold,
    );
  }

  static appBarStyle() {
    return const TextStyle(
      fontSize: 21,
      letterSpacing: 0.4,
      fontFamily: AppConstant.appFontBold,
      fontWeight: FontWeight.bold,
    );
  }
}
