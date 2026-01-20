import 'package:flutter/material.dart';

abstract class AppColor {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  static const primary = Color(0xFF8B82FC);
  static const secondary = Color(0xFFD26FF4);

  static final shimmer = Color(0xFFC1C7E4).withOpacity(0.5);
  static final placeHolder = Color(0xFF9C9EB0);

  static const colorTabBar = Color(0xFFaa78f8);

  static const colorBlue = Color(0xFF1C81FC);

  static const colorDarkBlue = Color(0xFF171760);
  static const colorScaffold = Color(0xffFBFCFF);

  static const colorLightBlue = Color(0xff6E71A9);

  static const colorUnselectedIcon = Color(0xFFC1C7E4);
  static const colorBorder = Color(0xFFE5EAFF);

  static const colorGreyDarkText = Color(0xFF444343);
  static const coloGreyText = Color(0xFF8F989F);
  static const colorGreyHasTagText = Color(0xFF8F989F);
  static const colorGreyBg = Color(0xFFF9F9F9);
  static const colorBorderGrey = Color(0xFFECECEC);
  static const colorTextGrey = Color(0xFF9EA6BE);
  static const colorTextLightGrey = Color(0xFF9EA2A7);
  static const colorTextDarkGrey = Color(0xFF8C8C8C);
  static const colorSecondaryTextGrey = Color(0xFF95969D);
  static const colorTextRed = Color(0xFFFF4444);
  static const colorButtonPink = Color(0xFFFF4D67);
  static const colorIconGrey = Color(0xFF5C5C5C);
  static const colorDarkPink = Color(0xFFFE0952);
  static const colorDarkGrey = Color(0xFF5D5A5A);

  static const colorRedContainer = Color(0xFFFC1010);
  static const colorLightGreyBgContainer = Color(0xFFF2F2F2);
  static const colorBlueLightContainer = Color(0xFFd9ebff);
  static const colorWorkingOrange = Color(0xFFFC5D20);
  static const colorPendingYellow = Color(0xFFFABC2C);
  static const colorClosedGreen = Color(0xFF3BB537);
  static const colorOrange = Color(0xFFFFA132);
  static const colorDarkOrange = Color(0xFFFB8500);

  static const colorGreenBg = Color(0xFFE3FDE0);
  static const colorRedBg = Color(0xFFFFECEC);
  static const colorOrangeBg = Color(0xFFFFF5E8);

  static const colorLightRedBg = Color(0xFFFFF2F2);
  static const colorLightGreyBg = Color(0x0ff6f8ff);

  static const primaryLinearGradientText = LinearGradient(colors: [Color(0xFF6D63FF), Color(0xFFD764FF)]);
  static const primaryLinearGradient = LinearGradient(colors: [AppColor.primary, AppColor.secondary]);

  static const redGradient = LinearGradient(colors: [Color(0xFFF01456), Color(0xFFF20D0D)]);
  static const yellowGradient = LinearGradient(colors: [Color(0xFFFFD31E), Color(0xFFFF9F32)]);

  static final grey_50 = Colors.grey.shade50;
  static final grey_100 = Colors.grey.shade100;
  static final grey_300 = Colors.grey.shade300;
  static final grey_400 = Colors.grey.shade400;
}
