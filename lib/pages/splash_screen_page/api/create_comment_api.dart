import 'package:http/http.dart' as http;
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class CreateCommentApi {
  static Future<void> callApi({
    required String loginUserId,
    required int commentType,
    required String commentTypeId,
    required String commentText,
  }) async {
    Utils.showLog("Create Comment Api Calling...");

    final queryParameters = commentType == 1
        ? "?userId=$loginUserId&type=post&postId=$commentTypeId&commentText=$commentText"
        : "?userId=$loginUserId&type=video&videoId=$commentTypeId&commentText=$commentText";

    final uri = Uri.parse(Api.createComment + queryParameters);

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Create Comment Api Response => ${response.body}");
      } else {
        Utils.showLog("Create Comment Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Create Comment Api Error => $error");
    }
  }
}
