import 'dart:async';
import 'dart:developer';
import 'dart:io'; 

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ✅ REQUIRED FOR ANDROID FILE UPLOAD
import 'package:webview_flutter_android/webview_flutter_android.dart'; 
import 'package:file_picker/file_picker.dart'; 
import 'package:url_launcher/url_launcher.dart';

import 'package:auralive/custom/custom_fetch_user_coin.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/ui/preview_country_flag_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/shimmer/profile_shimmer_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/profile_page/controller/profile_controller.dart';
import 'package:auralive/pages/profile_page/widget/profile_widget.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/size_extension.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart'; // Added for Utils.showLog

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.find<BottomBarController>().onChangeBottomBar(0);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          automaticallyImplyLeading: false,
          shadowColor: AppColor.black.withOpacity(0.4),
          surfaceTintColor: AppColor.transparent,
          flexibleSpace: const Center(child: ProfileAppBarUi()),
          
          // -----------------------------------------------------
          // ✅ CART ICON (TOP LEFT)
          // -----------------------------------------------------
          leading: GestureDetector(
            onTap: () => _onClickShop(context),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: AppColor.black,
                size: 20,
              ),
            ),
          ),
          // -----------------------------------------------------
        ),
        body: RefreshIndicator(
          notificationPredicate: (notification) {
            return notification.depth == 2;
          },
          onRefresh: () async => await controller.init(),
          child: NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      GetBuilder<ProfileController>(
                        id: "onGetProfile",
                        builder: (controller) => controller.isLoadingProfile
                            ? ProfileShimmerUi()
                            : Container(
                                color: AppColor.white,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    15.height,
                                    Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: AppColor.primaryLinearGradient,
                                          ),
                                          child: GestureDetector(
                                            onTap: controller.onClickEditProfile,
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: AppColor.white, width: 1.5),
                                              ),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                alignment: Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                                    child: Image.asset(AppAsset.icProfilePlaceHolder, fit: BoxFit.cover),
                                                  ),
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                                    child: PreviewNetworkImageUi(image: controller.fetchProfileModel?.userProfileData?.user?.image),
                                                  ),
                                                  Visibility(
                                                    visible: controller.fetchProfileModel?.userProfileData?.user?.isProfileImageBanned ?? false,
                                                    child: Container(
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(shape: BoxShape.circle),
                                                      child: BlurryContainer(
                                                        height: 100,
                                                        width: 100,
                                                        blur: 3,
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: AppColor.black.withOpacity(0.3),
                                                        child: const Offstage(),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 5,
                                                    right: -10,
                                                    child: Container(
                                                      height: 36,
                                                      width: 36,
                                                      padding: const EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: AppColor.colorBorder, width: 1.5),
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Image.asset(AppAsset.icEdit),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        15.width,
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
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
                                                    visible: Database.fetchLoginUserProfileModel?.user?.isVerified ?? false,
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
                                                  PreviewCountryFlagUi.show(controller.fetchProfileModel?.userProfileData?.user?.countryFlagImage),
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
                                        child: Text(
                                          controller.fetchProfileModel?.userProfileData?.user?.bio?.trim() ?? "",
                                          style: AppFontStyle.styleW400(AppColor.black, 13),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 75,
                                      width: Get.width,
                                      color: AppColor.white,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  CustomFormatNumber.convert(controller.fetchProfileModel?.userProfileData?.totalLikesOfVideoPost ?? 0),
                                                  style: AppFontStyle.styleW700(AppColor.black, 18),
                                                ),
                                                2.height,
                                                Text(
                                                  EnumLocal.txtLikes.name.tr,
                                                  style: AppFontStyle.styleW400(AppColor.coloGreyText, 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          VerticalDivider(
                                            indent: 20,
                                            endIndent: 20,
                                            width: 0,
                                            thickness: 2,
                                            color: AppColor.coloGreyText.withOpacity(0.2),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: controller.onClickFollowing,
                                              child: Container(
                                                color: AppColor.transparent,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      CustomFormatNumber.convert(controller.fetchProfileModel?.userProfileData?.totalFollowing ?? 0),
                                                      style: AppFontStyle.styleW700(AppColor.black, 18),
                                                    ),
                                                    2.height,
                                                    Text(
                                                      EnumLocal.txtFollowing.name.tr,
                                                      style: AppFontStyle.styleW400(AppColor.coloGreyText, 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            indent: 20,
                                            endIndent: 20,
                                            width: 0,
                                            thickness: 2,
                                            color: AppColor.coloGreyText.withOpacity(0.2),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: controller.onClickFollowers,
                                              child: Container(
                                                color: AppColor.transparent,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      CustomFormatNumber.convert(controller.fetchProfileModel?.userProfileData?.totalFollowers ?? 0),
                                                      style: AppFontStyle.styleW700(AppColor.black, 18),
                                                    ),
                                                    2.height,
                                                    Text(
                                                      EnumLocal.txtFollowers.name.tr,
                                                      style: AppFontStyle.styleW400(AppColor.coloGreyText, 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // -----------------------------------------------------------------
                                    // ✅ WALLET CONTAINER (Hidden on iOS)
                                    // -----------------------------------------------------------------
                                    if (!Platform.isIOS) ...[
                                      5.height,
                                      Container(
                                        height: 102,
                                        width: Get.width,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          gradient: AppColor.primaryLinearGradient,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 102,
                                              width: Get.width,
                                              child: Image.asset(
                                                AppAsset.icWithdrawBg,
                                                fit: BoxFit.cover,
                                                opacity: const AlwaysStoppedAnimation(0.6),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 25),
                                              child: SizedBox(
                                                height: 102,
                                                width: Get.width,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          EnumLocal.txtAvailableCoin.name.tr,
                                                          style: AppFontStyle.styleW600(AppColor.white, 18),
                                                        ),
                                                        5.height,
                                                        Row(
                                                          children: [
                                                            Obx(
                                                              () {
                                                                if (CustomFetchUserCoin.isLoading.value) {
                                                                  return const SizedBox(
                                                                    height: 20, 
                                                                    width: 20, 
                                                                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.white)
                                                                  );
                                                                }
                                                                return Text(
                                                                  controller.coinOwnerCurrency.value == 0.0
                                                                      ? 'USD ${CustomFormatNumber.convert(CustomFetchUserCoin.coin.value)}'
                                                                      : "${controller.ownerCurrencyCode.value} ${CustomFormatNumber.convert(controller.coinOwnerCurrency.value.toInt())}",
                                                                  style: AppFontStyle.styleW700(AppColor.white, 35),
                                                                );
                                                              }
                                                            ),
                                                            15.width,
                                                            GestureDetector(
                                                              onTap: () => Get.toNamed(
                                                                AppRoutes.myWalletPage,
                                                                arguments: {
                                                                  'currencyCode': controller.ownerCurrencyCode.value,
                                                                },
                                                              ),
                                                              child: Container(
                                                                height: 32,
                                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                decoration: BoxDecoration(
                                                                  color: AppColor.white,
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      EnumLocal.txtMyWallet.name.tr,
                                                                      style: AppFontStyle.styleW700(AppColor.colorDarkOrange, 13),
                                                                    ),
                                                                    10.width,
                                                                    Image.asset(
                                                                      AppAsset.icDoubleArrowRightWithoutRadius,
                                                                      width: 14,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                        decoration: BoxDecoration(color: AppColor.white),
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
            body: TabBarView(
              controller: controller.tabController,
              physics: const BouncingScrollPhysics(),
              children: const [
                ReelsTabView(),
                FeedsTabView(),
                CollectionsTabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // ✅ HELPER METHODS FOR SHOP CART (WITH ANDROID FIX)
  // --------------------------------------------------------

  void _onClickShop(BuildContext context) {
    // 1. Get the Logged-in User ID
    final userId = Database.loginUserId;
    
    // 2. Construct the URL
    final url = "https://kulclass.com/shop/index.php?userId=$userId";
    
    // 3. Open WebView
    _showFullScreenWebView(context, url);
  }

  void _showFullScreenWebView(BuildContext context, String url) {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      _openUrlInBrowser(url);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          bool isLoading = true;
          
          // 1. Initialize specifically for Android to access extra features
          late final PlatformWebViewControllerCreationParams params;
          if (WebViewPlatform.instance is AndroidWebViewPlatform) {
            params = AndroidWebViewControllerCreationParams();
          } else {
            params = const PlatformWebViewControllerCreationParams();
          }

          final webController = WebViewController.fromPlatformCreationParams(params);

          // 2. ENABLE FILE UPLOAD FOR ANDROID
          if (webController.platform is AndroidWebViewController) {
            AndroidWebViewController androidController = webController.platform as AndroidWebViewController;
            androidController.setMediaPlaybackRequiresUserGesture(false);
            
            // This is the magic function that connects <input type="file"> to your phone
            androidController.setOnShowFileSelector((FileSelectorParams params) async {
              try {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.image, 
                  allowMultiple: false, 
                );

                if (result != null && result.files.single.path != null) {
                  // Return the selected file URI to the WebView
                  return [Uri.file(result.files.single.path!).toString()];
                }
              } catch (e) {
                // If Utils.showLog exists in your project
                if (kDebugMode) print("File Picker Error: $e");
              }
              return []; // Return empty if cancelled
            });
          }

          // 3. Common Setup
          webController
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageFinished: (_) {
                  // Handled by StatefulBuilder logic below for UI update
                },
              ),
            )
            ..loadRequest(Uri.parse(url));

          return StatefulBuilder(
            builder: (context, setState) {
              // Listen to page load to hide spinner
              webController.setNavigationDelegate(
                NavigationDelegate(
                  onPageFinished: (_) {
                    if (context.mounted) {
                      setState(() => isLoading = false);
                    }
                  },
                ),
              );

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text("My Shop", style: TextStyle(color: Colors.black)),
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Stack(
                  children: [
                    WebViewWidget(controller: webController),
                    if (isLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openUrlInBrowser(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not open the URL");
    }
  }
}