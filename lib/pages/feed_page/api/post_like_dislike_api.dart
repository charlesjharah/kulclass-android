import 'package:http/http.dart' as http;
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class PostLikeDislikeApi {
  static Future<void> callApi({required String loginUserId, required String postId}) async {
    Utils.showLog("Post Like-Dislike Api Calling...");

    final uri = Uri.parse("${Api.postLikeDislike}?userId=$loginUserId&postId=$postId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Post Like-Dislike Api Response => ${response.body}");
      } else {
        Utils.showLog("Post Like-Dislike Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Post Like-Dislike Api Error => $error");
    }
  }
}
