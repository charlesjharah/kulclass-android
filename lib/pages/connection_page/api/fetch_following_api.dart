import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/connection_page/model/fetch_following_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchFollowingApi {
  static Future<FetchFollowingModel?> callApi({required String userId}) async {
    Utils.showLog("Get Following Api Calling...");

    final uri = Uri.parse("${Api.connection}?userId=$userId&type=followingList");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Following Api Response => ${response.body}");

        return FetchFollowingModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Following Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Following Api Error => $error");
    }
    return null;
  }
}
