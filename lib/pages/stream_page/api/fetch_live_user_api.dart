import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/stream_page/model/fetch_live_user_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchLiveUserApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchLiveUserModel?> callApi({required String loginUserId}) async {
    Utils.showLog("Get Live User Api Calling...");

    startPagination++;

    final uri = Uri.parse("${Api.fetchLiveUser}?userId=$loginUserId&start=$startPagination&limit=$limitPagination");

    Utils.showLog("Get Live User Api Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Live User Api Response => ${response.body}");

        return FetchLiveUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Live User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Live User Api Error => $error");
    }
    return null;
  }
}
