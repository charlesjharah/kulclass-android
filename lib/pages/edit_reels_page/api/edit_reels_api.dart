import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/edit_reels_page/model/edit_reels_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class EditReelsApi {
  static Future<EditReelsModel?> callApi({
    required String loginUserId,
    required String videoId,
    required String caption,
    required String hashTag,
    String? videoImage,
  }) async {
    try {
      Utils.showLog("Edit Reels Api Calling...");

      final headers = {
        'key': Api.secretKey,
        'Content-Type': 'multipart/form-data',
      };

      final uri = Uri.parse("${Api.editReels}?userId=$loginUserId&videoId=$videoId");

      var request = http.MultipartRequest('PATCH', uri);

      request.fields['caption'] = caption;
      request.fields['hashTagId'] = hashTag;

      if (videoImage != null) {
        request.files.add(await http.MultipartFile.fromPath('videoImage', videoImage));
      }

      request.headers.addAll(headers);

      Utils.showLog("Edit Reels Api Request URI => $uri");
      Utils.showLog("Edit Reels Api Request Body => ${request.fields}");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      Utils.showLog("Edit Reels Api Response => $responseBody");
      Utils.showLog("Edit Reels Api Status Code => ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseBody);

        return EditReelsModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Edit Reels Api Status Code Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Utils.showLog("Edit Reels Api Error => $e");
      return null;
    }
  }
}

// class EditReelsApi {
//   static Future<EditReelsModel?> callApi({
//     required String loginUserId,
//     required String videoId,
//     required String caption,
//     required String hashTag,
//     required String videoImage,
//   }) async {
//     try {
//       Utils.showLog("Edit Reels Api Calling...");
//
//       final uri = Uri.parse("${Api.editReels}?userId=$loginUserId&videoId=$videoId");
//
//       final headers = {'key': Api.secretKey, 'Content-Type': 'application/json'};
//
//       final body = json.encode({'caption': caption, 'hashtag': hashTag});
//
//       Utils.showLog("Edit Reels Api Uri => $uri");
//       Utils.showLog("Edit Reels Api Body => $body");
//
//       final response = await http.patch(uri, headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//
//         Utils.showLog("Edit Reels Api Response => ${response.body}");
//         return EditReelsModel.fromJson(jsonResponse);
//       } else {
//         Utils.showLog("Edit Reels Api Status Code Error");
//         return null;
//       }
//     } catch (e) {
//       Utils.showLog("Edit Reels Api Error => $e");
//       return null;
//     }
//   }
// }
//
// class EditUploadReelsApi {
//   static Future<EditUploadVideoModel?> updateVideo({
//     required String loginUserId,
//     required String videoId,
//     String? videoImage, // Nullable, only provided if being updated
//     String? caption, // Nullable, only provided if being updated
//     String? hashTag, // Nullable, only provided if being updated
//   }) async {
//     Utils.showLog("Update Video Api Calling...");
//
//     try {
//       var headers = {
//         'key': Api.secretKey,
//         'Content-Type': 'multipart/form-data',
//       };
//
//       var uri = Uri.parse("${Api.updateVideoByUser}?userId=$loginUserId&videoId=$videoId");
//       var request = http.MultipartRequest('PATCH', uri);
//
//       // Adding fields only if they are provided (not null)
//       if (caption != null) {
//         request.fields['caption'] = caption;
//       }
//       if (hashTag != null) {
//         request.fields['hashtag'] = hashTag;
//       }
//       if (videoImage != null) {
//         request.files.add(await http.MultipartFile.fromPath('videoImage', videoImage));
//       }
//
//       request.headers.addAll(headers);
//
//       log("Request URI: $uri");
//       log("User ID: $loginUserId");
//       log("Video ID: $videoId");
//
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//
//       Utils.showLog("Update Video Api Response => $responseBody");
//       Utils.showLog("Update Video Api Status Code => ${response.statusCode}");
//
//       if (response.statusCode == 200) {
//         final jsonResult = jsonDecode(responseBody);
//         return EditUploadVideoModel.fromJson(jsonResult);
//       } else {
//         Utils.showLog("Update Video Api Response Error: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       Utils.showLog("Update Video Api Error => $e");
//       return null;
//     }
//   }
// }
