import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/splash_screen_page/model/fetch_gift_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchGiftApi {
  static Future<FetchGiftModel?> callApi() async {
    Utils.showLog("Fetch Gift Api Calling...");

    final uri = Uri.parse(Api.fetchGift);

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Gift Api Response => ${response.body}");

        return FetchGiftModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Gift Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Gift Api Error => $error");
    }
    return null;
  }
}
