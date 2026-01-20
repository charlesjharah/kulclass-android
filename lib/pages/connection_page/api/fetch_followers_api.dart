import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/connection_page/model/fetch_followers_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchFollowersApi {
  static Future<FetchFollowersModel?> callApi({required String userId}) async {
    Utils.showLog("Get Followers Api Calling...");

    final uri = Uri.parse("${Api.connection}?userId=$userId&type=followerList");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Followers Api Response => ${response.body}");

        return FetchFollowersModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Followers Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Followers Api Error => $error");
    }
    return null;
  }
}
