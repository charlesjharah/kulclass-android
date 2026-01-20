import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/chat_page/model/send_file_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class SendFileApi {
  static Future<SendFileModel?> callApi({
    required String senderUserId,
    required String receiverUserId,
    required int messageType,
    required String filePath,
  }) async {
    Utils.showLog("Send File Api Calling...");

    try {
      var headers = {'key': Api.secretKey};

      var request = http.MultipartRequest('POST', Uri.parse("${Api.sendFile}?senderUserId=$senderUserId&receiverUserId=$receiverUserId&messageType=$messageType"));

      if (messageType == 2) {
        request.files.add(await http.MultipartFile.fromPath('image', filePath)); // Message Type Image => 2
      } else {
        request.files.add(await http.MultipartFile.fromPath('audio', filePath)); // Message Type Audio => 3
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        Utils.showLog("Send File Api Response => ${responseBody}");

        final jsonResult = jsonDecode(responseBody);
        return SendFileModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Send File Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Send File Api Error => $e");
      return null;
    }
  }
}
