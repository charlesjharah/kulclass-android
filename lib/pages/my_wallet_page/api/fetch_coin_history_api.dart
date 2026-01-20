import 'dart:convert';
import 'package:auralive/pages/my_wallet_page/model/fetch_coin_history_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:auralive/utils/utils.dart';

class FetchCoinHistoryApi {
  static Future<FetchCoinHistoryModel?> callApi({
    required String loginUserId,
    required String startDate,
    required String endDate,
  }) async {
    Utils.showLog("Get Coin History Api Calling...");

    final uri = Uri.parse("${Api.fetchCoinHistory}?startDate=$startDate&endDate=$endDate&userId=$loginUserId");

    final headers = {"key": Api.secretKey};

    Utils.showLog("Get Coin History Api Url => $uri");

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Coin History Api Response => ${response.body}");

        return FetchCoinHistoryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Coin History Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Coin History Api Error => $error");
    }
    return null;
  }
}
