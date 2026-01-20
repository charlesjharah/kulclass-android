import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/preview_hash_tag_page/model/fetch_hash_tag_post_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchHashTagPostApi {
  static Future<FetchHashTagPostModel?> callApi({required String loginUserId, required String hashTagId}) async {
    Utils.showLog("Get Hash Tag Post Api Calling...");

    final uri = Uri.parse("${Api.fetchHashTagPost}?userId=$loginUserId&hashTagId=$hashTagId");

    Utils.showLog("Get Hash Tag Post Api Uri => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Hash Tag Post Api Response => ${response.body}");

        return FetchHashTagPostModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Hash Tag Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Hash Tag Post Api Error => $error");
    }
    return null;
  }
}
