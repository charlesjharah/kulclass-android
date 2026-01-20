import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/search_page/model/search_hash_tag_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class SearchHashTagApi {
  static Future<SearchHashTagModel?> callApi({required String loginUserId, required String searchText}) async {
    Utils.showLog("Search Hash Tag Api Calling...");

    final uri = Uri.parse("${Api.searchHashTag}?userId=$loginUserId&hashTagSearchString=$searchText");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Search Hash Tag Api Response => ${response.body}");
        final jsonResponse = json.decode(response.body);

        return SearchHashTagModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Search Hash Tag Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Search Hash Tag Api Error => $error");
    }
    return null;
  }
}
