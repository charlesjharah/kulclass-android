import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import 'package:auralive/utils/color.dart';

class QrCodeItemUi extends StatelessWidget {
  const QrCodeItemUi({super.key, required this.icon, required this.callback});

  final String icon;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 50,
        width: 52,
        decoration: const BoxDecoration(
          gradient: AppColor.primaryLinearGradient,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(icon, height: 24, width: 24, color: AppColor.white),
        ),
      ),
    );
  }
}
