import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/chat_page/model/fetch_user_chat_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchUserChatApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchUserChatModel?> callApi({required String senderUserId, required String receiverUserId}) async {
    Utils.showLog("Get User Chat Api Calling...");

    Utils.showLog("Get User Chat Api Sender User Id => $senderUserId >>> Receiver User Id => $receiverUserId");

    startPagination++;

    final uri = Uri.parse("${Api.fetchUserChat}?senderUserId=$senderUserId&receiverUserId=$receiverUserId&start=$startPagination&limit=$limitPagination");

    Utils.showLog("Get User Chat Api Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get User Chat Api Response => ${response.body}");

        return FetchUserChatModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get User Chat Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get User Chat Api Error => $error");
    }
    return null;
  }
}
