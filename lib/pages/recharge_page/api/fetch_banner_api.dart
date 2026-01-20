import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/recharge_page/model/fetch_banner_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchBannerApi {
  static Future<FetchBannerModel?> callApi() async {
    Utils.showLog("Get Banner Api Calling...");

    final uri = Uri.parse(Api.fetchBanner);

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Banner Api Response => ${response.body}");

        return FetchBannerModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Banner Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Banner Api Error => $error");
    }
    return null;
  }
}
