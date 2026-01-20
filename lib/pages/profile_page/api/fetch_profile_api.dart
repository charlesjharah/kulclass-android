import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/profile_page/model/fetch_profile_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchProfileApi {
  static Future<FetchProfileModel?> callApi({required String loginUserId, required String otherUserId}) async {
    Utils.showLog("Get Profile Api Calling... $otherUserId :: $loginUserId");

    final uri = Uri.parse("${Api.profile}?userId=$otherUserId&toUserId=$loginUserId");

    Utils.showLog("*** ${uri}");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Profile Response => ${response.body}");

        return FetchProfileModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Profile StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Profile Api Error => $error");
    }
    return null;
  }
}
