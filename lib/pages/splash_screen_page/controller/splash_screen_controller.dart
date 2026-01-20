import 'dart:async';
import 'package:get/get.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/pages/splash_screen_page/api/admin_setting_api.dart';
import 'package:auralive/utils/branch_io_services.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:auralive/utils/request.dart';
import 'package:auralive/utils/utils.dart';
import 'package:auralive/utils/platform_device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await AppRequest.notificationPermission();

    // 🔄 Keep retrying if no internet
    while (!InternetConnection.isConnect.value) {
      Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
      Utils.showLog("Internet Connection Lost !! Retrying in 3s...");
      await Future.delayed(const Duration(seconds: 3));
    }

    // 📱 Get device ID and FCM token
    final deviceId = await PlatformDeviceId.getDeviceId;
    final token = await FirebaseMessaging.instance.getToken();

    if (deviceId != null) await Database.onSetIdentity(deviceId);
    if (token != null) await Database.onSetFcmToken(token);

    Utils.showLog("Device Id => $deviceId");
    Utils.showLog("FCM Token => $token");

    try {
      // 🌐 Fetch admin settings
      await AdminSettingsApi.callApi();

      if (AdminSettingsApi.adminSettingModel?.data != null) {
        await Utils.onInitCreateEngine();

        // ⚠️ Only call if you still support payments
        // await Utils.onInitPayment();

        await splashScreen();
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
        Utils.showLog("Admin Setting Api returned null or invalid data.");
      }
    } catch (e, stack) {
      // ❌ Log errors both locally and to Crashlytics
      Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
      Utils.showLog("Admin Settings API failed: $e");
      Utils.showLog(stack.toString());
      await FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
    }
  }

  Future<void> splashScreen() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (Database.isNewUser == false &&
        Database.fetchLoginUserProfileModel?.user?.id != null) {
      BranchIoServices.onListenBranchIoLinks();
      Get.offAllNamed(AppRoutes.bottomBarPage);
    } else {
      Get.offAllNamed(AppRoutes.onBoardingPage);
    }
  }
}
