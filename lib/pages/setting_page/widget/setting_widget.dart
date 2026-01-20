import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key, required this.icon, required this.title, required this.callback});

  final String icon;
  final String title;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 65,
        width: Get.width,
        color: AppColor.transparent,
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 30,
              color: AppColor.colorLightBlue,
            ),
            15.width,
            Expanded(
              child: Text(
                title,
                style: AppFontStyle.styleW700(AppColor.colorDarkBlue, 15),
              ),
            ),
            Image.asset(AppAsset.icArrowRight, width: 20),
          ],
        ),
      ),
    );
  }
}
