import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class CreateCoinPlanHistoryApi {
  static Future<bool> callApi(
      {required String loginUserId, required String coinPlanId, required String paymentType}) async {
    Utils.showLog("Create Coin Plan History Api Calling...");

    final uri = Uri.parse(Api.createCoinPlanHistory);

    final headers = {"key": Api.secretKey, "Content-Type": "application/json"};

    final body = json.encode({"userId": loginUserId, "coinPlanId": coinPlanId, "paymentGateway": paymentType});

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        Utils.showLog("Create Coin Plan History Api Response => ${response.body}");

        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse["status"] == true) {
          return true;
        }
      } else {
        Utils.showLog("Create Coin Plan History Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Create Coin Plan History Api Error => $error");
    }
    return false;
  }
}
