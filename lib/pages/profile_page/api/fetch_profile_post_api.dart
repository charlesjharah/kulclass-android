import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/profile_page/model/fetch_profile_post_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/utils.dart';

class FetchProfilePostApi {
  static Future<FetchProfilePostModel?> callApi({required String userId}) async {
    Utils.showLog("Get Profile Post Api Calling...");

    final uri = Uri.parse("${Api.profilePost}?userId=${Database.loginUserId}&toUserId=$userId");

    Utils.showLog("Get Profile Post Api Calling => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Profile Post Api Response => ${response.body}");

        return FetchProfilePostModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Profile Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Profile Post Api Error => $error");
    }
    return null;
  }
}
