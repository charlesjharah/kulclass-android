import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/recharge_page/model/fetch_coin_plan_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchCoinPlanApi {
  static Future<FetchCoinPlanModel?> callApi() async {
    Utils.showLog("Get Coin Plan Api Calling...");

    final uri = Uri.parse(Api.fetchCoinPlan);

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Coin Plan Api Response => ${response.body}");

        return FetchCoinPlanModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Coin Plan Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Coin Plan Api Error => $error");
    }
    return null;
  }
}
