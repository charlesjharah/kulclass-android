import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auralive/custom/custom_image_picker.dart';
import 'package:auralive/pages/edit_reels_page/api/edit_reels_api.dart';
import 'package:auralive/pages/edit_reels_page/model/edit_reels_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/create_hash_tag_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/fetch_hash_tag_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/create_hash_tag_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/fetch_hash_tag_model.dart';
import 'package:auralive/pages/splash_screen_page/api/upload_file_api.dart';
import 'package:auralive/ui/image_picker_bottom_sheet_ui.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:auralive/utils/utils.dart';

class EditReelsController extends GetxController {
  EditReelsModel? editReelsModel;

  String videoCaption = "";
  String videoUrl = "";
  String videoId = "";
  String videoThumbnail = "";
  String? selectedImage;

  TextEditingController captionController = TextEditingController();

  FetchHashTagModel? fetchHashTagModel;
  CreateHashTagModel? createHashTagModel;

  bool isLoadingHashTag = false;
  List<HashTagData> hastTagCollection = [];
  List<HashTagData> filterHashtag = [];

  RxBool isShowHashTag = false.obs;
  List<String> userInputHashtag = [];

  @override
  void onInit() {
    init();
    Utils.showLog("Upload Reels Controller Initialized...");
    super.onInit();
  }

  Future<void> init() async {
    final arguments = Get.arguments;

    Utils.showLog("Selected Video => $arguments");

    videoUrl = arguments["video"] ?? "";
    videoThumbnail = arguments["image"] ?? "";
    videoCaption = arguments["caption"] ?? "";
    videoId = arguments["videoId"] ?? "";
    captionController.text = videoCaption;

    onGetHashTag();
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
          selectedImage = imagePath;
          videoThumbnail = imagePath;
          update(["onChangeThumbnail"]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          selectedImage = imagePath;
          videoThumbnail = imagePath;
          update(["onChangeThumbnail"]);
        }
      },
    );
  }

  Future<void> onEditUploadReels() async {
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

      if (selectedImage != null) {
        final image = await UploadFileApi.callApi(
          filePath: selectedImage ?? "",
          fileType: 2,
          keyName: "${DateTime.now().millisecondsSinceEpoch}.jpg",
        );
        await onCallEditApi(hashTag: hashTagIds.map((e) => "$e").join(',').toString(), image: image);
      } else {
        await onCallEditApi(hashTag: hashTagIds.map((e) => "$e").join(',').toString(), image: selectedImage);
      }
    } else {
      Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
      Utils.showLog("Internet Connection Lost !!");
    }
  }

  Future<void> onCallEditApi({required String hashTag, String? image}) async {
    editReelsModel = await EditReelsApi.callApi(
      loginUserId: Database.loginUserId,
      videoImage: image,
      videoId: videoId,
      hashTag: hashTag,
      caption: captionController.text.trim(),
    );

    if (editReelsModel?.status == true && editReelsModel?.data?.id != null) {
      Utils.showToast(EnumLocal.txtReelsUploadSuccessfully.name.tr);
      Get.close(2);
    } else if (editReelsModel?.status == false && editReelsModel?.message == "your duration of Video greater than decided by the admin.") {
      Utils.showToast(editReelsModel?.message ?? "");
    } else {
      Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
    }

    Get.back(); // Stop Loading...
  }
}
