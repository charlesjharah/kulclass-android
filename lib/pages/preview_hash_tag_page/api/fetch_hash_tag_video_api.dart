import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/preview_hash_tag_page/model/fetch_hash_tag_video_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchHashTagVideoApi {
  static Future<FetchHashTagVideoModel?> callApi({required String loginUserId, required String hashTagId}) async {
    Utils.showLog("Get Hash Tag Video Api Calling...");

    final uri = Uri.parse("${Api.fetchHashTagVideo}?userId=$loginUserId&hashTagId=$hashTagId");

    Utils.showLog("Get Hash Tag Video Api Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Hash Tag Video Api Response => ${response.body}");

        return FetchHashTagVideoModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Hash Tag Video Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Hash Tag Video Api Error => $error");
    }
    return null;
  }
}
