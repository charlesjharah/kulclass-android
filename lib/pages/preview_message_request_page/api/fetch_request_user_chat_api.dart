import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/preview_message_request_page/model/fetch_request_user_chat_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FetchRequestUserChatApi {
  static Future<FetchRequestUserChatModel?> callApi({required String chatTopicId}) async {
    Utils.showLog("Get Request User Chat Api Calling...");

    final uri = Uri.parse("${Api.fetchRequestUserChat}?topicId=$chatTopicId");

    Utils.showLog("Get Request User Chat Api Url => $uri");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Request User Chat Api Response => ${response.body}");

        return FetchRequestUserChatModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Request User Chat Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Request User Chat Api Error => $error");
    }
    return null;
  }
}
