import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/ui/preview_country_flag_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/pages/preview_user_profile_page/widget/preview_user_profile_widget.dart';
import 'package:auralive/shimmer/preview_user_profile_shimmer_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/currency_helper.dart';


class PreviewUserProfileView extends GetView<PreviewUserProfileController> {
  const PreviewUserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          if (controller.fetchProfileModel?.userProfileData?.user?.isFake == true) {
            Get.toNamed(
              AppRoutes.fakeChatPage,
              arguments: {
                "id": controller.userId,
                "name": controller.fetchProfileModel?.userProfileData?.user?.name ?? "",
                "userName": controller.fetchProfileModel?.userProfileData?.user?.userName ?? "",
                "image": controller.fetchProfileModel?.userProfileData?.user?.image ?? "",
                "isBlueTik": controller.fetchProfileModel?.userProfileData?.user?.isVerified ?? false,
                "isProfileImageBanned": controller.fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? false,
              },
            );
          } else {
            Get.toNamed(
              AppRoutes.chatPage,
              arguments: {
                "id": controller.userId,
                "name": controller.fetchProfileModel?.userProfileData?.user?.name ?? "",
                "userName": controller.fetchProfileModel?.userProfileData?.user?.userName ?? "",
                "image": controller.fetchProfileModel?.userProfileData?.user?.image ?? "",
                "isBlueTik": controller.fetchProfileModel?.userProfileData?.user?.isVerified ?? false,
                "isProfileImageBanned": controller.fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? false,
              },
            );
          }
        },
        child: Container(
          height: 65,
          width: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: AppColor.primaryLinearGradient,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(AppAsset.icSayHey, width: 33),
        ),
      ),
      appBar: const PreviewUserProfileAppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  GetBuilder<PreviewUserProfileController>(
                    id: "onGetProfile",
                    builder: (controller) => controller.isLoadingProfile
                        ? PreviewUserProfileShimmerUi()
                        : Container(
                            color: AppColor.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                15.height,
                              Row(
                                children: [
                                  15.width,
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: AppColor.primaryLinearGradient,
                                    ),
                                    child: Container(
                                      height: 115,
                                      width: 115,
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColor.white, width: 1.5),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            height: 115,
                                            width: 115,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(shape: BoxShape.circle),
                                            child: Image.asset(AppAsset.icProfilePlaceHolder, fit: BoxFit.cover),
                                          ),
                                          Container(
                                            height: 115,
                                            width: 115,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(shape: BoxShape.circle),
                                            child: PreviewNetworkImageUi(
                                              image: controller.fetchProfileModel?.userProfileData?.user?.image,
                                            ),
                                          ),
                                          Visibility(
                                            visible: controller.fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? false,
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
                                  15.width,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                maxLines: 1,
                                                controller.fetchProfileModel?.userProfileData?.user?.name ?? "",
                                                style: AppFontStyle.styleW700(AppColor.black, 18),
                                              ),
                                            ),
                                            Visibility(
                                              visible: controller.fetchProfileModel?.userProfileData?.user?.isVerified ?? false,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 3),
                                                child: Image.asset(AppAsset.icBlueTick, width: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          controller.fetchProfileModel?.userProfileData?.user?.userName ?? "",
                                          style: AppFontStyle.styleW400(AppColor.colorGreyHasTagText, 13),
                                        ),
                                        5.height,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            (controller.fetchProfileModel?.userProfileData?.user?.isFake ?? false)
                                                ? (controller.fetchProfileModel?.userProfileData?.user?.countryFlagImage != null) &&
                                                (controller.fetchProfileModel?.userProfileData?.user?.countryFlagImage != "")
                                                ? Image.network(
                                              controller.fetchProfileModel?.userProfileData?.user?.countryFlagImage ?? "",
                                              width: 25,
                                            )
                                                : Offstage()
                                                : SizedBox(
                                              width: 22,
                                              child: PreviewCountryFlagUi.show(
                                                controller.fetchProfileModel?.userProfileData?.user?.countryFlagImage,
                                              ),
                                            ),
                                            10.width,
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                              decoration: BoxDecoration(
                                                color: AppColor.secondary,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    ((controller.fetchProfileModel?.userProfileData?.user?.gender?.toLowerCase() ?? "male") == "male")
                                                        ? AppAsset.icMale
                                                        : AppAsset.icFemale,
                                                    width: 14,
                                                    color: AppColor.white,
                                                  ),
                                                  5.width,
                                                  Text(
                                                    ((controller.fetchProfileModel?.userProfileData?.user?.gender?.toLowerCase() ?? "male") == "male")
                                                        ? EnumLocal.txtMale.name.tr
                                                        : EnumLocal.txtFemale.name.tr,
                                                    style: AppFontStyle.styleW600(AppColor.white, 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        5.height,
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            GetBuilder<PreviewUserProfileController>(
                                              id: "onClickFollow",
                                              builder: (controller) => GestureDetector(
                                                onTap: () {
                                                  if (controller.isFollow) {
                                                    // show confirmation before unsubscribing
                                                    Get.defaultDialog(
                                                      title: "Confirm Unsubscribe",
                                                      middleText: "Are you sure you want to unsubscribe?\nPaid fee will not be refunded.",
                                                      textCancel: "Cancel",
                                                      textConfirm: "Yes, Unsubscribe",
                                                      confirmTextColor: Colors.white,
                                                      onConfirm: () {
                                                        controller.onClickFollow(); // call unsubscribe
                                                        Get.back();
                                                      },
                                                    );
                                                  } else {
                                                    controller.onClickFollow(); // subscribe directly
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.colorBorder.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(color: AppColor.colorBorder.withOpacity(0.6), width: 1),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        controller.isFollow ? AppAsset.icFollowing : AppAsset.icFollow,
                                                        height: 18,
                                                        color: AppColor.primary,
                                                      ),
                                                      8.width,
                                                      Text(
                                                        controller.isFollow
                                                            ? EnumLocal.txtFollowing.name.tr
                                                            : "Subscribe  • ${controller.viewerCurrencyCode} ${controller.subAmountViewerCurrency.toStringAsFixed(1)}",
                                                        style: AppFontStyle.styleW600(AppColor.primary, 16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              10.height,
                                Visibility(
                                  visible: controller.fetchProfileModel?.userProfileData?.user?.bio?.trim().isNotEmpty ?? false,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        controller.fetchProfileModel?.userProfileData?.user?.bio?.trim() ?? "",
                                        style: AppFontStyle.styleW400(AppColor.black, 13),
                                      ),
                                    ),
                                  ),
                                ),


                                15.height,
                                Container(
                                  height: 75,
                                  width: Get.width,
                                  color: AppColor.colorBorder.withOpacity(0.35),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              CustomFormatNumber.convert(controller.fetchProfileModel?.userProfileData?.totalLikesOfVideoPost ?? 0),
                                              style: AppFontStyle.styleW700(AppColor.colorDarkBlue, 18),
                                            ),
                                            2.height,
                                            Text(
                                              EnumLocal.txtLikes.name.tr,
                                              style: AppFontStyle.styleW400(AppColor.colorDarkBlue, 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const VerticalDivider(
                                        indent: 20,
                                        endIndent: 20,
                                        width: 0,
                                        thickness: 2,
                                        color: AppColor.white,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.connectionPage,
                                              arguments: {
                                                "userId": controller.userId,
                                                "name": controller.fetchProfileModel?.userProfileData?.user?.name ?? "",
                                                "userName": controller.fetchProfileModel?.userProfileData?.user?.userName ?? "",
                                                "image": controller.fetchProfileModel?.userProfileData?.user?.image ?? "",
                                                "isProfileImageBanned": controller.fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? "",
                                                "type": 0,
                                              },
                                            ); // Arguments Type => Following..
                                          },
                                          child: Container(
                                            color: AppColor.transparent,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  CustomFormatNumber.convert(controller.fetchProfileModel?.userProfileData?.totalFollowing ?? 0),
                                                  style: AppFontStyle.styleW700(AppColor.colorDarkBlue, 18),
                                                ),
                                                2.height,
                                                Text(
                                                  EnumLocal.txtFollowing.name.tr,
                                                  style: AppFontStyle.styleW400(AppColor.colorDarkBlue, 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        indent: 20,
                                        endIndent: 20,
                                        width: 0,
                                        thickness: 2,
                                        color: AppColor.white,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.connectionPage,
                                              arguments: {
                                                "userId": controller.userId,
                                                "name": controller.fetchProfileModel?.userProfileData?.user?.name ?? "",
                                                "userName": controller.fetchProfileModel?.userProfileData?.user?.userName ?? "",
                                                "image": controller.fetchProfileModel?.userProfileData?.user?.image ?? "",
                                                "isProfileImageBanned": controller.fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? "",
                                                "type": 1,
                                              },
                                            ); // Arguments Type => Followers
                                          },
                                          child: Container(
                                            color: AppColor.transparent,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  CustomFormatNumber.convert(controller.fetchProfileModel?.userProfileData?.totalFollowers ?? 0),
                                                  style: AppFontStyle.styleW700(AppColor.colorDarkBlue, 18),
                                                ),
                                                2.height,
                                                Text(
                                                  EnumLocal.txtFollowers.name.tr,
                                                  style: AppFontStyle.styleW400(AppColor.colorDarkBlue, 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),

            PreferredSize(
              preferredSize: const Size.fromHeight(75),
              child: SliverAppBar(
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                backgroundColor: AppColor.white,
                surfaceTintColor: AppColor.transparent,
                toolbarHeight: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(75),
                  child: Container(
                    color: AppColor.white,
                    child: TabBar(
                      controller: controller.tabController,
                      labelColor: AppColor.colorTabBar,
                      labelStyle: AppFontStyle.styleW600(AppColor.black.withOpacity(0.8), 13),
                      unselectedLabelColor: AppColor.colorUnselectedIcon,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 2,
                      indicatorPadding: const EdgeInsets.only(top: 72, right: 10, left: 10),
                      indicator: const BoxDecoration(
                        gradient: AppColor.primaryLinearGradient,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      tabs: <Tab>[
                        Tab(
                          icon: const ImageIcon(AssetImage(AppAsset.icReels), size: 30),
                          text: EnumLocal.txtReels.name.tr,
                        ),
                        Tab(
                          icon: const ImageIcon(AssetImage(AppAsset.icFeeds), size: 30),
                          text: EnumLocal.txtFeeds.name.tr,
                        ),
                        Tab(
                          icon: const ImageIcon(AssetImage(AppAsset.icCollections), size: 30),
                          text: EnumLocal.txtCollections.name.tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(controller: controller.tabController, physics: const BouncingScrollPhysics(), children: const [
          ReelsTabView(),
          FeedsTabView(),
          CollectionsTabView(),
        ]),
      ),
    );
  }
}
