import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:get/get.dart';

class HelpTextFieldUi extends StatelessWidget {
  const HelpTextFieldUi({
    super.key,
    required this.title,
    required this.maxLines,
    required this.controller,
    required this.keyboardType,
    this.height,
    this.inputFormatters,
  });

  final String title;
  final int? maxLines;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFontStyle.styleW500(AppColor.coloGreyText, 15),
        ),
        8.height,
        Container(
          height: height ?? 55,
          width: Get.width,
          padding: const EdgeInsets.only(left: 15),
          alignment: height == null ? Alignment.center : null,
          decoration: BoxDecoration(
            color: AppColor.colorBorder.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
          ),
          child: TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            maxLines: maxLines ?? 1,
            cursorColor: AppColor.colorTextGrey,
            style: AppFontStyle.styleW600(AppColor.black, 15),
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: AppFontStyle.styleW500(AppColor.coloGreyText, 15),
            ),
          ),
        ),
      ],
    );
  }
}
