import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auralive/custom/custom_image_picker.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/create_hash_tag_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/fetch_hash_tag_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/create_hash_tag_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/fetch_hash_tag_model.dart';
import 'package:auralive/pages/profile_page/api/delete_content_api.dart';
import 'package:auralive/pages/splash_screen_page/api/upload_file_api.dart';
import 'package:auralive/pages/upload_reels_page/api/fetch_ai_caption_api.dart';
import 'package:auralive/pages/upload_reels_page/api/upload_reels_api.dart';
import 'package:auralive/pages/upload_reels_page/model/upload_reels_model.dart';
import 'package:auralive/ui/image_picker_bottom_sheet_ui.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:auralive/utils/utils.dart';

import '../model/fetch_ai_caption_model.dart';

class UploadReelsController extends GetxController {
  UploadReelsModel? uploadReelsModel;
  String? videoThumbnailUrl;

// Parameter
  int videoTime = 0;
  String videoPath = "";
  String videoThumbnail = "";
  String songId = "";

  TextEditingController captionController = TextEditingController();

  FetchHashTagModel? fetchHashTagModel;
  CreateHashTagModel? createHashTagModel;

  bool isLoadingHashTag = false;
  List<HashTagData> hastTagCollection = [];
  List<HashTagData> filterHashtag = [];

  RxBool isShowHashTag = false.obs;
  List<String> userInputHashtag = [];

  FetchAiCaptionModel? fetchAiCaptionModel;
  bool isLoadingAiCaption = false;

  bool isAiCaptionSwitchOn = false;

  bool isVideoUploadSuccess = false;

  @override
  void onInit() {
    init();
    Utils.showLog("Upload Reels Controller Initialized...");
    super.onInit();
  }

  @override
  void onClose() {
    onCancelVideoContent();

    super.onClose();
  }

  Future<void> init() async {
    final arguments = Get.arguments;

    Utils.showLog("Selected Video => $arguments");

    videoPath = arguments["video"] ?? "";
    videoThumbnail = arguments["image"] ?? "";
    videoTime = arguments["time"] ?? "";
    songId = arguments["songId"] ?? "";
    onGetHashTag();

    Utils.showLog("Selected Song Id => $songId");

    onConvertVideoThumbnail();
  }

  Future<void> onConvertVideoThumbnail() async {
    videoThumbnailUrl = await UploadFileApi.callApi(
      filePath: videoThumbnail,
      fileType: 2,
      keyName: "${DateTime.now().millisecondsSinceEpoch}.jpg",
    );

    if (isAiCaptionSwitchOn) onFetchAiCaption();
  }

  void onChangeAiSwitch({bool? value}) async {
    isAiCaptionSwitchOn = value ?? !isAiCaptionSwitchOn;
    update(["onChangeAiSwitch"]);

    if (isAiCaptionSwitchOn) {
      onFetchAiCaption();
    } else {
      captionController.clear();
      update(["onGenerateAiCaption"]);
    }
  }

  void onFetchAiCaption() async {
    if (videoThumbnailUrl?.trim().isNotEmpty == true) {
      isLoadingAiCaption = true;
      update(["onGenerateAiCaption"]);

      fetchAiCaptionModel = await FetchAiCaptionApi.callApi(contentUrl: videoThumbnailUrl ?? "");

      captionController.clear();

      captionController.text = ((fetchAiCaptionModel?.caption ?? "") + (fetchAiCaptionModel?.hashtags?.join(" ") ?? ""));

      isLoadingAiCaption = false;
      update(["onGenerateAiCaption"]);
    }
  }

  void onCancelVideoContent() {
    if (isVideoUploadSuccess == false && videoThumbnailUrl?.trim().isNotEmpty == true) {
      DeleteContentApi.callApi(fileUrl: videoThumbnailUrl ?? "");
    }
  }

  Future<void> onGetHashTag() async {
    fetchHashTagModel = null;
    isLoadingHashTag = true;
    update(["onGetHashTag"]);
    fetchHashTagModel = await FetchHashTagApi.callApi(hashTag: "");

    if (fetchHashTagModel?.data != null) {
      hastTagCollection.clear();
      hastTagCollection.addAll(fetchHashTagModel?.data ?? []);
      Utils.showLog("Hast Tag Collection Length => ${hastTagCollection.length}");
    }
    isLoadingHashTag = false;
    update(["onGetHashTag"]);
  }

  void onSelectHashtag(int index) {
    String text = captionController.text;
    List<String> words = text.split(' ');
    words.removeLast();
    captionController.text = words.join(' ');
    captionController.text = captionController.text + ' ' + ("#${filterHashtag[index].hashTag} ");
    captionController.selection = TextSelection.fromPosition(TextPosition(offset: captionController.text.length));
    isShowHashTag.value = false;
    update(["onChangeHashtag"]);
  }

  void onChangeHashtag() async {
    String text = captionController.text;

    List<String> words = text.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].length > 1 && words[i].indexOf('#') == words[i].lastIndexOf('#')) {
        if (words[i].endsWith('#')) {
          words[i] = words[i].replaceFirst('#', ' #');
        }
      }
    }
    captionController.text = words.join(' ');
    captionController.selection = TextSelection.fromPosition(
      TextPosition(offset: captionController.text.length),
    );

    String updatedText = captionController.text;
    List<String> parts = updatedText.split(' ');

    await 10.milliseconds.delay();

    final caption = parts.where((element) => !element.startsWith('#')).join(' ');
    userInputHashtag = parts.where((element) => element.startsWith('#')).toList();

    final lastWord = parts.last;

    Utils.showLog("Caption => ${caption}");
    Utils.showLog("Last Word => ${lastWord}");

    if (lastWord.startsWith("#")) {
      final searchHashtag = lastWord.substring(1);
      filterHashtag = hastTagCollection.where((element) => (element.hashTag?.toLowerCase() ?? "").contains(searchHashtag.toLowerCase())).toList();
      isShowHashTag.value = true;
      update(["onGetHashTag"]);
    } else {
      filterHashtag.clear();
      isShowHashTag.value = false;
    }
    update(["onChangeHashtag"]);
  }

  void onToggleHashTag(bool value) {
    isShowHashTag.value = value;
  }

  Future<void> onChangeThumbnail(BuildContext context) async {
    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          videoThumbnail = imagePath;
          update(["onChangeThumbnail"]);

          onCancelVideoContent();
          onConvertVideoThumbnail();
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          videoThumbnail = imagePath;
          update(["onChangeThumbnail"]);

          onCancelVideoContent();
          onConvertVideoThumbnail();
        }
      },
    );
  }

  Future<void> onUploadReels() async {
    Utils.showLog("Reels Uploading...");
    if (InternetConnection.isConnect.value) {
      Get.dialog(PopScope(canPop: false, child: const LoadingUi()), barrierDismissible: false); // Start Loading...

      List<String> hashTagIds = [];

      for (int index = 0; index < userInputHashtag.length; index++) {
        final hashTag = userInputHashtag[index];

        Utils.showLog("----------${hashTag}");

        if (hashTag != "" && hashTag.startsWith("#")) {
          final searchHashtag = userInputHashtag[index].substring(1);
          createHashTagModel = null;

          final List<HashTagData> selectedHashTag = hastTagCollection.where((element) => (element.hashTag?.toLowerCase() ?? "") == searchHashtag.toLowerCase()).toList();

          Utils.showLog("**** ${selectedHashTag}");

          if (selectedHashTag.isNotEmpty) {
            hashTagIds.add(selectedHashTag[0].id ?? "");
            Utils.showLog("Already Available HashTag => ${selectedHashTag[0].hashTag} ");
          } else {
            Utils.showLog("New Create HashTag => ${userInputHashtag[index].substring(1)} ");
            createHashTagModel = await CreateHashTagApi.callApi(hashTag: userInputHashtag[index].substring(1));

            if (createHashTagModel?.data?.id != null) {
              hashTagIds.add(createHashTagModel?.data?.id ?? "");
            }
          }
        }
      }

      Utils.showLog("Hast Tag Id => $hashTagIds");

      final videoUrl = await UploadFileApi.callApi(
        filePath: videoPath,
        fileType: 3,
        keyName: "${DateTime.now().millisecondsSinceEpoch}.mp4",
      );

      if (videoThumbnailUrl != null && videoUrl != null) {
        uploadReelsModel = await UploadReelsApi.callApi(
          loginUserId: Database.loginUserId,
          videoImage: videoThumbnailUrl ?? "",
          videoUrl: videoUrl,
          videoTime: videoTime.toString(),
          hashTag: hashTagIds.map((e) => "$e").join(',').toString(),
          caption: captionController.text.trim(),
          songId: songId,
        );
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
      }

      if (uploadReelsModel?.status == true && uploadReelsModel?.data?.id != null) {
        isVideoUploadSuccess = true;
        Utils.showToast(EnumLocal.txtReelsUploadSuccessfully.name.tr);
        Get.close(2);
      } else if (uploadReelsModel?.status == false && uploadReelsModel?.message == "your duration of Video greater than decided by the admin.") {
        Utils.showToast(uploadReelsModel?.message ?? "");
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
      }
      Get.back(); // Stop Loading...
    } else {
      Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
      Utils.showLog("Internet Connection Lost !!");
    }
  }
}

// >>>>>>>>>>>>>>>>>>>>>>>> Old Hashtag Function <<<<<<<<<<<<<<<<<<<<<<<<<<<<<

// for (int index = 0; index < selectedHashTag.length; index++) {
//   if (selectedHashTag[index].id == null && selectedHashTag[index].hashTag != null && selectedHashTag[index].hashTag != "") {
//     createHashTagModel = null;
//     createHashTagModel = await CreateHashTagApi.callApi(hashTag: selectedHashTag[index].hashTag ?? "");
//     if (createHashTagModel?.data?.id != null) {
//       hashTagIds.add(createHashTagModel?.data?.id ?? "");
//     }
//   } else {
//     hashTagIds.add(selectedHashTag[index].id ?? "");
//   }
// }

//   void onSelectHastTag(int index) {
//     selectedHashTag.add(hastTagCollection[index]);
//     update(["onSelectHastTag"]);
//     onCloseHashTagPage();
//   }
//
//   void onCloseHashTagPage() async {
//     hashTagController.clear();
//     FocusManager.instance.primaryFocus?.unfocus();
//     if (Get.currentRoute == "/PreviewHashTagListUi") {
//       Get.back();
//       await 200.milliseconds.delay();
//       FocusManager.instance.primaryFocus?.unfocus();
//     }
//   }
//
//   void onCancelHashTag(int index) {
//     selectedHashTag.removeAt(index);
//     update(["onSelectHastTag"]);
//   }

// void onSubmitHashTag() {
//   if (hashTagController.text.trim().isNotEmpty && hastTagCollection.isNotEmpty) {
//     final userHashTag = hashTagController.text.trim().toLowerCase();
//     final apiHashTag = hastTagCollection[0].hashTag?.toLowerCase();
//     if (userHashTag == apiHashTag) {
//       onSelectHastTag(0);
//     } else {
//       selectedHashTag.add(HashTagData(hashTag: hashTagController.text.trim()));
//       update(["onSelectHastTag"]);
//       onCloseHashTagPage();
//       Utils.showLog("Create New HashTag Success");
//     }
//   } else if (hashTagController.text.trim().isNotEmpty && hastTagCollection.isEmpty) {
//     selectedHashTag.add(HashTagData(hashTag: hashTagController.text.trim()));
//     update(["onSelectHastTag"]);
//     onCloseHashTagPage();
//     Utils.showLog("Create New HashTag Success");
//   }
// }
//
// Future<void> onChangeHashTag() async {
//   Utils.showLog("Typing => ${hashTagController.text}");
//
//   if (hashTagController.text.trim().isNotEmpty) {
//     Utils.showLog("Typing => ${Get.currentRoute}");
//
//     if (Get.currentRoute == "/upload_reels_page") {
//       Get.to(PreviewHashTagListUi());
//     }
//
//     if (hashTagController.text.endsWith(" ")) {
//       if (hastTagCollection.isNotEmpty) {
//         final userHashTag = hashTagController.text.trim().toLowerCase();
//         final apiHashTag = hastTagCollection[0].hashTag?.toLowerCase();
//         if (userHashTag == apiHashTag) {
//           onSelectHastTag(0);
//         } else {
//           selectedHashTag.add(HashTagData(hashTag: hashTagController.text.trim()));
//           update(["onSelectHastTag"]);
//           onCloseHashTagPage();
//           Utils.showLog("Create New HashTag Success");
//         }
//       } else {
//         selectedHashTag.add(HashTagData(hashTag: hashTagController.text.trim()));
//         update(["onSelectHastTag"]);
//         onCloseHashTagPage();
//         Utils.showLog("Create New HashTag Success");
//       }
//     } else {
//       await onGetHashTag();
//     }
//   } else if (hashTagController.text.isEmpty) {
//     await onGetHashTag();
//   }
// }

// Future<void> onCreateHashTag() async {
//   FocusManager.instance.primaryFocus?.unfocus();
//
//   Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...
//
//   createHashTagModel = await CreateHashTagApi.callApi(hashTag: hashTagController.text.trim());
//   if (createHashTagModel?.data?.id != null) {
//     Utils.showLog("Create Hast Tag Success ${createHashTagModel?.data?.id}");
//
//     selectedHashTag.add(
//       HashTagData(
//         id: createHashTagModel?.data?.id,
//         hashTag: createHashTagModel?.data?.hashTag,
//       ),
//     );
//     update(["onSelectHastTag"]);
//
//     hashTagController.clear();
//   }
//   Get.back(); // Stop Loading...
// }
