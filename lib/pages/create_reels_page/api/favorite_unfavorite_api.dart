import 'package:http/http.dart' as http;
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FavoriteUnFavoriteApi {
  static Future<void> callApi({required String loginUserId, required String soundId}) async {
    Utils.showLog("Sound Favorite-UnFavorite Api Calling...");

    final uri = Uri.parse("${Api.favoriteUnFavorite}?userId=$loginUserId&songId=$soundId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Sound Favorite-UnFavorite Api Response => ${response.body}");
      } else {
        Utils.showLog("Sound Favorite-UnFavorite Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Sound Favorite-UnFavorite Api Error => $error");
    }
  }
}
