import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/shimmer/user_list_shimmer_ui.dart';
import 'package:auralive/pages/message_page/controller/message_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/pages/message_page/widget/message_widget.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/constant.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.find<BottomBarController>().onChangeBottomBar(0);
      },
      child: Scaffold(
        body: RefreshIndicator(
          color: AppColor.primary,
          onRefresh: () async => controller.init(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: Get.height + 1 - AppConstant.bottomBarSize, // This Is Use To Active Refresh Indicator
              child: Column(
                children: [
                  GetBuilder<MessageController>(
                    id: "onChangeSearchHistory",
                    builder: (controller) => SafeArea(
                      bottom: false,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          height: controller.isShowSearchMessageUserHistory ? 215 : 52,
                          decoration: BoxDecoration(
                            color: controller.isShowSearchMessageUserHistory ? AppColor.colorUnselectedIcon.withOpacity(0.05) : AppColor.transparent,
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: controller.isShowSearchMessageUserHistory ? AppColor.colorBorder.withOpacity(0.5) : AppColor.transparent,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetBuilder<MessageController>(
                                id: "onSearching",
                                builder: (controller) => SearchMessageUserUi(
                                  controller: controller.searchController,
                                  callback: () => controller.onChangeSearchHistory(true),
                                  isShowClearIcon: controller.isSearching,
                                  onChanged: (String value) => controller.onSearching(),
                                  onClickClear: () {
                                    controller.searchController.clear();
                                    controller.onChangeSearchHistory(false);
                                    controller.onSearching();
                                  },
                                  onCompleteSearch: (value) {
                                    controller.onChangeSearchHistory(false);
                                    controller.onCreateSearchHistory();
                                  },
                                ),
                              ),
                              const Expanded(child: SearchHistoryUi())
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GetBuilder<MessageController>(
                        id: "onGetMessageUsers",
                        builder: (controller) {
                          final isRequestAvailable = controller.messageRequestCount != 0;
                          return Visibility(
                            visible: controller.isLoading == false,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.messageRequestPage),
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                child: Text(
                                  isRequestAvailable ? "${EnumLocal.txtRequests.name.tr}(${controller.messageRequestCount})" : EnumLocal.txtRequests.name.tr,
                                  style: AppFontStyle.styleW500(AppColor.primary, 14),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      10.width,
                    ],
                  ),
                  GetBuilder<MessageController>(
                    id: "onSearching",
                    builder: (controller) => controller.isSearching
                        ? Expanded(
                            child: GetBuilder<MessageController>(
                              id: "onSearchMessageUser",
                              builder: (controller) => controller.isSearchingMessageUser
                                  ? UserListShimmerUi()
                                  : controller.searchMessageUsers.isEmpty
                                      ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                                      : SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: ListView.builder(
                                            itemCount: controller.searchMessageUsers.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              final searchUser = controller.searchMessageUsers[index];
                                              return MessageUserUi(
                                                title: searchUser.name ?? "",
                                                subTitle: searchUser.userName ?? "",
                                                leading: searchUser.image ?? "",
                                                isVerified: searchUser.isVerified ?? false,
                                                callback: () {
                                                  Get.toNamed(
                                                    AppRoutes.chatPage,
                                                    arguments: {
                                                      "id": searchUser.id,
                                                      "name": searchUser.name,
                                                      "userName": searchUser.userName,
                                                      "image": searchUser.image,
                                                      "isBlueTik": searchUser.isVerified,
                                                      "isProfileImageBanned": searchUser.isProfileImageBanned,
                                                    },
                                                  );
                                                },
                                                isProfileImageBanned: searchUser.isProfileImageBanned ?? false,
                                              );
                                            },
                                          ),
                                        ),
                            ),
                          )
                        : Expanded(
                            child: GetBuilder<MessageController>(
                              id: "onGetMessageUsers",
                              builder: (controller) => controller.isLoading
                                  ? UserListShimmerUi()
                                  : controller.messageUsers.isEmpty
                                      ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                                      : SingleChildScrollView(
                                          controller: controller.scrollController,
                                          child: ListView.builder(
                                            itemCount: controller.messageUsers.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              final messageUser = controller.messageUsers[index];
                                              return MessageUserUi(
                                                title: messageUser.name ?? "",
                                                subTitle: messageUser.message == null || messageUser.message == "" ? (messageUser.userName ?? "") : (messageUser.message ?? ""),
                                                leading: messageUser.image ?? "",
                                                messageCount: messageUser.unreadCount,
                                                dateTime: messageUser.time ?? "",
                                                isVerified: messageUser.isVerified ?? false,
                                                callback: () {
                                                  if (messageUser.isFake == true) {
                                                    Get.toNamed(
                                                      AppRoutes.fakeChatPage,
                                                      arguments: {
                                                        "id": messageUser.userId,
                                                        "name": messageUser.name,
                                                        "userName": messageUser.userName,
                                                        "image": messageUser.image,
                                                        "isBlueTik": messageUser.isVerified,
                                                        "isProfileImageBanned": messageUser.isProfileImageBanned,
                                                      },
                                                    )?.then((value) => controller.init());
                                                  } else {
                                                    print("************* ${messageUser.isProfileImageBanned}");

                                                    Get.toNamed(
                                                      AppRoutes.chatPage,
                                                      arguments: {
                                                        "id": messageUser.userId,
                                                        "name": messageUser.name,
                                                        "userName": messageUser.userName,
                                                        "image": messageUser.image,
                                                        "isBlueTik": messageUser.isVerified,
                                                        "isProfileImageBanned": messageUser.isProfileImageBanned ?? false,
                                                      },
                                                    )?.then((value) => controller.init());
                                                  }
                                                },
                                                isProfileImageBanned: messageUser.isProfileImageBanned ?? false,
                                              );
                                            },
                                          ),
                                        ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GetBuilder<MessageController>(
          id: "onPagination",
          builder: (controller) => Visibility(
            visible: controller.isPaginationLoading,
            child: LinearProgressIndicator(color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
