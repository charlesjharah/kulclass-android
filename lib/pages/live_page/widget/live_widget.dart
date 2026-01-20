import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:lottie/lottie.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/ui/circle_icon_button_ui.dart';
import 'package:auralive/ui/live_user_send_gift_bottom_sheet_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/live_page/controller/live_controller.dart';
import 'package:auralive/ui/stop_live_streaming_dialog_ui.dart';

import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/socket_services.dart';

class HostLiveUi extends StatelessWidget {
  const HostLiveUi({super.key, required this.liveScreen});

  final Widget liveScreen;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        StopLiveStreamingDialogUi.onShow();
        return false;
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          liveScreen,
          Align(
            alignment: Alignment.center,
            child: LiveUserSendGiftBottomSheetUi.onShowGift(),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 400,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.transparent, AppColor.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 45,
            child: SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 76,
                          decoration: BoxDecoration(
                            color: AppColor.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAsset.icView, width: 20),
                              8.width,
                              Obx(
                                () => Text(
                                  CustomFormatNumber.convert(SocketServices.userWatchCount.value),
                                  maxLines: 1,
                                  style: AppFontStyle.styleW700(AppColor.white, 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GetBuilder<LiveController>(
                          id: "onChangeTime",
                          builder: (controller) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAsset.icClock,
                                width: 22,
                                color: AppColor.white,
                              ),
                              8.width,
                              Padding(
                                padding: const EdgeInsets.only(top: 2, right: 35),
                                child: Text(
                                  controller.onConvertSecondToHMS(controller.countTime),
                                  style: AppFontStyle.styleW600(AppColor.white, 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleIconButtonUi(
                          color: AppColor.black.withOpacity(0.5),
                          icon: AppAsset.icClose,
                          iconColor: AppColor.white,
                          callback: () => StopLiveStreamingDialogUi.onShow(),
                        ),
                      ],
                    ),
                    20.height,
                    GetBuilder<LiveController>(
                      id: "onSwitchMic",
                      builder: (controller) => CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        gradient: AppColor.primaryLinearGradient,
                        icon: controller.isMicOn ? AppAsset.icMicOn : AppAsset.icMicOff,
                        iconColor: AppColor.white,
                        callback: controller.onSwitchMic,
                      ),
                    ),
                    20.height,
                    GetBuilder<LiveController>(
                      builder: (controller) => CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        gradient: AppColor.primaryLinearGradient,
                        icon: AppAsset.icRotateCamera,
                        iconColor: AppColor.white,
                        callback: controller.onSwitchCamera,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: GetBuilder<LiveController>(
                  builder: (controller) => CommentTextFieldUi(
                    controller: controller.commentController,
                    callback: () => controller.onSendComment(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 70,
            child: Container(
              height: 250,
              width: Get.width / 1.8,
              color: AppColor.transparent,
              child: Obx(
                () => SingleChildScrollView(
                  controller: SocketServices.scrollController,
                  child: ListView.builder(
                    itemCount: SocketServices.mainLiveComments.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = SocketServices.mainLiveComments[index];
                      return CommentItemUi(
                        title: data["userName"],
                        subTitle: data["commentText"],
                        leading: data["userImage"],
                      );
                    },
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

class UserLiveUi extends StatelessWidget {
  const UserLiveUi({super.key, required this.liveScreen, required this.liveRoomId, required this.liveUserId});

  final Widget liveScreen;
  final String liveRoomId;
  final String liveUserId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        liveScreen,
        Align(
          alignment: Alignment.center,
          child: LiveUserSendGiftBottomSheetUi.onShowGift(),
        ),
        Positioned(
          top: 40,
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetBuilder<LiveController>(
                      builder: (controller) => GestureDetector(
                            child: Container(
                              height: 50,
                              width: 178,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                                border: Border.all(color: AppColor.colorBorder.withOpacity(0.3)),
                                color: AppColor.black.withOpacity(0.45),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.asset(AppAsset.icProfilePlaceHolder),
                                        ),
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: PreviewNetworkImageUi(image: controller.image),
                                        ),
                                        Visibility(
                                          visible: controller.isProfileImageBanned,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(shape: BoxShape.circle),
                                              child: BlurryContainer(
                                                blur: 3,
                                                borderRadius: BorderRadius.circular(50),
                                                color: AppColor.black.withOpacity(0.3),
                                                child: Offstage(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  2.width,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Text(
                                          controller.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.styleW600(AppColor.white, 14),
                                        ),
                                      ),
                                      Stack(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Positioned(
                                            left: -10,
                                            child: Lottie.asset(AppAsset.lottieWaveAnimation, fit: BoxFit.cover, height: 20, width: 15),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 18, top: 2.5),
                                            child: SizedBox(
                                              width: 60,
                                              child: Text(
                                                controller.userName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFontStyle.styleW500(AppColor.white, 9),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GetBuilder<LiveController>(
                                    id: "onClickFollow",
                                    builder: (controller) => GestureDetector(
                                      onTap: controller.onClickFollow,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: AppColor.primaryLinearGradient,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            controller.isFollow ? AppAsset.icFollowing : AppAsset.icFollow,
                                            height: 22,
                                            width: 22,
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                  CircleIconButtonUi(
                    circleSize: 38,
                    color: AppColor.black.withOpacity(0.45),
                    iconSize: 20,
                    icon: AppAsset.icClose,
                    iconColor: AppColor.white,
                    callback: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 400,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.transparent, AppColor.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: GetBuilder<LiveController>(
                      builder: (controller) => CommentTextFieldUi(
                        controller: controller.commentController,
                        callback: () => controller.onSendComment(),
                      ),
                    ),
                  ),
                  15.width,
                  CircleIconButtonUi(
                    circleSize: 50,
                    iconSize: 48,
                    color: AppColor.black.withOpacity(0.3),
                    icon: AppAsset.icGift,
                    callback: () {
                      LiveUserSendGiftBottomSheetUi.show(
                        context: context,
                        liveRoomId: liveRoomId,
                        senderUserId: Database.loginUserId,
                        receiverUserId: liveUserId,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 70,
          child: Container(
            height: 250,
            width: Get.width / 1.8,
            color: AppColor.transparent,
            child: Obx(
              () => SingleChildScrollView(
                controller: SocketServices.scrollController,
                child: ListView.builder(
                  itemCount: SocketServices.mainLiveComments.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final data = SocketServices.mainLiveComments[index];
                    return CommentItemUi(
                      title: data["userName"],
                      subTitle: data["commentText"],
                      leading: data["userImage"],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommentTextFieldUi extends StatelessWidget {
  const CommentTextFieldUi({
    super.key,
    this.callback,
    this.controller,
  });

  final Callback? callback;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 22,
            width: 22,
            AppAsset.icCommentGradiant,
          ),
          5.width,
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: AppColor.coloGreyText.withOpacity(0.3),
          ),
          5.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColor.colorTextGrey,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 3),
                hintText: EnumLocal.txtTypeComment.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 15),
              ),
            ),
          ),
          GestureDetector(
            onTap: callback,
            child: Container(
              height: 40,
              width: 40,
              color: AppColor.transparent,
              child: Center(
                child: Image.asset(width: 26, AppAsset.icSend),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentItemUi extends StatelessWidget {
  const CommentItemUi({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
  });

  final String title;
  final String subTitle;
  final String leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(color: AppColor.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 38,
                width: 38,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.colorBorder.withOpacity(0.8)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(AppAsset.icProfilePlaceHolder),
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: PreviewNetworkImageUi(image: leading),
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.width,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: AppFontStyle.styleW600(AppColor.white, 11.5),
                ),
                2.height,
                Text(
                  subTitle,
                  style: AppFontStyle.styleW600(AppColor.white, 13.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
