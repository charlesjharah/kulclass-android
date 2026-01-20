import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/create_reels_page/model/fetch_favorite_sound_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchFavoriteSoundApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchFavoriteSoundModel?> callApi({required String loginUserId}) async {
    Utils.showLog("Fetch Favorite Sound Api Calling...");

    startPagination++;
    final uri = Uri.parse("${Api.fetchFavoriteSound}?start=$startPagination&limit=$limitPagination&userId=$loginUserId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Favorite Sound Api Response => ${response.body}");

        return FetchFavoriteSoundModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Favorite Sound Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Favorite Sound Api Error => $error");
    }
    return null;
  }
}
