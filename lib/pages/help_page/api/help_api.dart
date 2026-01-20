import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/help_page/model/help_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class HelpApi {
  static Future<HelpModel?> callApi({
    required String loginUserId,
    required String complaint,
    required String contact,
    String? image,
  }) async {
    Utils.showLog("Help Api Calling...");

    try {
      var headers = {'key': Api.secretKey};

      var request = http.MultipartRequest('POST', Uri.parse("${Api.help}"));
      request.fields.addAll({
        'userId': loginUserId,
        'complaint': complaint,
        'contact': contact,
      });

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResult = jsonDecode(responseBody);
        Utils.showLog("Help Api Response => ${jsonResult}");
        return HelpModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Help Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Help Api Error => $e");
      return null;
    }
  }
}
