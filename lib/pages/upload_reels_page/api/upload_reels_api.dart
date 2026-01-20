import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/upload_reels_page/model/upload_reels_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class UploadReelsApi {
  static Future<UploadReelsModel?> callApi({
    required String loginUserId,
    required String videoImage,
    required String videoUrl,
    required String videoTime,
    required String hashTag,
    required String caption,
    required String songId,
  }) async {
    Utils.showLog("Upload Reels Api Calling...");

    try {
      final headers = {"key": Api.secretKey, "Content-Type": "application/json"};

      final uri = Uri.parse("${Api.uploadReels}?userId=$loginUserId");

      final body = songId != ""
          ? json.encode({
              'songId': songId,
              'caption': caption,
              'hashTagId': hashTag,
              'videoTime': videoTime,
              'videoImage': videoImage,
              'videoUrl': videoUrl,
            })
          : json.encode({
              'caption': caption,
              'hashTagId': hashTag,
              'videoTime': videoTime,
              'videoImage': videoImage,
              'videoUrl': videoUrl,
            });

      Utils.showLog("Upload Reels Api Uri => ${uri}");

      Utils.showLog("Upload Reels Api Body => ${body}");

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);

        Utils.showLog("Upload Reels Api Response => ${jsonResult}");

        return UploadReelsModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Upload Reels Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Upload Reels Api Error => $e");
      return null;
    }
  }
}
