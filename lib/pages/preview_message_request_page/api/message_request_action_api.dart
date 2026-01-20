import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/preview_message_request_page/model/message_request_action_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class MessageRequestActionApi {
  static Future<MessageRequestActionModel?> callApi({required String topicId, required bool isAccept}) async {
    Utils.showLog("Message Request Action Api Calling... $topicId");

    final type = isAccept ? "accept" : "decline";

    final uri = Uri.parse("${Api.messageRequestAction}?messageRequestTopicId=$topicId&type=$type");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Message Request Action Api Response => ${response.body}");

        final jsonResponse = json.decode(response.body);

        return MessageRequestActionModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Message Request Action Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Message Request Action Api Error => $error");
    }
    return null;
  }
}
