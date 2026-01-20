import 'package:flutter/material.dart';
import 'package:auralive/utils/color.dart';

class PaymentRadioButtonUi extends StatelessWidget {
  const PaymentRadioButtonUi({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColor.transparent,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? null : AppColor.transparent,
              gradient: isSelected ? AppColor.primaryLinearGradient : null,
            ),
            child: Container(
              height: 24,
              width: 24,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? null : AppColor.colorGreyBg,
                border: Border.all(
                  color: isSelected ? AppColor.white : AppColor.primary.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
