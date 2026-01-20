import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/create_reels_page/model/fetch_all_sound_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchAllSoundApi {
  static Future<FetchAllSoundModel?> callApi({required String loginUserId}) async {
    Utils.showLog("Fetch All Sound Api Calling...");

    final uri = Uri.parse("${Api.fetchAllSound}?userId=$loginUserId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch All Sound Api Response => ${response.body}");

        return FetchAllSoundModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch All Sound Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch All Sound Api Error => $error");
    }
    return null;
  }
}
