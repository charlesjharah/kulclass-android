import 'dart:convert';
import 'dart:io'; // ✅ Added for File check
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // ✅ Required for MediaType
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
    Utils.showLog("🚀 Upload Reels Api Started...");
    Utils.showLog("   📍 Video Path: $videoUrl");
    Utils.showLog("   📍 Thumb Path: $videoImage");

    // 1. Validate File Existence
    final videoFile = File(videoUrl);
    if (!await videoFile.exists()) {
      Utils.showLog("❌ ERROR: Video file does not exist at path: $videoUrl");
      return null;
    }

    try {
      final uri = Uri.parse("${Api.uploadReels}?userId=$loginUserId");
      var request = http.MultipartRequest('POST', uri);

      // 2. Add Headers
      request.headers.addAll({
        "key": Api.secretKey,
      });

      // 3. Add Text Fields
      request.fields['caption'] = caption;
      request.fields['hashTagId'] = hashTag;
      request.fields['videoTime'] = videoTime;
      if (songId.isNotEmpty) {
        request.fields['songId'] = songId;
      }

      // 4. Add Video File (Crucial Step)
      // We explicitly set the content type to 'video/mp4' to ensure server acceptance
      var videoStream = await http.MultipartFile.fromPath(
        'videoUrl', // Field name expected by backend
        videoUrl,
        contentType: MediaType('video', 'mp4'), 
      );
      request.files.add(videoStream);
      Utils.showLog("   ✅ Video File Attached (${videoStream.length} bytes)");

      // 5. Add Thumbnail File
      if (videoImage.isNotEmpty) {
        var imageStream = await http.MultipartFile.fromPath(
          'videoImage', // Field name expected by backend
          videoImage,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(imageStream);
        Utils.showLog("   ✅ Image File Attached");
      }

      // 6. Send Request
      Utils.showLog("⏳ Sending Request to Server...");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Utils.showLog("📡 Status Code: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        Utils.showLog("✅ Upload Success: ${jsonResult}");
        return UploadReelsModel.fromJson(jsonResult);
      } else if (response.statusCode == 413) {
        Utils.showLog("❌ ERROR: File too large (413). Check Nginx Config.");
        return null;
      } else {
        Utils.showLog("❌ Upload Failed: ${response.body}");
        return null;
      }
    } catch (e) {
      Utils.showLog("❌ Upload Exception => $e");
      return null;
    }
  }
}
