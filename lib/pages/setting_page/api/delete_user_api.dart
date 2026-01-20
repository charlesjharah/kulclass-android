import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/setting_page/model/delete_user_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class DeleteUserApi {
  static Future<DeleteUserModel?> callApi({required String loginUserId}) async {
    Utils.showLog("Delete User Api Calling... ");

    final uri = Uri.parse("${Api.deleteUser}?userId=$loginUserId");

    final headers = {"key": Api.secretKey};

    try {
      var response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Delete User Api Response => ${response.body}");

        return DeleteUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Delete User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Delete User Api Error => $error");
    }
    return null;
  }
}
