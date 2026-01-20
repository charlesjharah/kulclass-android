import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // <- add this
import 'package:http/http.dart' as http;
import 'package:auralive/pages/login_page/model/login_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:auralive/utils/utils.dart';

class LoginApi {
  static Future<LoginModel?> callApi({
    required int loginType,
    required String email,
    required String identity,
    required String fcmToken,
    String? mobileNumber,
    String? userName,
  }) async {
    Utils.showLog("Login Api Calling...");

    final uri = Uri.parse(Api.login);
    final headers = {"key": Api.secretKey, "Content-Type": "application/json"};

    final body = mobileNumber != null
        ? json.encode({
      'mobileNumber': mobileNumber,
      'loginType': loginType,
      'identity': identity,
      "fcmToken": fcmToken,
    })
        : (userName == null)
        ? json.encode({
      'email': email,
      'loginType': loginType,
      'identity': identity,
      "fcmToken": fcmToken,
    })
        : json.encode({
      'email': email,
      'loginType': loginType,
      'identity': identity,
      "fcmToken": fcmToken,
      "name": userName,
      "userName": userName,
    });

    try {
      if (InternetConnection.isConnect.value) {
        Utils.showLog("Login Api Body => $body");

        final response = await http.post(uri, headers: headers, body: body);

        if (response.statusCode == 200) {
          Utils.showLog("Login Api Response => ${response.body}");
          final jsonResponse = json.decode(response.body);
          final loginModel = LoginModel.fromJson(jsonResponse);

          // --- STORE EMAIL if present ---
          final storage = GetStorage();
          final respEmail = loginModel.user?.email;
          if (respEmail != null && respEmail.isNotEmpty) {
            storage.write('user_email', respEmail);
            Utils.showLog("Stored Email => $respEmail");
          } else {
            Utils.showLog("No email present in login response.");
          }

                    // 2. Get coin value (It is an 'int?', not a String)
          final respCoin = loginModel.user?.coin;

          // 3. FIX: Only check for null. Do NOT check .isNotEmpty on numbers.
          if (respCoin != null) {
            storage.write('user_coin', respCoin);
            Utils.showLog("Stored Coin => $respCoin");
          } else {
            Utils.showLog("No coin present in login response.");
          }




          final respCountry = loginModel.user?.country;
          if (respCountry != null && respCountry.isNotEmpty) {
            storage.write('user_country', respCountry);
            Utils.showLog("Stored Country => $respCountry");
          } else {
            Utils.showLog("No country present in login response.");
          }


          return loginModel;
        } else {
          Utils.showLog(">>>>> Login Api StateCode Error <<<<<");
        }
      } else {
        Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
      }
    } catch (error) {
      Utils.showLog("Login Api Error => $error");
    }
    return null;
  }
}
