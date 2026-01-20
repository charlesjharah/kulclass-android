import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auralive/pages/splash_screen_page/model/upload_file_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/utils.dart';

class UploadFileApi {
  static UploadFileModel? uploadFileModel;
  static Future<String?> callApi({required String filePath, required int fileType, required String keyName}) async {
    Utils.showLog("Upload File Api Calling...");

    Utils.showLog("Upload File Api => filePath => $filePath \n fileType => $fileType \n keyName => $keyName");

    final type = fileUploadType(fileType);

    try {
      var headers = {'key': Api.secretKey};

      var request = http.MultipartRequest('PUT', Uri.parse(Api.uploadFile));

      request.fields.addAll({'folderStructure': type, 'keyName': keyName});

      request.files.add(await http.MultipartFile.fromPath('content', filePath));

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResult = jsonDecode(responseBody);
        Utils.showLog("Upload File Api Response => ${jsonResult}");
        uploadFileModel = UploadFileModel.fromJson(jsonResult);
        return uploadFileModel?.url;
      } else {
        Utils.showLog("Upload File Api Status Code Error");
      }
    } catch (e) {
      Utils.showLog("Upload File Api Error");
    }

    return null;
  }

  static String fileUploadType(int type) {
    return type == 1
        ? Api.profileContent
        : type == 2
            ? Api.videoImageContent
            : type == 3
                ? Api.videoUrlContent
                : type == 4
                    ? Api.postContent
                    : type == 5
                        ? Api.chatContent
                        : type == 6
                            ? Api.verificationContent
                            : type == 7
                                ? Api.complaintContent
                                : type == 8
                                    ? Api.storyContent
                                    : "";
  }
}

// WORKING CODE WITH DIO

// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:auralive/pages/splash_screen_page/model/upload_file_model.dart';
// import 'package:auralive/utils/api.dart';
// import 'package:auralive/utils/utils.dart';

// class UploadFileApi {
//   static final Dio _dio = Dio();
//   static UploadFileModel? uploadFileModel;
//
//   static Future<String?> callApi({
//     required String filePath,
//     required int fileType,
//     required String keyName,
//     Function(int process)? function,
//   }) async {
//     Utils.showLog("Upload File API Calling...");
//
//     try {
//       final type = _fileUploadType(fileType);
//
//       // Prepare form data
//       final formData = FormData.fromMap({
//         'folderStructure': type,
//         'keyName': keyName,
//         'content': await MultipartFile.fromFile(
//           filePath,
//           filename: filePath.split('/').last,
//         ),
//       });
//
//       print("formData******************* ${formData.files}");
//
//       // Set headers
//       final headers = {'key': Api.secretKey};
//
//       // Make the request
//       final response = await _dio.put(
//         Api.uploadFile,
//         data: formData,
//         options: Options(headers: headers),
//         onSendProgress: (int sent, int total) async {
//           final progress = ((sent / total) * 100).toInt();
//           function?.call(progress);
//
//           // Utils.showLog("Upload Progress: $progress% ($sent/$total bytes)");
//         },
//       );
//
//       // Handle successful response
//       if (response.statusCode == 200) {
//         final jsonResult = response.data;
//         Utils.showLog("Upload File Api Response => $jsonResult");
//
//         uploadFileModel = UploadFileModel.fromJson(jsonResult);
//         return uploadFileModel?.url;
//       } else {
//         Utils.showLog("Upload failed with status code ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       Utils.showLog("Error occurred: ${e.toString()}");
//       return null;
//     }
//   }
//
//   static String _fileUploadType(int type) {
//     return type == 1
//         ? Api.profileContent
//         : type == 2
//             ? Api.videoImageContent
//             : type == 3
//                 ? Api.videoUrlContent
//                 : type == 4
//                     ? Api.postContent
//                     : type == 5
//                         ? Api.chatContent
//                         : type == 6
//                             ? Api.verificationContent
//                             : type == 7
//                                 ? Api.complaintContent
//                                 : type == 8
//                                     ? Api.storyContent
//                                     : "";
//   }
// }
