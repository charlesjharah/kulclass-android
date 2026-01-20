import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/edit_post_page/api/edit_post_api.dart';
import 'package:auralive/pages/feed_page/model/post_image_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/create_hash_tag_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/fetch_hash_tag_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/create_hash_tag_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/fetch_hash_tag_model.dart';
import 'package:auralive/pages/edit_post_page/model/edit_post_model.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/internet_connection.dart';
import 'package:auralive/utils/utils.dart';

class EditPostController extends GetxController {
  List<PostImage> selectedImages = [];
  EditPostModel? editPostModel;

  String caption = "";
  String postId = "";

  bool isLoadingHashTag = false;
  List<HashTagData> hastTagCollection = [];
  List<HashTagData> filterHashtag = [];

  RxBool isShowHashTag = false.obs;
  List<String> userInputHashtag = [];

  FetchHashTagModel? fetchHashTagModel;
  CreateHashTagModel? createHashTagModel;

  TextEditingController captionController = TextEditingController();
  TextEditingController hashTagController = TextEditingController();

  @override
  void onInit() {
    init();
    super.onInit();

    Utils.showLog("Upload Post Controller Initialized...");
  }

  Future<void> init() async {
    Utils.showLog("Selected Images Length => ${Get.arguments["images"].length}");

    captionController.clear();

    if (Get.arguments["images"] != null) {
      selectedImages.addAll(Get.arguments["images"]);
    }
    if (Get.arguments["postId"] != null) {
      postId = Get.arguments["postId"];
    }
    if (Get.arguments["caption"] != null) {
      caption = Get.arguments["caption"];
      captionController = TextEditingController(text: caption);
    }
    onGetHashTag();
    createHashTagModel = null;
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
      if (words[i].length > 1 && // condition 1: word length not 1
          words[i].indexOf('#') == words[i].lastIndexOf('#')) {
        // condition 2: word uses # only one time
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

    // if (words.last[words.last.length - 1] == "#") {
    //   words.last[words.last.length - 1]
    // }

    // List<String> words = text.split(RegExp(r'(\s|(?=#))'));

    await 10.milliseconds.delay();

    final caption = parts.where((element) => !element.startsWith('#')).join(' ');
    userInputHashtag = parts.where((element) => element.startsWith('#')).toList();

    final lastWord = parts.last;

    Utils.showLog("Caption => ${caption}");
    Utils.showLog("Last Word => ${lastWord}");

    if (lastWord.startsWith("#")) {
      Utils.showLog("----------------------");

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

  Future<void> onGetHashTag() async {
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

  Future<void> onEditPost() async {
    Utils.showLog(EnumLocal.txtPostUploading.name.tr);
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

      editPostModel = await EditPostApi.callApi(
        loginUserId: Database.loginUserId,
        postId: postId,
        hashTag: hashTagIds.map((e) => "$e").join(',').toString(),
        caption: captionController.text.trim(),
      );

      if (editPostModel?.status == true) {
        Utils.showToast(EnumLocal.txtPostUploadSuccessfully.name.tr);
        Get.close(2);
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
