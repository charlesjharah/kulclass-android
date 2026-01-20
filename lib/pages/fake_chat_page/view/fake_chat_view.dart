import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auralive/custom/custom_format_audio_time.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/fake_chat_page/controller/fake_chat_controller.dart';
import 'package:auralive/pages/fake_chat_page/widget/fake_chat_widget.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/custom/custom_format_chat_time.dart';

class FakeChatView extends GetView<FakeChatController> {
  const FakeChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          surfaceTintColor: AppColor.transparent,
          shadowColor: AppColor.black.withOpacity(0.4),
          flexibleSpace: const ChatAppBarUi(),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Stack(
                      children: [
                        Image.asset(AppAsset.icChatBackGround, fit: BoxFit.cover, width: Get.width),
                        SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: GetBuilder<FakeChatController>(
                            id: "onGetUserChats",
                            builder: (controller) => controller.isLoading
                                ? LoadingUi()
                                : controller.userChats.isEmpty
                                    ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                                    : SingleChildScrollView(
                                        controller: controller.scrollController,
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                                        child: ListView.builder(
                                          itemCount: controller.userChats.length,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final chat = controller.userChats[index];
                                            return chat.messageType == 1 // Text Message...
                                                ? chat.senderUserId == Database.loginUserId
                                                    ? SenderMessageUi(
                                                        message: chat.message ?? "",
                                                        time: CustomFormatChatTime.convert(
                                                          chat.createdAt ?? DateTime.now().toString(),
                                                        ),
                                                      )
                                                    : ReceiverMessageUi(
                                                        message: chat.message ?? "",
                                                        time: CustomFormatChatTime.convert(
                                                          chat.createdAt ?? DateTime.now().toString(),
                                                        ),
                                                      )
                                                : chat.messageType == 2 // Image Message...
                                                    ? chat.senderUserId == Database.loginUserId
                                                        ? SenderImageUi(
                                                            image: chat.image ?? "",
                                                            time: CustomFormatChatTime.convert(
                                                              chat.createdAt ?? DateTime.now().toString(),
                                                            ),
                                                          )
                                                        : ReceiverImageUi(
                                                            image: chat.image ?? "",
                                                            time: CustomFormatChatTime.convert(
                                                              chat.createdAt ?? DateTime.now().toString(),
                                                            ),
                                                          )
                                                    : chat.messageType == 3
                                                        ? chat.senderUserId == Database.loginUserId // Audio Message...
                                                            ? SenderAudioUi(
                                                                id: chat.id ?? "",
                                                                audio: (chat.audio ?? ""),
                                                                time: CustomFormatChatTime.convert(
                                                                  chat.createdAt ?? DateTime.now().toString(),
                                                                ),
                                                              )
                                                            : ReceiverAudioUi(
                                                                id: chat.id ?? "",
                                                                audio: (chat.audio ?? ""),
                                                                time: CustomFormatChatTime.convert(
                                                                  chat.createdAt ?? DateTime.now().toString(),
                                                                ),
                                                              )
                                                        : UploadAudioUi();
                                          },
                                        ),
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const MessageTextFieldUi()
              ],
            ),
          ),
          Positioned(
            top: 20,
            child: GetBuilder<FakeChatController>(
              id: "onChangeAudioRecordingEvent",
              builder: (controller) => Visibility(
                visible: controller.isRecordingAudio,
                child: Container(
                  height: 40,
                  width: 110,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.colorBorder.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppAsset.icMicOn,
                        color: AppColor.primary,
                        width: 20,
                      ),
                      5.width,
                      Text(
                        CustomFormatAudioTime.convert(controller.countTime),
                        style: AppFontStyle.styleW500(AppColor.black, 13),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
