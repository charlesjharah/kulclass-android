import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/message_page/model/search_message_user_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class SearchMessageUserApi {
  static Future<SearchMessageUserModel?> callApi({required String loginUserId, required String searchText}) async {
    Utils.showLog("Search Message User Api Calling...");

    final uri = Uri.parse("${Api.searchMessageUser}?userId=$loginUserId&searchString=$searchText");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Search Message User Api Response => ${response.body}");
        final jsonResponse = json.decode(response.body);

        return SearchMessageUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Search Message User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Search Message User Api Error => $error");
    }
    return null;
  }
}
