import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/profile_page/model/fetch_profile_collection_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchProfileCollectionApi {
  static Future<FetchProfileCollectionModel?> callApi({required String userId}) async {
    Utils.showLog("Get Profile Collection Api Calling...");

    final uri = Uri.parse("${Api.profileCollection}?userId=$userId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Profile Collection Api Response => ${response.body}");

        return FetchProfileCollectionModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Profile Collection Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Profile Collection Api Error => $error");
    }
    return null;
  }
}
