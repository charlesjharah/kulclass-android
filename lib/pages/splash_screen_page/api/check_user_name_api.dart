import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/splash_screen_page/model/check_user_name_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class CheckUserNameApi {
  static Future<CheckUserNameModel?> callApi({required String loginUserId, required String userName}) async {
    Utils.showLog("Check User Name Api Calling...");

    final uri = Uri.parse("${Api.checkUserNameExit}?userId=$loginUserId&userName=$userName");

    Utils.showLog("Check User Name Api Response => ${uri}");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Check User Name Api Response => ${response.body}");

        return CheckUserNameModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Check User Name Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Check User Name Api Error => $error");
    }
    return null;
  }
}
