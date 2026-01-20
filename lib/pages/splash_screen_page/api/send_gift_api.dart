import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/pages/splash_screen_page/model/send_gift_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class SendGiftApi {
  static Future<SendGiftModel?> callApi(
      {required String loginUserId, required String videoId, required String giftId}) async {
    Utils.showLog("Send Gift Api Calling... $videoId");

    final uri = Uri.parse("${Api.sendGift}?videoId=$videoId&userId=$loginUserId&giftId=$giftId");

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Send Gift Api Response => ${response.body}");

        final jsonResponse = json.decode(response.body);

        return SendGiftModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Send Gift Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Send Gift Api Error => $error");
    }
    return null;
  }
}
