import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/custom/custom_format_chat_time.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/preview_message_request_page/controller/preview_message_request_controller.dart';
import 'package:auralive/pages/preview_message_request_page/widget/preview_message_request_widget.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class PreviewMessageRequestView extends GetView<PreviewMessageRequestController> {
  const PreviewMessageRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        flexibleSpace: RequestUserAppBarUi(),
      ),
      body: Column(
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
                    child: GetBuilder<PreviewMessageRequestController>(
                      id: "onGetChats",
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
                                                      isBanned: chat.isChatMediaBanned ?? false,
                                                      time: CustomFormatChatTime.convert(
                                                        chat.createdAt ?? DateTime.now().toString(),
                                                      ),
                                                    )
                                                  : ReceiverImageUi(
                                                      image: chat.image ?? "",
                                                      time: CustomFormatChatTime.convert(
                                                        chat.createdAt ?? DateTime.now().toString(),
                                                      ),
                                                      isBanned: chat.isChatMediaBanned ?? false,
                                                    )
                                              : chat.messageType == 3
                                                  ? chat.senderUserId == Database.loginUserId // Audio Message...
                                                      ? SenderAudioUi(
                                                          id: chat.id ?? "",
                                                          audio: Api.baseUrl + (chat.audio ?? ""),
                                                          time: CustomFormatChatTime.convert(
                                                            chat.createdAt ?? DateTime.now().toString(),
                                                          ),
                                                        )
                                                      : ReceiverAudioUi(
                                                          id: chat.id ?? "",
                                                          audio: Api.baseUrl + (chat.audio ?? ""),
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
          Column(
            children: [
              BlurryContainer(
                color: AppColor.primary.withOpacity(0.1),
                blur: 3,
                width: Get.width,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15),
                borderRadius: BorderRadius.circular(0),
                child: Center(
                    child: Text(
                  "${EnumLocal.txtAcceptMessageRequestFrom.name.tr} (${controller.receiverName})?",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.styleW500(AppColor.black, 14.2),
                )),
              ),
              3.height,
              BlurryContainer(
                height: 70,
                width: Get.width,
                color: AppColor.primary.withOpacity(0.09),
                blur: 5,
                borderRadius: BorderRadius.circular(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButtonUi(
                      title: EnumLocal.txtIgnore.name.tr,
                      callback: () => Get.back(),
                      color: AppColor.colorTextLightGrey,
                    ),
                    ActionButtonUi(
                      title: EnumLocal.txtDelete.name.tr,
                      color: AppColor.colorTextRed,
                      callback: () => controller.onActionMessageRequest(isAccept: false),
                    ),
                    ActionButtonUi(
                      title: EnumLocal.txtAccept.name.tr,
                      gradient: AppColor.primaryLinearGradient,
                      callback: () => controller.onActionMessageRequest(isAccept: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionButtonUi extends StatelessWidget {
  const ActionButtonUi({super.key, required this.title, required this.callback, this.color, this.gradient});

  final String title;
  final Callback callback;
  final Color? color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppFontStyle.styleW600(AppColor.white, 16),
        ),
      ),
    );
  }
}
