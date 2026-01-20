import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/ui/preview_country_flag_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/shimmer/preview_profile_bottom_sheet_shimmer_ui.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/connection_page/api/follow_unfollow_api.dart';
import 'package:auralive/pages/profile_page/api/fetch_profile_api.dart';
import 'package:auralive/pages/profile_page/model/fetch_profile_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';

class PreviewProfileBottomSheetUi {
  static FetchProfileModel? fetchProfileModel;
  static RxBool isLoadingProfile = false.obs;

  static RxBool isFollow = false.obs;

  static Future<void> onGetProfile(String userId) async {
    isLoadingProfile.value = true;

    fetchProfileModel = await FetchProfileApi.callApi(loginUserId: Database.loginUserId, otherUserId: userId);
    if (fetchProfileModel?.userProfileData?.user?.name != null) {
      isFollow.value = fetchProfileModel?.userProfileData?.user?.isFollow ?? false;
      isLoadingProfile.value = false;
    }
  }

  static Future<void> onClickFollow(String userId) async {
    if (userId != Database.loginUserId) {
      isFollow.value = !isFollow.value;
      await FollowUnfollowApi.callApi(loginUserId: Database.loginUserId, userId: userId);
    } else {
      Utils.showToast(EnumLocal.txtYouCantFollowYourOwnAccount.name.tr);
    }
  }


  static void show({
    required String userId,
    required BuildContext context,
  }) {

    onGetProfile(userId);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 428,
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
                        EnumLocal.txtViewProfile.name.tr,
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
                () => isLoadingProfile.value
                    ? PreviewProfileBottomSheetShimmerUi()
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColor.primaryLinearGradient,
                                ),
                                child: Container(
                                    height: 110,
                                    width: 110,
                                    margin: const EdgeInsets.all(2),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.asset(AppAsset.icProfilePlaceHolder),
                                        ),
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: PreviewNetworkImageUi(image: fetchProfileModel?.userProfileData?.user?.image),
                                        ),
                                        Visibility(
                                          visible: fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? false,
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
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    fetchProfileModel?.userProfileData?.user?.name ?? "",
                                    style: AppFontStyle.styleW700(AppColor.black, 18),
                                  ),
                                  Visibility(
                                    visible: fetchProfileModel?.userProfileData?.user?.isVerified ?? false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Image.asset(AppAsset.icBlueTick, width: 20),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                fetchProfileModel?.userProfileData?.user?.userName ?? "",
                                style: AppFontStyle.styleW400(AppColor.colorGreyHasTagText, 13),
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (fetchProfileModel?.userProfileData?.user?.isFake ?? false)
                                      ? (fetchProfileModel?.userProfileData?.user?.countryFlagImage != null) && (fetchProfileModel?.userProfileData?.user?.countryFlagImage != "")
                                          ? Image.network(
                                              fetchProfileModel?.userProfileData?.user?.countryFlagImage ?? "",
                                              width: 25,
                                            )
                                          : Offstage()
                                      : SizedBox(
                                          width: 22,
                                          child: PreviewCountryFlagUi.show(fetchProfileModel?.userProfileData?.user?.countryFlagImage),
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
                                          fetchProfileModel?.userProfileData?.user?.gender?.toLowerCase().trim() == "male" ? AppAsset.icMale : AppAsset.icFemale,
                                          width: 14,
                                          color: AppColor.white,
                                        ),
                                        5.width,
                                        Text(
                                          fetchProfileModel?.userProfileData?.user?.gender?.toLowerCase().trim() == "male"
                                              ? EnumLocal.txtMale.name.tr
                                              : EnumLocal.txtFemale.name.tr,
                                          style: AppFontStyle.styleW600(AppColor.white, 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //15.height,
                              //Row(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                //children: [
                                  //GestureDetector(
                                    //onTap: () => onClickFollow(userId),
                                    //child: Obx(
                                      //() => Container(
                                        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        //decoration: BoxDecoration(
                                          //color: AppColor.colorBorder.withOpacity(0.1),
                                          //borderRadius: BorderRadius.circular(20),
                                          //border: Border.all(color: AppColor.colorBorder.withOpacity(0.6), width: 1),
                                        //),
                                        //child: Row(
                                        //children: [
                                        //Image.asset(
                                        //ctrl.isFollow ? AppAsset.icFollowing : AppAsset.icFollow,
                                        //height: 18,
                                        //color: AppColor.primary,
                                        //),
                                        //8.width,
                                        // Show the formatted string using controller values
                                        //Text(
                                        //ctrl.isFollow
                                        //  ? EnumLocal.txtFollowing.name.tr
                                        //: "Subscribe - \$${ctrl.subAmountUSD.toStringAsFixed(2)} "
                                        //"(~ ${ctrl.ownerCurrencyCode} ${ctrl.subAmountOwnerCurrency.toStringAsFixed(2)} • "
                                        //"${ctrl.viewerCurrencyCode} ${ctrl.subAmountViewerCurrency.toStringAsFixed(2)})",
                                        //style: AppFontStyle.styleW600(AppColor.primary, 16),
                                        //),
                                        // ],
                                        //),
                                      //),
                                    //),
                                  //),
                                //],
                              //),
                              20.height,
                              Row(
                                children: [
                                  Expanded(
                                    child: AppButtonUi(
                                      height: 54,
                                      fontSize: 18,
                                      gradient: AppColor.primaryLinearGradient,
                                      title: EnumLocal.txtViewDetails.name.tr,
                                      callback: () {
                                        Get.back();
                                        Get.toNamed(AppRoutes.previewUserProfilePage, arguments: userId);
                                      },
                                    ),
                                  ),
                                  15.width,
                                  GestureDetector(
                                    onTap: () {
                                      if (fetchProfileModel?.userProfileData?.user?.isFake == true) {
                                        Get.toNamed(
                                          AppRoutes.fakeChatPage,
                                          arguments: {
                                            "id": userId,
                                            "name": fetchProfileModel?.userProfileData?.user?.name ?? "",
                                            "userName": fetchProfileModel?.userProfileData?.user?.userName ?? "",
                                            "image": fetchProfileModel?.userProfileData?.user?.image ?? "",
                                            "isBlueTik": fetchProfileModel?.userProfileData?.user?.isVerified ?? false,
                                            "isProfileImageBanned": fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? false,
                                          },
                                        )?.then((value) => Get.back());
                                      } else {
                                        Get.toNamed(
                                          AppRoutes.chatPage,
                                          arguments: {
                                            "id": userId,
                                            "name": fetchProfileModel?.userProfileData?.user?.name ?? "",
                                            "userName": fetchProfileModel?.userProfileData?.user?.userName ?? "",
                                            "image": fetchProfileModel?.userProfileData?.user?.image ?? "",
                                            "isBlueTik": fetchProfileModel?.userProfileData?.user?.isVerified ?? false,
                                            "isProfileImageBanned": fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? false,
                                          },
                                        )?.then((value) => Get.back());
                                      }
                                    },
                                    child: Container(
                                      height: 56,
                                      width: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: AppColor.primaryLinearGradient,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(AppAsset.icSayHey, width: 28),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
