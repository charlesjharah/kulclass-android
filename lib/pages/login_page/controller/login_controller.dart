import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auralive/pages/login_page/api/check_user_exist_api.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/pages/splash_screen_page/api/fetch_login_user_profile_api.dart';
import 'package:auralive/pages/splash_screen_page/model/fetch_login_user_profile_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/pages/login_page/api/login_api.dart';
import 'package:auralive/pages/login_page/model/login_model.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:auralive/utils/utils.dart';


class LoginController extends GetxController {
  LoginModel? loginModel;
  FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  List<String> randomNames = [
    "Emily Johnson",
    "Liam Smith",
    "Isabella Martinez",
    "Noah Brown",
    "Sofia Davis",
    "Oliver Wilson",
    "Mia Anderson",
    "James Thomas",
    "Ava Robinson",
    "Benjamin Lee",
    "Charlotte Miller",
    "Lucas Garcia",
    "Amelia White",
    "Ethan Harris",
    "Harper Clark",
    "Alexander Lewis",
    "Evelyn Walker",
    "Daniel Hall",
    "Grace Young",
    "Michael Allen",
  ];

  String onGetRandomName() {
    Random random = new Random();
    int index = random.nextInt(randomNames.length);
    return randomNames[index];
  }

  Future<void> onQuickLogin() async {
    if (InternetConnection.isConnect.value) {
      Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...

      // Calling Sign Up Api...

      final isLogin = await CheckUserExistApi.callApi(identity: Database.identity) ?? false;

      Utils.showLog("Quick Login User Is Exist => ${isLogin}");

      Utils.showLog("Database.identity => ${Database.identity}");
      Utils.showLog("Database.fcmToken => ${Database.fcmToken}");


      loginModel = isLogin
          ? await LoginApi.callApi(
              loginType: 3,
              email: Database.identity,
              identity: Database.identity,
              fcmToken: Database.fcmToken,
            )
          : await LoginApi.callApi(
              loginType: 3,
              email: Database.identity,
              identity: Database.identity,
              fcmToken: Database.fcmToken,
              userName: onGetRandomName(),
            );

      Get.back(); // Stop Loading...

      if (loginModel?.status == true && loginModel?.user?.id != null) {
        await onGetProfile(loginUserId: loginModel!.user!.id!); // Get Profile Api...
      } else if (loginModel?.message == "You are blocked by the admin.") {
        Utils.showToast("${loginModel?.message}");
        Utils.showLog("User Blocked By Admin !!");
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
        Utils.showLog("Login Api Calling Failed !!");
      }
    } else {
      Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
      Utils.showLog("Internet Connection Lost !!");
    }
  }

  Future<void> onGoogleLogin() async {
    Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...

    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential == null) {
      Utils.showLog("Google Login: UserCredential is null - cancelled or failed.");
      Get.back();
      return;
    }

    final email = userCredential.user?.email;
    final name = userCredential.user?.displayName;

    if (email == null || name == null) {
      Utils.showToast("Could not get Google account details. Please try again.");
      Utils.showLog("Google Login: Missing email or displayName");
      Get.back();
      return;
    }

    // ✅ Now check internet only before calling backend API
    if (!InternetConnection.isConnect.value) {
      Utils.showToast("No internet connection. Please try again.");
      Utils.showLog("Internet Connection Lost before backend call.");
      Get.back();
      return;
    }

    loginModel = await LoginApi.callApi(
      loginType: 2,
      email: email,
      identity: Database.identity,
      fcmToken: Database.fcmToken,
      userName: name,
    );

    Get.back(); // Stop Loading...

    if (loginModel?.status == true && loginModel?.user?.id != null) {
      await onGetProfile(loginUserId: loginModel!.user!.id!);
    } else if (loginModel?.message == "You are blocked by the admin.") {
      Utils.showToast("Your account is blocked by the admin.");
      Utils.showLog("User Blocked By Admin !!");
    } else {
      Utils.showToast("Something went wrong. Please try again.");
      Utils.showLog("Login Api Calling Failed !!");
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
      Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
      Utils.showLog("Get Profile Api Calling Failed !!");
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      Utils.showLog("Starting Google Sign-In process...");

      // Sign out to reset Google Sign-In state
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Utils.showLog("Signed out existing Google and Firebase sessions.");

      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Utils.showLog("Google Sign-In cancelled by user or failed to get account.");
        return null;
      }

      Utils.showLog("Google User: ${googleUser.email}");
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      if (googleAuth == null) {
        Utils.showLog("Google Auth object is null.");
        return null;
      }

      Utils.showLog("Google Auth: accessToken=${googleAuth.accessToken}, idToken=${googleAuth.idToken}");
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        Utils.showLog("Google Auth tokens are missing.");
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken!,
        idToken: googleAuth.idToken!,
      );

      Utils.showLog("Attempting Firebase sign-in with Google credential...");
      final result = await FirebaseAuth.instance.signInWithCredential(credential);

      Utils.showLog("Google Login successful. Email: ${result.user?.email}, isNewUser: ${result.additionalUserInfo?.isNewUser}");
      return result;

    }

    catch (error) {
      if (error is FirebaseAuthException) {
        Utils.showLog("Firebase Error: Code=${error.code}, Message=${error.message}");
        if (error.code == 'account-exists-with-different-credential') {
          Utils.showToast("This account is linked to another sign-in method. Try that instead.");
        } else if (error.code == 'invalid-credential') {
          Utils.showToast("Invalid Google credentials. Please try again.");
        } else if (error.code == 'network-request-failed') {
          Utils.showToast("Network error. Please check your internet and try again.");
        } else {
          Utils.showToast("Google sign-in failed. Please try again.");
        }
      } else {
        Utils.showLog("Google Login Error: $error");
        Utils.showToast("Something went wrong with Google sign-in.");
      }
      return null;
    }
  }


  String get viewerCountry {
    return fetchLoginUserProfileModel?.user?.country ?? "United States";
  }
}
