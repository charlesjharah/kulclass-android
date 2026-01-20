import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/audio_wise_videos_page/model/fetch_audio_wise_videos_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchAudioWiseVideosApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchAudioWiseVideosModel?> callApi({
    required String loginUserId,
    required String songId,
  }) async {
    Utils.showLog("Fetch Audio Wise Videos Api Calling...");
    startPagination += 1;

    final uri = Uri.parse("${Api.audioWiseVideos}?userId=$loginUserId&songId=$songId&start=$startPagination&limit=$limitPagination");

    Utils.showLog("Fetch Audio Wise Videos Api Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Audio Wise Videos Api Response => ${response.body}");

        return FetchAudioWiseVideosModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Audio Wise Videos Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Audio Wise Videos Api Error => $error");
    }
    return null;
  }
}
