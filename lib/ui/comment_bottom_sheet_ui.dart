import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/shimmer/comment_shimmer_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/splash_screen_page/api/create_comment_api.dart';
import 'package:auralive/pages/splash_screen_page/api/fetch_comment_api.dart';
import 'package:auralive/pages/splash_screen_page/model/comment_model.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class CommentBottomSheetUi {
  static RxBool isLoading = false.obs;
  static CommentModel? commentModel;
  static RxList<PostOrVideoComment> comments = <PostOrVideoComment>[].obs;
  static TextEditingController commentController = TextEditingController();
  static ScrollController scrollController = ScrollController();

  static Future<void> onGetComments({
    required int commentType,
    required String commentTypeId,
  }) async {
    isLoading.value = true;
    comments.clear();
    commentModel = await FetchCommentApi.callApi(
      loginUserId: Database.loginUserId,
      commentType: commentType,
      commentTypeId: commentTypeId,
    );

    if (commentModel?.postOrVideoComment != null) {
      isLoading.value = false;
      comments.addAll(commentModel?.postOrVideoComment ?? []);
    }
  }

  static Future<void> onSendComment({
    required int commentType,
    required String commentTypeId,
  }) async {
    if (commentController.text.trim().isNotEmpty) {
      final commentText = commentController.text;

      comments.add(
        PostOrVideoComment(
          name: Database.fetchLoginUserProfileModel?.user?.name ?? "",
          userImage: Database.fetchLoginUserProfileModel?.user?.image ?? "",
          commentText: commentText,
          isProfileImageBanned: Database.fetchLoginUserProfileModel?.user?.isProfileImageBanned ?? false,
          time: "Now",
        ),
      );
      commentController.clear();

      if (comments.length > 4) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
        await 500.milliseconds.delay();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }

      await CreateCommentApi.callApi(
        loginUserId: Database.loginUserId,
        commentType: commentType,
        commentTypeId: commentTypeId,
        commentText: commentText,
      );
    }
  }

  static String onFormatTime(String time) {
    List<String> parts = time.split(' ');

    if (parts.length == 3 && parts[2] == 'ago' && parts[1] == 'minutes' && parts[0].isNotEmpty) {
      return '${parts[0]}m';
    } else if (parts.length == 3 && parts[2] == 'ago' && parts[1] == 'hours' && parts[0].isNotEmpty) {
      return '${parts[0]}h';
    } else if (parts.length == 3 && parts[2] == 'ago' && parts[1] == 'seconds' && parts[0].isNotEmpty) {
      return '${parts[0]}s';
    } else {
      return time;
    }
  }

  static Future<int> show({
    required BuildContext context,
    required int commentType,
    required String commentTypeId,
    required int totalComments,
  }) async {
    onGetComments(commentType: commentType, commentTypeId: commentTypeId);

    await showModalBottomSheet(
      isScrollControlled: true,
      scrollControlDisabledMaxHeightRatio: Get.height,
      context: context,
      backgroundColor: AppColor.transparent,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 500,
          width: Get.width,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 65,
                color: AppColor.grey_100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.colorTextDarkGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        10.height,
                        Text(
                          EnumLocal.txtComment.name.tr,
                          style: AppFontStyle.styleW700(AppColor.black, 17),
                        ),
                      ],
                    ).paddingOnly(left: 50),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.transparent,
                          border: Border.all(color: AppColor.black),
                        ),
                        child: Center(
                          child: Image.asset(
                            width: 18,
                            AppAsset.icClose,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => isLoading.value
                      ? CommentShimmerUi()
                      : comments.isEmpty
                          ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                          : SingleChildScrollView(
                              controller: scrollController,
                              child: ListView.builder(
                                itemCount: comments.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 45,
                                          width: 45,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(shape: BoxShape.circle),
                                          child: Stack(
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.asset(AppAsset.icProfilePlaceHolder),
                                              ),
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: PreviewNetworkImageUi(image: comments[index].userImage),
                                              ),
                                              Visibility(
                                                visible: comments[index].isProfileImageBanned ?? false,
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
                                          )),
                                      12.width,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: comments[index].name,
                                                style: AppFontStyle.styleW700(AppColor.black, 15),
                                                children: [
                                                  TextSpan(
                                                    text: "   ${onFormatTime(comments[index].time ?? "")}",
                                                    style: AppFontStyle.styleW600(AppColor.colorGreyHasTagText, 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            5.height,
                                            Text(
                                              comments[index].commentText ?? "",
                                              style: AppFontStyle.styleW500(AppColor.colorDarkGrey, 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
              CommentTextFieldUi(
                controller: commentController,
                onSend: () {
                  onSendComment(commentType: commentType, commentTypeId: commentTypeId);
                },
              ),
            ],
          ),
        ),
      ),
    );
    return comments.isEmpty ? totalComments : comments.length;
  }
}

class CommentTextFieldUi extends StatelessWidget {
  const CommentTextFieldUi({
    super.key,
    required this.onSend,
    required this.controller,
  });

  final Callback onSend;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 5),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColor.colorBorder.withOpacity(0.3),
        border: Border.all(color: AppColor.colorBorder.withOpacity(0.6)),
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
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 14.5),
              ),
            ),
          ),
          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 40,
              width: 40,
              color: AppColor.transparent,
              child: Center(child: Image.asset(width: 25, AppAsset.icSend)),
            ),
          ),
        ],
      ),
    );
  }
}
