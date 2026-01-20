import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/message_page/controller/message_controller.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class MessageUserUi extends StatelessWidget {
  const MessageUserUi({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
    this.messageCount,
    this.dateTime,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
  });

  final String title;
  final String subTitle;
  final String leading;
  final int? messageCount;
  final String? dateTime;
  final Callback callback;
  final bool isVerified;
  final bool isProfileImageBanned;

  @override
  Widget build(BuildContext context) {
    log(Get.statusBarHeight.toString());

    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 70,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          border: Border(
            bottom: BorderSide(color: AppColor.colorBorder.withOpacity(0.5)),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
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
                    child: PreviewNetworkImageUi(image: leading),
                  ),
                  Visibility(
                    visible: isProfileImageBanned,
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
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                title,
                                maxLines: 1,
                                style: AppFontStyle.styleW700(AppColor.black, 15.5),
                              ),
                            ),
                            Visibility(
                              visible: isVerified,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Image.asset(AppAsset.icBlueTick, width: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      messageCount == null || messageCount == 0
                          ? const Offstage()
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: messageCount! < 10 ? 9 : 6.5, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: AppColor.primaryLinearGradient,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  messageCount.toString(),
                                  maxLines: 1,
                                  style: AppFontStyle.styleW600(AppColor.white, 12),
                                ),
                              ),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          subTitle,
                          maxLines: 1,
                          style: AppFontStyle.styleW400(AppColor.coloGreyText, 14),
                        ),
                      ),
                      dateTime == null
                          ? const Offstage()
                          : Text(
                              dateTime!,
                              style: AppFontStyle.styleW400(AppColor.coloGreyText, 10),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchMessageUserUi extends StatelessWidget {
  const SearchMessageUserUi({
    super.key,
    required this.callback,
    required this.onClickClear,
    required this.controller,
    required this.onChanged,
    required this.onCompleteSearch,
    required this.isShowClearIcon,
  });

  final Callback callback;
  final Callback onClickClear;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function(String value) onCompleteSearch;
  final bool isShowClearIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.colorUnselectedIcon.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 20,
            width: 20,
            AppAsset.icSearch,
            color: AppColor.black,
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
              onChanged: onChanged,
              onTap: callback,
              onFieldSubmitted: onCompleteSearch,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0),
                border: InputBorder.none,
                hintText: EnumLocal.txtSearchHintText.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 17),
              ),
            ),
          ),
          Visibility(
            visible: isShowClearIcon,
            child: GestureDetector(
              onTap: onClickClear,
              child: Container(
                height: 30,
                width: 30,
                color: AppColor.transparent,
                child: Center(
                  child: Image.asset(
                    height: 20,
                    width: 20,
                    AppAsset.icClose,
                    color: AppColor.coloGreyText,
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

class SearchHistoryUi extends StatelessWidget {
  const SearchHistoryUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
      child: GetBuilder<MessageController>(
        id: "onChangeSearchHistory",
        builder: (controller) => SingleChildScrollView(
          child: Wrap(
            spacing: 5,
            alignment: WrapAlignment.start,
            children: [
              for (int index = 0; index < controller.searchMessageUserHistory.length; index++)
                SearchHistoryItem(
                  title: controller.searchMessageUserHistory[index],
                  onTap: () {
                    controller.searchController.text = controller.searchMessageUserHistory[index];
                    controller.onChangeSearchHistory(false);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onDelete: () {
                    controller.onDeleteSearchHistory(index);
                    if (controller.searchMessageUserHistory.isEmpty) {
                      controller.onChangeSearchHistory(false);
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchHistoryItem extends StatelessWidget {
  const SearchHistoryItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.onDelete,
  });
  final String title;
  final Callback onTap;
  final Callback onDelete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: AppColor.colorTextGrey.withOpacity(0.1), width: 1.0),
        ),
        deleteIconColor: AppColor.black,
        onDeleted: onDelete,
        deleteIcon: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.close, color: AppColor.colorTextGrey, size: 16),
        ),
        backgroundColor: AppColor.white,
        label: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 2),
          child: Text(
            title,
            style: AppFontStyle.styleW400(AppColor.colorTextGrey, 14),
          ),
        ),
      ),
    );
  }
}
