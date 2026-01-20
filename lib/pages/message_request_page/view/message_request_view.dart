import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/message_page/widget/message_widget.dart';
import 'package:auralive/pages/message_request_page/controller/message_request_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/shimmer/user_list_shimmer_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/constant.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class MessageRequestView extends GetView<MessageRequestController> {
  const MessageRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtRequests.name.tr),
      ),
      body: RefreshIndicator(
        color: AppColor.primary,
        onRefresh: () async => controller.init(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height + 1 - AppConstant.bottomBarSize, // This Is Use To Active Refresh Indicator
            child: GetBuilder<MessageRequestController>(
              id: "onGetMessageRequest",
              builder: (controller) => controller.isLoading
                  ? UserListShimmerUi()
                  : controller.messageRequest.isEmpty
                      ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                      : RefreshIndicator(
                          color: AppColor.primary,
                          onRefresh: () async => controller.init(),
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              itemCount: controller.messageRequest.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => MessageUserUi(
                                title: controller.messageRequest[index].name ?? "",
                                subTitle: controller.messageRequest[index].message == ""
                                    ? (controller.messageRequest[index].userName ?? "")
                                    : (controller.messageRequest[index].message ?? ""),
                                leading: controller.messageRequest[index].image ?? "",
                                isVerified: controller.messageRequest[index].isVerified ?? false,
                                messageCount: controller.messageRequest[index].unreadCount ?? 0,
                                dateTime: controller.messageRequest[index].time ?? "",
                                callback: () {
                                  Get.toNamed(
                                    AppRoutes.previewMessageRequestPage,
                                    arguments: {
                                      "chatRoomId": controller.messageRequest[index].chatRequestTopicId ?? "",
                                      "receiverUserId": controller.messageRequest[index].userId ?? "",
                                      "receiverName": controller.messageRequest[index].name ?? "",
                                      "receiverUserName": controller.messageRequest[index].userName ?? "",
                                      "receiverImage": controller.messageRequest[index].image ?? "",
                                      "isVerify": controller.messageRequest[index].isVerified ?? false,
                                      "isProfileImageBanned": controller.messageRequest[index].isProfileImageBanned ?? false,
                                    },
                                  );
                                },
                                isProfileImageBanned: controller.messageRequest[index].isProfileImageBanned ?? false,
                              ),
                            ),
                          ),
                        ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<MessageRequestController>(
        id: "onGetMessageRequest",
        builder: (controller) => Visibility(
          visible: controller.messageRequest.isNotEmpty,
          child: SizedBox(
            height: 80,
            child: Center(
              child: GestureDetector(
                onTap: controller.onDeleteAllRequest,
                child: BlurryContainer(
                  color: AppColor.colorRedContainer.withOpacity(0.08),
                  blur: 6,
                  width: 230,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Text(
                      EnumLocal.txtDeleteAll.name.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.styleW600(AppColor.colorRedContainer, 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
