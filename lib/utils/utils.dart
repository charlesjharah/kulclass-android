import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:auralive/utils/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:auralive/pages/splash_screen_page/api/admin_setting_api.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

abstract class Utils {
  static RxBool isAppOpen = false.obs;

  static void showLog(String text) => log(text);

  static void showToast(String text, [Color? color]) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: color ?? AppColor.primary,
      textColor: AppColor.white,
      gravity: ToastGravity.BOTTOM,
    );
  }

  // >>>>> >>>>> Edit Profile Page <<<<< <<<<<

  static int waterMarkSize = 25;
  static bool isShowWaterMark = AdminSettingsApi.adminSettingModel?.data?.isWatermarkOn ?? false;
  static String waterMarkIcon = AdminSettingsApi.adminSettingModel?.data?.watermarkIcon ?? "";

  static TextEditingController countryController = TextEditingController(text: "India");
  static TextEditingController flagController = TextEditingController(text: "🇮🇳");

  // >>>>> >>>>> Show Reels Effect <<<<< <<<<<

  static final bool isShowReelsEffect = AdminSettingsApi.adminSettingModel?.data?.isEffectActive ?? false;

  // >>>>> >>>>> Upload Shorts Limit <<<<< <<<<<

  static final int shortsDuration = AdminSettingsApi.adminSettingModel?.data?.durationOfShorts ?? 0;

  static final String effectAndroidLicenseKey = AdminSettingsApi.adminSettingModel?.data?.androidLicenseKey ?? "";
  static final String effectIosLicenseKey = AdminSettingsApi.adminSettingModel?.data?.iosLicenseKey ?? "";

  // >>>>> >>>>> Web View Url <<<<< <<<<<

  static final String privacyPolicyLink = AdminSettingsApi.adminSettingModel?.data?.privacyPolicyLink ?? "";
  static final String termsOfUseLink = AdminSettingsApi.adminSettingModel?.data?.termsOfUsePolicyLink ?? "";

  // >>>>> >>>>> Show Payment Method <<<<< <<<<<

  static final bool isShowStripePaymentMethod = AdminSettingsApi.adminSettingModel?.data?.stripeSwitch ?? false;
  static final bool isShowRazorPayPaymentMethod = AdminSettingsApi.adminSettingModel?.data?.razorPaySwitch ?? false;
  //static final bool isShowFlutterWavePaymentMethod = AdminSettingsApi.adminSettingModel?.data?.flutterWaveSwitch ?? false;
  //static final bool isShowInAppPurchasePaymentMethod = AdminSettingsApi.adminSettingModel?.data?.googlePlaySwitch ?? false;

  // >>>>> >>>>> Live Streaming Credential <<<<< <<<<<

  static final String serverSecret = "";
  static final String liveAppSign = AdminSettingsApi.adminSettingModel?.data?.zegoAppSignIn ?? "";
  static final int liveAppId = int.parse(AdminSettingsApi.adminSettingModel?.data?.zegoAppId?.toString() ?? "00");

  // >>>>> >>>>> RazorPay Payment Credential <<<<< <<<<<

  static String razorpayTestKey = AdminSettingsApi.adminSettingModel?.data?.razorSecretKey ?? "";
  static String razorpayCurrencyCode = AdminSettingsApi.adminSettingModel?.data?.currency?.currencyCode ?? "";

  // >>>>> >>>>> Stripe Payment Credential <<<<< <<<<<

  static const String stripeUrl = "https://api.stripe.com/v1/payment_intents";

  static String stripeMerchantCountryCode = AdminSettingsApi.adminSettingModel?.data?.currency?.countryCode ?? "";
  static String stripeCurrencyCode = AdminSettingsApi.adminSettingModel?.data?.currency?.currencyCode ?? "";
  static String stripeTestSecretKey = AdminSettingsApi.adminSettingModel?.data?.stripeSecretKey ?? "";
  static String stripeTestPublicKey = AdminSettingsApi.adminSettingModel?.data?.stripePublishableKey ?? "";

  // >>>>> >>>>> Flutter Wave Credential <<<<< <<<<<

  //static String flutterWaveId = AdminSettingsApi.adminSettingModel?.data?.flutterWaveId ?? "";
  //static String flutterWaveCurrencyCode = AdminSettingsApi.adminSettingModel?.data?.currency?.currencyCode ?? "";

  // >>>>>> >>>>>> Initialize Live Steaming <<<<<< <<<<<<

  static Future<void> onInitCreateEngine() async {
    await ZegoExpressEngine.createEngineWithProfile(
      ZegoEngineProfile(
        Utils.liveAppId,
        ZegoScenario.Broadcast,
        appSign: kIsWeb ? null : Utils.liveAppSign,
      ),
    );
  }

  // >>>>>> >>>>>> Initialize Payment <<<<<< <<<<<<

  static Future<void> onInitPayment() async {
    if (InternetConnection.isConnect.value) {

    }
  }
}
