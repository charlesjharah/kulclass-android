import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/search_page/model/search_user_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class SearchUserApi {
  static Future<SearchUserModel?> callApi({required String loginUserId, required String searchText}) async {
    Utils.showLog("Search User Api Calling...");

    final uri = Uri.parse("${Api.searchUser}?userId=$loginUserId&userSearchString=$searchText");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Search User Api Response => ${response.body}");
        final jsonResponse = json.decode(response.body);

        return SearchUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Search User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Search User Api Error => $error");
    }
    return null;
  }
}
