import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/splash_screen_page/model/fetch_user_coin_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchUserCoinApi {
  static Future<FetchUserCoinModel?> callApi({required String loginUserId}) async {
    Utils.showLog("Fetch User Coin Api Calling...");

    final uri = Uri.parse("${Api.fetchUserCoin}?userId=$loginUserId");

    Utils.showLog("Fetch User Coin Api Url => ${uri}");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch User Coin Api Response => ${response.body}");

        return FetchUserCoinModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch User Coin Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch User Coin Api Error => $error");
    }
    return null;
  }
}
