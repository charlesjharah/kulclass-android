import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/splash_screen_page/model/comment_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchCommentApi {
  static Future<CommentModel?> callApi({required String loginUserId, required int commentType, required String commentTypeId}) async {
    Utils.showLog("Get Comment Api Calling...");

    final queryParameters = commentType == 1 ? "?userId=$loginUserId&type=post&postId=$commentTypeId" : "?userId=$loginUserId&type=video&videoId=$commentTypeId";

    final uri = Uri.parse(Api.fetchComment + queryParameters);

    Utils.showLog("Get Comment Api Response => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Comment Api Response => ${response.body}");

        return CommentModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Comment Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Comment Api Error => $error");
    }
    return null;
  }
}
