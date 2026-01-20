import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/withdraw_page/model/create_withdraw_request_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class CreateWithdrawRequestApi {
  static Future<CreateWithdrawRequestModel?> callApi({
    required String loginUserId,
    required String coin,
    required String paymentGateway,
    required List<String> paymentDetails,
  }) async {
    Utils.showLog("With Draw Request Api Calling...");

    final uri = Uri.parse(Api.createWithdrawRequest);

    final headers = {"key": Api.secretKey, "Content-Type": "application/json; charset=UTF-8"};

    final body = json.encode({
      "userId": loginUserId,
      "coin": coin,
      "paymentGateway": paymentGateway,
      "paymentDetails": paymentDetails,
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);

      Utils.showLog("Withdraw Request Body => ${body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("With Draw Request Api Response => ${response.body}");
        return CreateWithdrawRequestModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("With Draw Request Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("With Draw Request Api Error => $error");
    }
    return null;
  }
}
