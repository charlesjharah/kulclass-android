import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

import '../model/fetch_ai_caption_model.dart';

class FetchAiCaptionApi {
  static Future<FetchAiCaptionModel?> callApi({required String contentUrl}) async {
    Utils.showLog("Fetch Ai Caption Api Calling...");

    final uri = Uri.parse("${Api.generateAiCaption}?contentUrl=$contentUrl");

    Utils.showLog("Fetch Ai Caption Api Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Ai Caption Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchAiCaptionModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Ai Caption Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Ai Caption Api Error => $error");
    }
    return null;
  }
}
