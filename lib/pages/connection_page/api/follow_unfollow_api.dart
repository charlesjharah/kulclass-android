import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class FollowUnfollowApi {
  static Future<void> callApi({required String loginUserId, required String userId}) async {
    Utils.showLog("Paid Follow Api Calling...");

    final uri = Uri.parse(Api.followUnfollow);

    Utils.showLog("Paid Follow Url => $uri");

    final headers = {
      "key": Api.secretKey,
      "Content-Type": "application/json",
    };

    final body = {
      "follower_id": loginUserId,
      "followed_id": userId,
    };

    try {
      final response = await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Utils.showToast(responseData['message'] ?? "Success"); // 👈 show message to user
        Utils.showLog("Paid Follow Api Response => ${response.body}");
      } else {
        final responseData = jsonDecode(response.body);
        Utils.showToast(responseData['message'] ?? "Something went wrong"); // 👈 show error
        Utils.showLog("Paid Follow Api StatusCode Error => ${response.statusCode}");
      }
    } catch (error) {
      Utils.showToast("Network error, please try again."); // 👈 show catch error
      Utils.showLog("Paid Follow Api Error => $error");
    }
  }
}
