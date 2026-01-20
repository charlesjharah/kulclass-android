import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/go_live_page/model/create_live_user_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class CreateLiveUserApi {
  static Future<CreateLiveUserModel?> callApi({required String loginUserId}) async {
    Utils.showLog("Create Live User Api Calling...");

    final uri = Uri.parse("${Api.createLiveUser}?userId=$loginUserId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Create Live User Api Response => ${response.body}");

        final jsonResponse = json.decode(response.body);

        return CreateLiveUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Create Live User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Create Live User Api Error => $error");
    }
    return null;
  }
}
