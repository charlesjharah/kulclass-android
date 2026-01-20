import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/google_ad/google_ad_setting_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

// *** >>> Google Ad Code <<< ***

class GoogleAdSettingApi {
  static GoogleAdSettingModel? googleAdSettingModel;
  static Future<void> callApi() async {
    Utils.showLog("Get Google Ad Settings Api Calling...");

    final uri = Uri.parse(Api.googleAdSetting);

    Utils.showLog("Get Google Ad Settings Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Google Ad Settings Response => ${response.body}");

        googleAdSettingModel = GoogleAdSettingModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Google Ad Settings StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Google Ad Settings Error => $error");
    }
  }
}
