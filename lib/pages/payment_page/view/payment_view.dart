import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/pages/payment_page/controller/payment_controller.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          shadowColor: AppColor.black.withOpacity(0.4),
          flexibleSpace: const SimpleAppBarUi(title: "Payment"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          "Proceed to complete your payment",
          style: AppFontStyle.styleW700(AppColor.black, 16),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: GetBuilder<PaymentController>(
          builder: (controller) => AppButtonUi(
            height: 56,
            title: EnumLocal.txtPayNow.name.tr,
            gradient: AppColor.primaryLinearGradient,
            callback: controller.onClickPayNow,
          ),
        ),
      ),
    );
  }
}
