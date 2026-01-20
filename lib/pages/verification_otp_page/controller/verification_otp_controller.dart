import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auralive/pages/login_page/api/login_api.dart';
import 'package:auralive/pages/login_page/model/login_model.dart';
import 'package:auralive/pages/splash_screen_page/api/fetch_login_user_profile_api.dart';
import 'package:auralive/pages/splash_screen_page/model/fetch_login_user_profile_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:auralive/utils/utils.dart';

class VerificationOtpController extends GetxController {
  String phoneNumber = "";
  String verificationId = "";
  TextEditingController otpController = TextEditingController();

  int otpCountTime = 29;
  Timer? timer;
  LoginModel? loginModel;
  FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  @override
  void onInit() {
    phoneNumber = Get.arguments["phoneNumber"] ?? "";
    verificationId = Get.arguments["verificationId"] ?? "";
    onCountTime();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    otpCountTime = 30;
    super.onClose();
  }

  Future<void> onResendCode() async {
    FocusManager.instance.primaryFocus?.unfocus();

    Utils.showLog("Mobile Number => $phoneNumber");

    try {
      Get.dialog(LoadingUi(color: AppColor.primary), barrierDismissible: false); // Start Loading...

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 5),
        verificationCompleted: (PhoneAuthCredential credential) {
          Utils.showLog("Verification Complete");
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == "invalid-phone-number") {
            Utils.showToast(EnumLocal.txtPleaseEnterCorrectMobileNumber.name.tr, AppColor.coloGreyText);
          } else {
            Utils.showLog("Verification Mobile Number Failed => $e");
          }
          Get.back(); // Start Loading...
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;

          Utils.showLog("Verification Id => ${this.verificationId}");

          Utils.showToast(EnumLocal.txtVerificationCodeSend.name.tr, AppColor.coloGreyText);

          onCountTime();

          Get.back(); // Start Loading...
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Utils.showLog("Verification Mobile Number Failed => $e");
      Get.back(); // Start Loading...
    }
  }

  Future<void> onMobileLogin() async {
    if (InternetConnection.isConnect.value) {
      Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...

      loginModel = await LoginApi.callApi(
        loginType: 1,
        email: "",
        mobileNumber: phoneNumber,
        identity: Database.identity,
        fcmToken: Database.fcmToken,
      );

      Get.back(); // Stop Loading...

      if (loginModel?.status == true && loginModel?.user?.id != null) {
        await onGetProfile(loginUserId: loginModel!.user!.id!); // Get Profile Api...
      } else if (loginModel?.message == "You are blocked by the admin.") {
        Utils.showToast(loginModel?.message ?? "", AppColor.coloGreyText);
        Utils.showLog("User Blocked By Admin !!");
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr, AppColor.coloGreyText);
        Utils.showLog("Login Api Calling Failed !!");
      }
    } else {
      Utils.showToast(EnumLocal.txtConnectionLost.name.tr, AppColor.coloGreyText);
      Utils.showLog("Internet Connection Lost !!");
    }
  }

  Future<void> onGetProfile({required String loginUserId}) async {
    Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...
    fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(loginUserId: loginUserId);
    Get.back(); // Stop Loading...

    if (fetchLoginUserProfileModel?.user?.id != null && fetchLoginUserProfileModel?.user?.loginType != null) {
      Database.onSetIsNewUser(false);
      Database.onSetLoginUserId(fetchLoginUserProfileModel!.user!.id!);
      Database.onSetLoginType(int.parse((fetchLoginUserProfileModel?.user?.loginType ?? 0).toString()));
      Database.fetchLoginUserProfileModel = fetchLoginUserProfileModel;

      if (fetchLoginUserProfileModel?.user?.country == "" || fetchLoginUserProfileModel?.user?.bio == "") {
        Get.toNamed(AppRoutes.fillProfilePage);
      } else {
        Get.offAllNamed(AppRoutes.bottomBarPage);
      }
    } else {
      Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr, AppColor.coloGreyText);
      Utils.showLog("Get Profile Api Calling Failed !!");
    }
  }

  Future<void> onClickSubmit() async {
    FocusManager.instance.primaryFocus?.unfocus();

    Utils.showLog("Enter Otp => ${otpController.text}");

    if (otpController.text.trim().isEmpty) {
      Utils.showToast(EnumLocal.txtPleaseEnterVerificationCode.name.tr, AppColor.coloGreyText);
    } else {
      final String phoneNumber = Get.arguments["verificationId"] ?? "";

      Utils.showLog("Mobile Number => $phoneNumber");

      try {
        Get.dialog(LoadingUi(color: AppColor.primary), barrierDismissible: false); // Start Loading...

        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text.trim());
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        Utils.showLog("Verification Success => ${userCredential.user?.uid}");

        Get.back(); // Start Loading...

        onMobileLogin();
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-verification-code") {
          Utils.showToast("Invalid Verification Code", AppColor.coloGreyText);
        } else if (e.code == "session-expired") {
          Utils.showToast(e.message ?? "", AppColor.coloGreyText);
        } else {
          Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr, AppColor.coloGreyText);
        }

        Get.back(); // Start Loading...
      }
    }
  }

  void onCountTime() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (otpCountTime > 0) {
          otpCountTime--;
        } else {
          this.timer?.cancel();
          otpCountTime = 30;
        }
        update(["onCountTime"]);
      },
    );
  }
}
