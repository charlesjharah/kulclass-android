import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/pages/feed_page/model/post_image_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/controller/preview_hash_tag_controller.dart';
import 'package:auralive/shimmer/preview_hash_tag_shimmer_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/ui/preview_image_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class PreviewHashTagAppBar extends StatelessWidget {
  const PreviewHashTagAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                5.width,
                Text(
                  title,
                  style: AppFontStyle.styleW700(AppColor.black, 19),
                ),
              ],
            ),
          ),
          10.height,
          const TabBarUi(),
        ],
      ),
    );
  }
}

class TabBarUi extends StatelessWidget {
  const TabBarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.transparent,
        border: Border(bottom: BorderSide(color: AppColor.colorBorder)),
      ),
      child: GetBuilder<PreviewHashTagController>(
        id: "onChangeTabBar",
        builder: (logic) => Row(
          children: [
            tabItemUi(
              title: "Video",
              onTap: () => logic.onChangeTabBar(0),
              isSelected: logic.selectedTabIndex == 0,
            ),
            tabItemUi(
              title: EnumLocal.txtFeeds.name.tr,
              onTap: () => logic.onChangeTabBar(1),
              isSelected: logic.selectedTabIndex == 1,
            ),
          ],
        ),
      ),
    );
  }
}

Widget tabItemUi({required String title, required Callback onTap, required bool isSelected}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        color: AppColor.transparent,
        alignment: Alignment.topCenter,
        child: Text(
          title,
          style: AppFontStyle.styleW500(isSelected ? AppColor.primary : AppColor.coloGreyText, 17),
        ),
      ),
    ),
  );
}

class ItemUi extends StatelessWidget {
  const ItemUi({
    super.key,
    required this.leading,
    required this.title,
    required this.subTitle,
    required this.hashTag,
    required this.likes,
    required this.comments,
    required this.image,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
    required this.images,
  });

  final String leading;
  final String title;
  final String subTitle;
  final String hashTag;
  final String likes;
  final String comments;
  final String image;
  final Callback callback;
  final bool isVerified;
  final bool isProfileImageBanned;
  final List<PostImage> images;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColor.colorBorderGrey.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Center(child: Image.asset(AppAsset.icImagePlaceHolder, width: 120)),
            AspectRatio(aspectRatio: 0.75, child: PreviewNetworkImageUi(image: image)),
            Positioned(
              bottom: 0,
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.transparent, AppColor.black.withOpacity(0.7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 160,
                      color: AppColor.transparent,
                      child: Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
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
                            ),
                          ),
                          10.width,
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              SizedBox(
                                width: Get.width / 4,
                                child: Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFontStyle.styleW600(AppColor.white, 12.5),
                                      ).paddingOnly(bottom: 15),
                                    ),
                                    Visibility(
                                      visible: isVerified,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 3, bottom: 15),
                                        child: Image.asset(AppAsset.icBlueTick, width: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width / 4,
                                child: Text(
                                  subTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW500(AppColor.white, 10),
                                ).paddingOnly(top: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    5.height,
                    SizedBox(
                      width: Get.width / 2.4,
                      child: Text(
                        hashTag,
                        maxLines: 1,
                        style: AppFontStyle.styleW400(AppColor.white, 11),
                      ),
                    ),
                    5.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppAsset.icLike, width: 20, color: AppColor.colorTextRed),
                        5.width,
                        Text(
                          likes,
                          style: AppFontStyle.styleW600(AppColor.white, 14),
                        ),
                        10.width,
                        Image.asset(AppAsset.icComment, width: 20),
                        5.width,
                        Text(
                          comments,
                          style: AppFontStyle.styleW600(AppColor.white, 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: images.any((item) => item.isBanned == true),
              child: Container(
                height: Get.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.black.withOpacity(0.65),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AppAsset.icNone, color: AppColor.colorRedContainer, width: 100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HashTagVideoUi extends StatelessWidget {
  const HashTagVideoUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewHashTagController>(
      id: "onGetHashTagVideos",
      builder: (controller) => controller.isLoadingVideo
          ? PreviewHashTagShimmerUi()
          : controller.hashTagVideos.isEmpty
              ? NoDataFoundUi(iconSize: 160, fontSize: 19)
              : SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.hashTagVideos.length,
                    padding: const EdgeInsets.all(12),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final hashTagVideo = controller.hashTagVideos[index];
                      return ItemUi(
                        leading: hashTagVideo.userImage ?? "",
                        title: hashTagVideo.userName ?? "",
                        subTitle: hashTagVideo.userName ?? "",
                        isVerified: hashTagVideo.isVerified ?? false,
                        hashTag: hashTagVideo.hashTag?.map((e) => "$e").join(',').toString() ?? "",
                        likes: CustomFormatNumber.convert(hashTagVideo.totalLikes ?? 0),
                        comments: CustomFormatNumber.convert(hashTagVideo.totalComments ?? 0),
                        image: hashTagVideo.videoImage ?? "",
                        callback: () => controller.onClickReels(index),
                        isProfileImageBanned: hashTagVideo.isProfileImageBanned ?? false,
                        images: [],
                      );
                    },
                  ),
                ),
    );
  }
}

class HashTagPostUi extends StatelessWidget {
  const HashTagPostUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewHashTagController>(
      id: "onGetHashTagPost",
      builder: (controller) => controller.isLoadingPost
          ? PreviewHashTagShimmerUi()
          : controller.hashTagPost.isEmpty
              ? NoDataFoundUi(iconSize: 160, fontSize: 19)
              : SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.hashTagPost.length,
                    padding: const EdgeInsets.all(12),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final hashTagPost = controller.hashTagPost[index];
                      return ItemUi(
                        leading: hashTagPost.userImage ?? "",
                        title: hashTagPost.userName ?? "",
                        subTitle: hashTagPost.userName ?? "",
                        isVerified: hashTagPost.isVerified ?? false,
                        hashTag: hashTagPost.hashTag?.map((e) => "$e").join(',').toString() ?? "",
                        likes: CustomFormatNumber.convert(hashTagPost.totalLikes ?? 0),
                        comments: CustomFormatNumber.convert(hashTagPost.totalComments ?? 0),
                        image: hashTagPost.mainPostImage ?? "",
                        isProfileImageBanned: hashTagPost.isProfileImageBanned ?? false,
                        images: hashTagPost.postImage ?? [],
                        callback: () {
                          Get.to(
                            PreviewImageUi(
                              name: hashTagPost.name ?? "",
                              userName: hashTagPost.userName ?? "",
                              userImage: hashTagPost.userImage ?? "",
                              images: hashTagPost.postImage ?? [],
                              selectedIndex: 0,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
