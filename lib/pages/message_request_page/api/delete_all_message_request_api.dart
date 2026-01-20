import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/message_request_page/model/delete_all_message_request_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class DeleteAllMessageRequestApi {
  static Future<DeleteAllMessageRequestModel?> callApi({required String loginUserId}) async {
    Utils.showLog("Delete All Message Request Api Calling... ");

    final uri = Uri.parse("${Api.deleteAllMessageRequest}?userId=$loginUserId");

    final headers = {"key": Api.secretKey};

    try {
      var response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Delete All Message Request Api Response => ${response.body}");

        return DeleteAllMessageRequestModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Delete All Message Request Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Delete All Message Request Api Error => $error");
    }
    return null;
  }
}
