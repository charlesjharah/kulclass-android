import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auralive/pages/splash_screen_page/model/fetch_login_user_profile_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/pages/splash_screen_page/api/fetch_login_user_profile_api.dart';
import 'package:auralive/utils/utils.dart';

import 'constant.dart';

class Database {
  static final localStorage = GetStorage();

  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  static Future<void> init(String identity, String fcmToken) async {
    Utils.showLog("Local Database Initialize....");

    onSetFcmToken(fcmToken);
    onSetIdentity(identity);

    Utils.showLog("Is New User => $isNewUser");

    if (isNewUser == false) {
      fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(loginUserId: loginUserId);
    }
  }

  // >>>>> >>>>> Get Language Database <<<<< <<<<<

  static String get selectedLanguage => localStorage.read("language") ?? AppConstant.languageEn;
  static String get selectedCountryCode => localStorage.read("countryCode") ?? AppConstant.countryCodeEn;

  // >>>>> >>>>> Get Login Database <<<<< <<<<<

  static String get fcmToken => localStorage.read("fcmToken") ?? "";
  static String get identity => localStorage.read("identity") ?? "";

  static bool get isNewUser => localStorage.read("isNewUser") ?? true;
  static int get loginType => localStorage.read("loginType") ?? 0;
  static String get loginUserId => localStorage.read("loginUserId") ?? "";

  // >>>>> >>>>> Set Language Database <<<<< <<<<<

  static onSetSelectedLanguage(String language) async => await localStorage.write("language", language);
  static onSetSelectedCountryCode(String countryCode) async => await localStorage.write("countryCode", countryCode);

  // >>>>> >>>>> Set Login Database <<<<< <<<<<

  static onSetFcmToken(String fcmToken) async => await localStorage.write("fcmToken", fcmToken);
  static onSetIdentity(String identity) async => await localStorage.write("identity", identity);

  static onSetIsNewUser(bool isNewUser) async => await localStorage.write("isNewUser", isNewUser);
  static onSetLoginType(int loginType) async => localStorage.write("loginType", loginType);
  static onSetLoginUserId(String loginUserId) async => localStorage.write("loginUserId", loginUserId);

  // >>>>> >>>>> Network Image Database <<<<< <<<<<

  static String? networkImage(String image) => localStorage.read(image);

  static onSetNetworkImage(String image) async => localStorage.write(image, image);

  // >>>>> >>>>> Notification Database <<<<< <<<<<

  static bool get isShowNotification => localStorage.read("isShowNotification") ?? true;

  static onSetNotification(bool isShowNotification) async => localStorage.write("isShowNotification", isShowNotification);

  // >>>>> >>>>> Search Message User History Database <<<<< <<<<<

  static List get searchMessageUserHistory => localStorage.read("searchMessageUsers") ?? [];
  static onSetSearchMessageUserHistory(List searchMessageUsers) async => localStorage.write("searchMessageUsers", searchMessageUsers);

  // >>>>> >>>>> In App Purchase History Database <<<<< <<<<<

  static onSetIsPurchase(bool isPurchase) async => await localStorage.write("isPurchase", isPurchase);

  // >>>>> >>>>> Log Out User Database <<<<< <<<<<

  static Future<void> onLogOut() async {
    final _identity = identity;
    final _fcmToken = fcmToken;

    if (loginType == 2) {
      Utils.showLog("Google Logout Success");
      await GoogleSignIn().signOut();
    }

    localStorage.erase();

    onSetFcmToken(_fcmToken);
    onSetIdentity(_identity);

    Get.offAllNamed(AppRoutes.loginPage);
  }
}
