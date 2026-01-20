import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/verification_request_page/model/create_verification_request_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class CreateVerificationRequestApi {
  static Future<CreateVerificationRequestModel?> callApi({
    required String loginUserId,
    required String documentId,
    required String nameOnDocument,
    required String address,
    required String profileSelfie,
    required String document,
  }) async {
    Utils.showLog("Create Verification Request Api Calling...");

    try {
      var headers = {'key': Api.secretKey};

      var request = http.MultipartRequest('POST', Uri.parse("${Api.createVerificationRequest}"));

      request.fields.addAll({
        'userId': loginUserId,
        'documentId': documentId,
        'nameOnDocument': nameOnDocument,
        'address': address,
      });

      request.files.add(await http.MultipartFile.fromPath('profileSelfie', profileSelfie));

      request.files.add(await http.MultipartFile.fromPath('document', document));

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResult = jsonDecode(responseBody);
        Utils.showLog("Create Verification Request Api Response => ${jsonResult}");
        return CreateVerificationRequestModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Create Verification Request Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Create Verification Request Api Error => $e");
      return null;
    }
  }
}
