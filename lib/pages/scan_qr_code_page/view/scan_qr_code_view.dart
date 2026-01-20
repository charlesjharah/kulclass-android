import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/pages/scan_qr_code_page/controller/scan_qr_code_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';

class ScanQrCodeView extends GetView<ScanQrCodeController> {
  const ScanQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          shadowColor: AppColor.black.withOpacity(0.4),
          flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtScanQRCode.name.tr),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.height,
            GradiantBorderContainer(
              height: 265,
              radius: 22,
              child: Container(
                height: 265,
                width: 265,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MobileScanner(
                  controller: controller.mobileScannerController,
                  onDetect: (barcodes) async {
                    final userId = barcodes.barcodes.first.rawValue;

                    if (userId != "") {
                      try {
                        final object = userId ?? "";

                        List<String> objectParts = object.split(",");

                        if (bool.parse(objectParts[1]) == true && objectParts[0] != "" && objectParts.length == 2) {
                          Utils.showLog("Scan Qr User Id => ${objectParts[0]}");

                          if (objectParts[0] != Database.loginUserId) {
                            Get.toNamed(AppRoutes.previewUserProfilePage, arguments: objectParts[0]);
                          } else {
                            Get.offAllNamed(AppRoutes.bottomBarPage);
                            await 300.milliseconds.delay();
                            final bottomBarController = Get.find<BottomBarController>();
                            bottomBarController.onChangeBottomBar(4);
                          }
                        }
                      } catch (e) {
                        Utils.showLog("Scan Qr Code Is Wrong => $e");
                      }
                    }
                  },
                ),
              ),
            ),
            20.height,
            Text(
              EnumLocal.txtScanQRCodeText.name.tr,
              maxLines: 1,
              style: AppFontStyle.styleW400(AppColor.coloGreyText, 17),
            ),
            10.height,
            Image.asset(
              AppAsset.icScanImage,
              height: 230,
            ),
          ],
        ),
      ),
    );
  }
}

class GradiantBorderContainer extends StatelessWidget {
  const GradiantBorderContainer({super.key, required this.height, this.width, required this.radius, this.child});

  final double height;
  final double? width;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColor.primaryLinearGradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: DottedBorder(
        // dashPattern: const [3, 6],
        // borderType: BorderType.RRect,
        // color: AppColor.colorScaffold,
        // radius: Radius.circular(radius),
        // padding: const EdgeInsets.all(1.5),
        // strokeWidth: 5,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColor.colorScaffold,
            borderRadius: BorderRadius.circular(radius - 1),
          ),
          child: child,
        ),
      ),
    );
  }
}
