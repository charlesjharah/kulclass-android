import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/profile_page/model/delete_post_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class DeletePostApi {
  static Future<DeletePostModel?> callApi({required String postId}) async {
    Utils.showLog("Delete Post Api Calling... ");

    final uri = Uri.parse("${Api.deletePost}?postId=$postId");

    final headers = {"key": Api.secretKey};

    try {
      var response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Delete Post Api Response => ${response.body}");

        return DeletePostModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Delete Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Delete Post Api Error => $error");
    }
    return null;
  }
}
