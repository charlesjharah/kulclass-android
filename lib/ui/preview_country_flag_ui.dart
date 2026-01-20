import 'package:flutter/cupertino.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';

class PreviewCountryFlagUi {
  static Widget show(String? flag) {
    if (flag != null && flag != "") {
      return Text(
        flag,
        style: AppFontStyle.styleW700(AppColor.primary, 22),
      );
    } else {
      return Text(
        "🇮🇳",
        style: AppFontStyle.styleW700(AppColor.primary, 22),
      );
    }
  }
}
