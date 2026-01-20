import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/create_reels_page/model/search_sound_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class SearchSoundApi {
  static Future<SearchSoundModel?> callApi({required String loginUserId, required String searchText}) async {
    Utils.showLog("Search Sound Api Calling...");

    final uri = Uri.parse("${Api.searchSound}?searchString=$searchText&userId=$loginUserId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Search Sound Api Response => ${response.body}");

        return SearchSoundModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Search Sound Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Search Sound Api Error => $error");
    }
    return null;
  }
}
