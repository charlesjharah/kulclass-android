import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/ui/preview_profile_bottom_sheet_ui.dart';
import 'package:auralive/shimmer/user_list_shimmer_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/connection_page/controller/connection_controller.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class ConnectionAppBarUi extends StatelessWidget implements PreferredSizeWidget {
  const ConnectionAppBarUi({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.white,
      shadowColor: AppColor.black.withOpacity(0.4),
      flexibleSpace: SafeArea(
        bottom: false,
        child: Container(
          color: AppColor.white,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: AppColor.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Image.asset(AppAsset.icBack, width: 25)),
                  ),
                ),
                2.width,
                Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColor.primaryLinearGradient,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                    child: Container(
                      height: 40,
                      width: 40,
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
                            child: PreviewNetworkImageUi(image: Get.arguments["image"]),
                          ),
                          Visibility(
                            visible: Get.arguments["isProfileImageBanned"] ?? false,
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
                  ),
                ),
                10.width,
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Text(
                      Get.arguments["name"],
                      style: AppFontStyle.styleW700(AppColor.black, 15.5),
                    ).paddingOnly(bottom: 17),
                    Text(
                      Get.arguments["userName"],
                      style: AppFontStyle.styleW400(AppColor.coloGreyText, 12.5),
                    ).paddingOnly(top: 21),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectionTabBarUi extends StatelessWidget {
  const ConnectionTabBarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
        border: Border(bottom: BorderSide(color: AppColor.colorBorder)),
      ),
      child: GetBuilder<ConnectionController>(
        id: "onChangeTabBar",
        builder: (logic) => Row(
          children: [
            TabItemUi(
              title: EnumLocal.txtFollowing.name.tr,
              onTap: () => logic.onChangeTabBar(0),
              isSelected: logic.selectedTabIndex == 0,
            ),
            TabItemUi(
              title: EnumLocal.txtFollowers.name.tr,
              onTap: () => logic.onChangeTabBar(1),
              isSelected: logic.selectedTabIndex == 1,
            ),
          ],
        ),
      ),
    );
  }
}

class TabItemUi extends StatelessWidget {
  const TabItemUi({super.key, required this.title, required this.isSelected, required this.onTap});

  final String title;
  final bool isSelected;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          color: AppColor.transparent,
          child: Center(
            child: Text(
              title,
              style: AppFontStyle.styleW500(isSelected ? AppColor.primary : AppColor.coloGreyText, 18),
            ),
          ),
        ),
      ),
    );
  }
}

class FollowingTabUi extends StatelessWidget {
  const FollowingTabUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: "onGetFollowing",
      builder: (controller) => controller.isLoadingFollowing
          ? UserListShimmerUi()
          : controller.following.isEmpty
              ? const NoDataFoundUi(iconSize: 140, fontSize: 16)
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                      itemCount: controller.following.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final userIndex = controller.following[index];
                        return UserListTileUi(
                          title: userIndex.toUserId?.name ?? "",
                          subTitle: userIndex.toUserId?.name ?? "",
                          leading: userIndex.toUserId?.image ?? "",
                          isVerified: userIndex.toUserId?.isVerified ?? false,
                          isProfileImageBanned: userIndex.toUserId?.isProfileImageBanned ?? false,
                          callback: () async {
                            PreviewProfileBottomSheetUi.show(context: context, userId: userIndex.toUserId?.id ?? "");

                            log("Selected User Id => ${userIndex.toUserId?.id ?? ""}");

                            if (userIndex.toUserId?.id != Database.loginUserId) {
                              PreviewProfileBottomSheetUi.show(context: context, userId: userIndex.toUserId?.id ?? "");
                            } else {
                              Get.offAllNamed(AppRoutes.bottomBarPage);
                              await 300.milliseconds.delay();
                              final bottomBarController = Get.find<BottomBarController>();
                              bottomBarController.onChangeBottomBar(4);
                            }
                          },
                        );
                      }),
                ),
    );
  }
}

class FollowersTabUi extends StatelessWidget {
  const FollowersTabUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: "onGetFollowers",
      builder: (controller) => controller.isLoadingFollowers
          ? UserListShimmerUi()
          : controller.followers.isEmpty
              ? const NoDataFoundUi(iconSize: 140, fontSize: 16)
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                    itemCount: controller.followers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => UserListTileUi(
                      title: controller.followers[index].fromUserId?.name ?? "",
                      subTitle: controller.followers[index].fromUserId?.name ?? "",
                      leading: controller.followers[index].fromUserId?.image ?? "",
                      isVerified: controller.followers[index].fromUserId?.isVerified ?? false,
                      isProfileImageBanned: controller.followers[index].fromUserId?.isProfileImageBanned ?? false,
                      callback: () async {
                        log("Selected User Id => ${controller.followers[index].fromUserId?.id ?? ""}");
                        if (controller.followers[index].fromUserId?.id != Database.loginUserId) {
                          PreviewProfileBottomSheetUi.show(
                            context: context,
                            userId: controller.followers[index].fromUserId?.id ?? "",
                          );
                        } else {
                          Get.offAllNamed(AppRoutes.bottomBarPage);
                          await 300.milliseconds.delay();
                          final bottomBarController = Get.find<BottomBarController>();
                          bottomBarController.onChangeBottomBar(4);
                        }
                      },
                    ),
                  ),
                ),
    );
  }
}

class UserListTileUi extends StatelessWidget {
  const UserListTileUi({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
  });

  final String title;
  final String subTitle;
  final String leading;
  final Callback callback;
  final bool isVerified;
  final bool isProfileImageBanned;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 65,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          border: Border(
            bottom: BorderSide(color: AppColor.colorBorder.withOpacity(0.5)),
          ),
        ),
        child: Row(
          children: [
            Container(
                height: 42,
                width: 42,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: AppColor.colorBorder,
                  shape: BoxShape.circle,
                ),
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
                )),
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          title,
                          maxLines: 1,
                          style: AppFontStyle.styleW700(AppColor.black, 14.5),
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
                  Text(
                    subTitle,
                    maxLines: 1,
                    style: AppFontStyle.styleW400(AppColor.colorDarkGrey, 13),
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
