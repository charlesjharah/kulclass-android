import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/splash_screen_page/model/fetch_report_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchReportApi {
  static Future<FetchReportModel?> callApi() async {
    Utils.showLog("Get Report Api Calling...");

    final uri = Uri.parse(Api.fetchReport);

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Report Api Response => ${response.body}");

        return FetchReportModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Report Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Report Api Error => $error");
    }
    return null;
  }
}
