import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:auralive/custom/custom_fetch_user_coin.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/custom/custom_range_picker.dart';
import 'package:auralive/ui/gradient_text_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/my_wallet_page/controller/my_wallet_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/pages/my_wallet_page/widget/my_wallet_widget.dart';
import 'package:auralive/shimmer/coin_history_shimmer_ui.dart';
import 'package:auralive/shimmer/my_wallet_shimmer_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:io'; // for Platform
import 'package:url_launcher/url_launcher.dart'; // fallback for Web/Desktop

class MyWalletView extends StatefulWidget {
  const MyWalletView({super.key});

  @override
  State<MyWalletView> createState() => _MyWalletViewState();
}

class _MyWalletViewState extends State<MyWalletView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyWalletController>();
    final storage = GetStorage();
    final userEmail = storage.read('user_email') ?? '';
    final userCountry = storage.read('user_country') ?? '';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          shadowColor: AppColor.black.withOpacity(0.4),
          surfaceTintColor: AppColor.white,
          flexibleSpace: MyWalletAppBar(),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: AppColor.white,
              expandedHeight: 400,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(
                        () => CustomFetchUserCoin.isLoading.value
                        ? MyWalletShimmerUi()
                        : Column(
                      children: [
                        Divider(
                            color: AppColor.colorGreyHasTagText
                                .withOpacity(0.1),
                            height: 1),
                        20.height,
                        Center(
                          child: Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              gradient: AppColor.yellowGradient,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColor.white, width: 8),
                                ),
                                child: Image.asset(AppAsset.icWithdrawCoin,
                                    width: 128),
                              ),
                            ),
                          ),
                        ),
                        10.height,

                        Obx(
                              () => Text(
                                controller.convertedBalance.value == 0.0
                                    ? "${CustomFormatNumber.convert(CustomFetchUserCoin.coin.value)}" // original int
                                    : "${controller.currencyCode.value} ${CustomFormatNumber.convert(controller.convertedBalance.value.toInt())}", // convert double -> int
                                style: AppFontStyle.styleW700(AppColor.colorOrange, 30),
                              )

                        ),

                        Text(
                          EnumLocal.txtAvailableCoinBalance.name.tr,
                          style: AppFontStyle.styleW500(
                              AppColor.colorGreyHasTagText, 14),
                        ),
                        18.height,
                        GestureDetector(
                          onTap: () {
                            final webUrl =
                                "https://admin.auraapp.site/test.php?userEmail=$userEmail&country=$userCountry";
                            _showFullScreenWebView(context, webUrl);
                          },
                          child: Container(
                            height: 56,
                            width: Get.width,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              gradient: AppColor.primaryLinearGradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  EnumLocal.txtRechargeCoin.name.tr,
                                  style: AppFontStyle.styleW600(
                                      AppColor.white, 18),
                                ),
                                8.width,
                                Image.asset(AppAsset.icDoubleArrowRight,
                                    color: AppColor.white, width: 22),
                              ],
                            ),
                          ),
                        ),
                        20.height,
                        Divider(
                            color: AppColor.colorGreyHasTagText
                                .withOpacity(0.1),
                            height: 1),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  color: AppColor.white,
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Image.asset(AppAsset.icCoinHistory, width: 26),
                      10.width,
                      GradientTextUi(
                        EnumLocal.txtCoinHistory.name.tr,
                        style: AppFontStyle.styleW700(AppColor.primary, 16),
                        gradient: AppColor.primaryLinearGradient,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          DateTimeRange? dateTimeRange =
                          await CustomRangePicker.onShow(context);
                          if (dateTimeRange != null) {
                            String startDate =
                            DateFormat('yyyy-MM-dd').format(dateTimeRange.start);
                            String endDate =
                            DateFormat('yyyy-MM-dd').format(dateTimeRange.end);
                            final range =
                                "${DateFormat('dd MMM').format(dateTimeRange.start)} - ${DateFormat('dd MMM').format(dateTimeRange.end)}";
                            Utils.showLog("Selected Date Range => $range");

                            controller.onChangeDate(
                                startDate: startDate,
                                endDate: endDate,
                                rangeDate: range);

                            controller.onGetCoinHistory();
                          }
                        },
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColor.colorBorderGrey.withOpacity(0.6)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GetBuilder<MyWalletController>(
                                id: "onChangeDate",
                                builder: (controller) => Text(
                                  controller.rangeDate,
                                  style: AppFontStyle.styleW500(
                                      AppColor.colorDarkGrey, 12),
                                ),
                              ),
                              8.width,
                              SizedBox(
                                height: 35,
                                width: 12,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: const [
                                    Positioned(
                                        top: 12.5,
                                        child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 19)),
                                    Positioned(
                                        top: 3.5,
                                        child: Icon(
                                            Icons.keyboard_arrow_up_rounded,
                                            size: 20)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: GetBuilder<MyWalletController>(
          id: "onGetCoinHistory",
          builder: (controller) => controller.isLoading
              ? CoinHistoryShimmerUi()
              : controller.coinHistory.isEmpty
              ? NoDataFoundUi(iconSize: 160, fontSize: 19)
              : RefreshIndicator(
            onRefresh: () => controller.init(),
            color: AppColor.primary,
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 12),
                itemCount: controller.coinHistory.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final historyIndex = controller.coinHistory[index];
                  return HistoryItemUi(
                    isPaymentComplete: (historyIndex.type == 1 &&
                        historyIndex.isIncome == true) ||
                        (historyIndex.type == 2) ||
                        (historyIndex.type == 5 &&
                            historyIndex.isIncome == true),
                    title: historyIndex.type == 1
                        ? historyIndex.isIncome == true
                        ? EnumLocal.txtReceiveGiftCoin.name.tr
                        : EnumLocal.txtSendGiftCoin.name.tr
                        : historyIndex.type == 2
                        ? EnumLocal.txtRechargeCoin.name.tr
                        : historyIndex.type == 3
                        ? historyIndex.payoutStatus == 1
                        ? EnumLocal
                        .txtPendingWithdrawal.name.tr
                        : historyIndex.payoutStatus == 3
                        ? EnumLocal
                        .txtCancelWithdrawal.name
                        .tr
                        : EnumLocal.txtWithdrawal.name.tr
                        : historyIndex.type == 4
                        ? ""
                        : historyIndex.type == 5
                        ? EnumLocal.txtWelcomeBonusCoin
                        .name
                        .tr
                        : "",
                    date: historyIndex.date ?? "",
                    uniqueId: historyIndex.uniqueId ?? "",
                    coin: (historyIndex.type == 1 &&
                        historyIndex.isIncome == true) ||
                        (historyIndex.type == 2) ||
                        (historyIndex.type == 5 &&
                            historyIndex.isIncome == true)
                        ? "+ ${CustomFormatNumber.convert(historyIndex.coin ?? 0)}"
                        : "- ${CustomFormatNumber.convert(historyIndex.coin ?? 0)}",
                    reason: historyIndex.reason ?? "",
                    giftTitle: historyIndex.type == 1
                        ? RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(
                        text: historyIndex.isIncome == true
                            ? EnumLocal.txtReceiveGiftCoin.name.tr
                            : EnumLocal.txtSendGiftCoin.name.tr,
                        style: AppFontStyle.styleW700(
                            (historyIndex.type == 1 &&
                                historyIndex.isIncome == true)
                                ? AppColor.colorClosedGreen
                                : AppColor.colorRedContainer,
                            13),
                        children: [
                          TextSpan(
                            text: historyIndex.isIncome == true
                                ? " (${historyIndex.senderName})"
                                : " (${historyIndex.receiverName})",
                            style: AppFontStyle.styleW400(
                                AppColor.colorGreyHasTagText,
                                11.5),
                          ),
                        ],
                      ),
                    )
                        : null,
                  );
                }),
          ),
        ),
      ),
    );
  }

  /// Full-screen WebView that supports Android/iOS and falls back to url_launcher on Web/Desktop
  void _showFullScreenWebView(BuildContext context, String url) {
    // Web/Desktop fallback
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      _openUrlInBrowser(url);
      return;
    }

    // Android/iOS WebView
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          bool isLoading = true;
          final webController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageStarted: (String pageUrl) {
                  if (pageUrl.startsWith("https://admin.auraapp.site/test3.php")) {
                    Navigator.of(context).pop(); // Close WebView
                    Get.toNamed(AppRoutes.myWalletPage);

                    Future.delayed(const Duration(milliseconds: 500), () {
                      Get.defaultDialog(
                        title: "100% Complete",
                        middleText: "Recharge Successful",
                        textConfirm: "Ok",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          if (Get.isRegistered<MyWalletController>()) {
                            Get.find<MyWalletController>().init();
                          }
                          Get.back();
                        },
                        barrierDismissible: false,
                      );
                    });
                  }
                },
                onPageFinished: (_) {
                  isLoading = false;
                },
              ),
            )
            ..loadRequest(Uri.parse(url));

          return StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text("Recharge Coins",
                      style: TextStyle(color: Colors.black)),
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Stack(
                  children: [
                    WebViewWidget(controller: webController),
                    if (isLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Launch URL in external browser for Web/Desktop
  void _openUrlInBrowser(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not open the URL");
    }
  }
}

class HistoryItemUi extends StatelessWidget {
  const HistoryItemUi({
    super.key,
    required this.isPaymentComplete,
    required this.title,
    required this.date,
    required this.uniqueId,
    required this.coin,
    required this.reason,
    required this.giftTitle,
  });

  final String title;
  final String date;
  final String uniqueId;
  final String coin;
  final bool isPaymentComplete;
  final String reason;
  final Widget? giftTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: reason == "" ? 70 : 80,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.colorBorderGrey.withOpacity(0.6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.width,
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColor.colorBorderGrey.withOpacity(0.4)),
            ),
            child: Center(
              child: Image.asset(AppAsset.icWithdrawCoin, width: 32),
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                giftTitle ??
                    Text(
                      title,
                      style: AppFontStyle.styleW700(
                          isPaymentComplete ? AppColor.colorClosedGreen : AppColor.colorRedContainer, 13),
                    ),
                Text(
                  date,
                  style: AppFontStyle.styleW500(AppColor.colorGreyHasTagText, 10),
                ),
                2.height,
                Text(
                  "ID : $uniqueId",
                  style: AppFontStyle.styleW500(AppColor.colorGreyHasTagText, 10),
                ),
                Visibility(
                  visible: reason != "",
                  child: SizedBox(
                    width: Get.width / 2,
                    child: Text(
                      "Reason : $reason",
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.colorGreyHasTagText, 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.width,
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: isPaymentComplete
                  ? AppColor.colorGreenBg.withOpacity(0.8)
                  : AppColor.colorRedBg.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                coin,
                style: AppFontStyle.styleW700(
                    isPaymentComplete ? AppColor.colorClosedGreen : AppColor.colorRedContainer, 15),
              ),
            ),
          ),
          10.width,
        ],
      ),
    );
  }
}
