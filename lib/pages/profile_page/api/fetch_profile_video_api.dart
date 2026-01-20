import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/profile_page/model/fetch_profile_video_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchProfileVideoApi {
  static Future<FetchProfileVideoModel?> callApi({
    required String loginUserId,
    required String toUserId,
  }) async {
    Utils.showLog("Get Profile Video Api Calling...");

    final uri = Uri.parse("${Api.profileVideo}?userId=$loginUserId&toUserId=$toUserId");

    Utils.showLog("Get Profile Video Api Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Profile Video Api Response => ${response.body}");

        return FetchProfileVideoModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Profile Video Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Profile Video Api Error => $error");
    }
    return null;
  }
}
