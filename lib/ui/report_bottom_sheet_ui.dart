import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/splash_screen_page/api/create_report_api.dart';
import 'package:auralive/pages/splash_screen_page/api/fetch_report_api.dart';
import 'package:auralive/pages/splash_screen_page/model/fetch_report_model.dart';
import 'package:auralive/shimmer/report_bottom_sheet_shimmer_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';

class ReportBottomSheetUi {
  static RxInt selectedReportType = 0.obs;

  static RxBool isLoading = false.obs;

  static FetchReportModel? fetchReportModel;

  static List<Data> reportTypes = [];

  static Future<void> onSendReport({required String eventId, required int eventType}) async {
    Utils.showToast(EnumLocal.txtReportSending.name.tr);
    Get.back();

    final response = await CreateReportApi.callApi(
      loginUserId: Database.loginUserId,
      reportReason: reportTypes[selectedReportType.value].title ?? "",
      eventType: eventType,
      eventId: eventId,
    );

    if (response != null && response) {
      Utils.showToast(EnumLocal.txtReportSendSuccess.name.tr);
    } else {
      Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
    }
  }

  static Future<void> onGetReports() async {
    if (reportTypes.isEmpty) {
      isLoading.value = true;
      fetchReportModel = await FetchReportApi.callApi();

      if (fetchReportModel?.data != null) {
        reportTypes.addAll(fetchReportModel?.data ?? []);
      }
      isLoading.value = false;
    }
  }

  static void show({
    required BuildContext context,
    required String eventId,
    required int eventType,
  }) async {
    onGetReports();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 500,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: AppColor.grey_100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColor.colorTextDarkGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      10.height,
                      Text(
                        EnumLocal.txtReport.name.tr,
                        style: AppFontStyle.styleW700(AppColor.black, 17),
                      ),
                    ],
                  ).paddingOnly(left: 50),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.transparent,
                        border: Border.all(color: AppColor.black),
                      ),
                      child: Center(
                        child: Image.asset(
                          width: 18,
                          AppAsset.icClose,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => isLoading.value
                  ? Expanded(child: ReportBottomSheetShimmerUi())
                  : Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: reportTypes.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => selectedReportType.value = index,
                              child: Container(
                                height: 46,
                                color: AppColor.transparent,
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Obx(() => ReportRadioButtonUi(isSelected: selectedReportType.value == index)),
                                    12.width,
                                    Text(
                                      reportTypes[index].title ?? "",
                                      style: AppFontStyle.styleW500(AppColor.black, 16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ),
            Obx(
              () => Visibility(
                visible: !isLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColor.colorTabBar.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            EnumLocal.txtCancel.name.tr,
                            style: AppFontStyle.styleW700(AppColor.colorTabBar, 16),
                          ),
                        ),
                      ),
                      15.width,
                      GestureDetector(
                        onTap: () async {
                          await onSendReport(eventId: eventId, eventType: eventType);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: AppColor.primaryLinearGradient,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            EnumLocal.txtReport.name.tr,
                            style: AppFontStyle.styleW700(AppColor.white, 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportRadioButtonUi extends StatelessWidget {
  const ReportRadioButtonUi({super.key, required this.isSelected});

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
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? null : AppColor.colorGreyBg,
                border: Border.all(color: isSelected ? AppColor.white : AppColor.primary.withOpacity(0.5), width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO => Static Reports Types With Multi Language...

//   static List reportTypes = [
//     "",
//     EnumLocal.txtItIsSpam.name.tr,
//     EnumLocal.txtNudityOrSexualActivity.name.tr,
//     EnumLocal.txtHateSpeechOrSymbols.name.tr,
//     EnumLocal.txtViolenceOrDangerousOrganization.name.tr,
//     EnumLocal.txtFalseInformation.name.tr,
//     EnumLocal.txtBullyingOrHarassment.name.tr,
//     EnumLocal.txtScamOrFraud.name.tr,
//     EnumLocal.txtIntellectualPropertyViolation.name.tr,
//     EnumLocal.txtSuicideOrSelfInjury.name.tr,
//     EnumLocal.txtDrugs.name.tr,
//     EnumLocal.txtEatingDisorders.name.tr,
//     EnumLocal.txtSomethingElse.name.tr,
//     EnumLocal.txtChildAbuse.name.tr,
//     EnumLocal.txtOthers.name.tr,
//   ];
