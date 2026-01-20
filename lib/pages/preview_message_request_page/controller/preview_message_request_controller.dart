import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/preview_message_request_page/api/fetch_request_user_chat_api.dart';
import 'package:auralive/pages/preview_message_request_page/api/message_request_action_api.dart';
import 'package:auralive/pages/preview_message_request_page/model/fetch_request_user_chat_model.dart';
import 'package:auralive/pages/preview_message_request_page/model/message_request_action_model.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/socket_services.dart';
import 'package:auralive/utils/utils.dart';

class PreviewMessageRequestController extends GetxController {
  ScrollController scrollController = ScrollController();
  String currentPlayAudioId = ""; // This is use to one time only one play audio...
  MessageRequestActionModel? messageRequestActionModel;

  FetchRequestUserChatModel? fetchRequestUserChatModel;
  List<Chat> userChats = [];
  bool isLoading = false;

  String chatRoomId = "";
  String receiverUserId = "";
  String receiverName = "";
  String receiverUserName = "";
  String receiverImage = "";
  bool isVerify = false;
  bool isProfileImageBanned = false;

  @override
  void onInit() {
    if (Get.arguments["chatRoomId"] != null &&
        Get.arguments["receiverUserId"] != null &&
        Get.arguments["receiverName"] != null &&
        Get.arguments["receiverUserName"] != null &&
        Get.arguments["receiverImage"] != null &&
        Get.arguments["isVerify"] != null) {
      chatRoomId = Get.arguments["chatRoomId"];
      receiverUserId = Get.arguments["receiverUserId"];
      receiverName = Get.arguments["receiverName"];
      receiverUserName = Get.arguments["receiverUserName"];
      receiverImage = Get.arguments["receiverImage"];
      isVerify = Get.arguments["isVerify"];
      isProfileImageBanned = Get.arguments["isProfileImageBanned"];
    }

    init();

    super.onInit();
  }

  void init() {
    onGetChats();
  }

  Future<void> onGetChats() async {
    fetchRequestUserChatModel = null;
    isLoading = true;
    update(["onGetChats"]);
    fetchRequestUserChatModel = await FetchRequestUserChatApi.callApi(chatTopicId: chatRoomId);

    if (fetchRequestUserChatModel?.chat != null) {
      final chat = fetchRequestUserChatModel?.chat ?? [];
      userChats.insertAll(0, chat.reversed.toList());
      isLoading = false;
      update(["onGetChats"]);
      onScrollDown();
      if (userChats.last.id != null) {
        SocketServices.onReadMessageRequest(messageId: userChats.last.id ?? "");
      }
    }
  }

  Future<void> onActionMessageRequest({required bool isAccept}) async {
    Get.dialog(LoadingUi()); // Start Loading...
    messageRequestActionModel = await MessageRequestActionApi.callApi(topicId: chatRoomId, isAccept: isAccept);
    Get.back(); // Stop Loading...

    if (messageRequestActionModel?.status == true) {
      Utils.showToast(messageRequestActionModel?.message ?? "");
      Get.close(2);
    }
  }

  Future<void> onScrollDown() async {
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }
}
