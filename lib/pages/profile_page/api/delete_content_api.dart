import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/profile_page/model/delete_content_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class DeleteContentApi {
  static DeleteContentModel? deleteContentModel;
  static Future<void> callApi({required String fileUrl}) async {
    Utils.showLog("Delete Content Api Calling... ");
    final uri = Uri.parse("${Api.deleteContent}?fileUrl=$fileUrl");

    Utils.showLog("Delete Content Api Uri => $uri");

    final headers = {"key": Api.secretKey};

    try {
      var response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Delete Content Api Response => ${response.body}");

        deleteContentModel = DeleteContentModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Delete Content Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Delete Content Api Error => $error");
    }
  }
}
