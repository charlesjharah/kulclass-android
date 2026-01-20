import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:auralive/google_ad/google_ad_services.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';

// *** >>> Google Ad Code <<< ***

class GoogleAdLargeNative extends StatefulWidget {
  const GoogleAdLargeNative({super.key});

  @override
  State<GoogleAdLargeNative> createState() => _GoogleAdLargeNativeState();
}

class _GoogleAdLargeNativeState extends State<GoogleAdLargeNative> {
  NativeAd? nativeAd;
  RxString isLoading = "loading".obs;

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

  Future<void> loadAd() async {
    debugPrint("Google Large Native Ads Loading...");
    nativeAd = NativeAd(
      adUnitId: GoogleAdServices.nativeAd,
      factoryId: 'large',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAd = ad as NativeAd;
          isLoading.value = "success";
          debugPrint("Google Large Native Ads Loaded Success");
        },
        onAdWillDismissScreen: (ad) {
          debugPrint("Google Large Native Ads Dismiss");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint("Google Large Native Ads Loading Failed => $error");
          isLoading.value = "failed";
          ad.dispose();
        },
      ),
    );
    nativeAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (isLoading.value == "loading")
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              color: AppColor.colorBorder.withOpacity(0.4),
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                "Advertisement Loading...",
                style: AppFontStyle.styleW700(AppColor.black, 14),
              ),
            )
          : (isLoading.value == "success")
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  color: Colors.transparent,
                  child: AdWidget(ad: nativeAd!),
                )
              : const Offstage(),
    );
  }
}
