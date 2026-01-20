import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/edit_post_page/model/edit_post_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class EditPostApi {
  static Future<EditPostModel?> callApi({
    required String loginUserId,
    required String postId,
    required String caption,
    required String hashTag,
  }) async {
    try {
      Utils.showLog("Edit Post Api Calling...");

      final uri = Uri.parse("${Api.editPost}?userId=$loginUserId&postId=$postId");

      final headers = {'key': Api.secretKey, 'Content-Type': 'application/json'};

      final body = json.encode({'caption': caption, 'hashTagId': hashTag});

      Utils.showLog("Edit Post Api Uri => $uri");
      Utils.showLog("Edit Post Api Body => $body");

      final response = await http.patch(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Edit Post Api Response => ${response.body}");
        return EditPostModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Edit Post Api Status Code Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Edit Post Api Error => $e");
      return null;
    }
  }
}

// try {
//   final headers = {'key': Api.secretKey, 'Content-Type': 'application/json'};
//
//   final uri = Uri.parse("${Api.editPost}?userId=$loginUserId&postId=$postId");
//   final request = http.Request('PATCH', uri);
//
//   final Map<String, dynamic> body = {};
//
//   if (caption != null) body['caption'] = caption;
//   if (hashTag != null) body['hashtag'] = hashTag;
//
//   request.body = jsonEncode(body);
//   request.headers.addAll(headers);
//
//   log("Request URI: $uri");
//   log("User ID: $loginUserId");
//   log("Post ID: $postId");
//   log("Request Body: $body");
//
//   final response = await request.send();
//   final responseBody = await response.stream.bytesToString();
//
//   Utils.showLog("Update Post Api Response => $responseBody");
//   Utils.showLog("Update Post Api Status Code => ${response.statusCode}");
//
//   if (response.statusCode == 200) {
//     final jsonResult = jsonDecode(responseBody);
//     return EditPostModel.fromJson(jsonResult);
//   } else {
//     Utils.showLog("Update Post Api Response Error: ${response.statusCode} - $responseBody");
//     return null;
//   }
// } catch (e) {
//   Utils.showLog("Update Post Api Error => $e");
//   return null;
// }
