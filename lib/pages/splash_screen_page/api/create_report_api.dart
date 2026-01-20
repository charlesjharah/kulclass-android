import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class CreateReportApi {
  static Future<bool?> callApi({
    required String loginUserId,
    required String reportReason,
    required int eventType,
    required String eventId,
  }) async {
    Utils.showLog("Create Report Api Calling...");

    final queryParameters = (eventType == 1
        ? "?userId=$loginUserId&type=video&reportReason=$reportReason&videoId=$eventId" // Video Report.
        : eventType == 2
            ? "?type=post&reportReason=$reportReason&userId=$loginUserId&postId=$eventId" // Post Report.
            : "?userId=$loginUserId&type=user&reportReason=$reportReason&toUserId=$eventId"); // User Report.

    final uri = Uri.parse(Api.createReport + queryParameters);

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Create Report Api Response => ${response.body}");

        final jsonResponse = jsonDecode(response.body);

        return jsonResponse["status"];
      } else {
        Utils.showLog("Create Report Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Create Report Api Error => $error");
    }
    return null;
  }
}
