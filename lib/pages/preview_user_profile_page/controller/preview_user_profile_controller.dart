import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/connection_page/api/follow_unfollow_api.dart';
import 'package:auralive/pages/preview_shorts_video_page/model/preview_shorts_video_model.dart';
import 'package:auralive/pages/profile_page/api/fetch_profile_api.dart';
import 'package:auralive/pages/profile_page/api/fetch_profile_collection_api.dart';
import 'package:auralive/pages/profile_page/api/fetch_profile_post_api.dart';
import 'package:auralive/pages/profile_page/api/fetch_profile_video_api.dart';
import 'package:auralive/pages/profile_page/model/fetch_profile_collection_model.dart';
import 'package:auralive/pages/profile_page/model/fetch_profile_model.dart';
import 'package:auralive/pages/profile_page/model/fetch_profile_post_model.dart';
import 'package:auralive/pages/profile_page/model/fetch_profile_video_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';
import 'package:auralive/utils/currency_helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:auralive/pages/login_page/controller/login_controller.dart';

class PreviewUserProfileController extends GetxController with GetTickerProviderStateMixin {
  TabController? tabController;
//touse
  late String viewerCountry;

  // Owner's raw amount is treated as USD (per your spec)
  double subAmountUSD = 0.0;

  // Owner-local converted amount & currency code
  double subAmountOwnerCurrency = 0.0;
  String ownerCurrencyCode = 'USD';

  // Viewer-local converted amount & currency code
  double subAmountViewerCurrency = 0.0;
  String viewerCurrencyCode = 'USD';

  // >>>>> Get Other User Profile...
  FetchProfileModel? fetchProfileModel;
  bool isLoadingProfile = false;
  bool isFollow = false;

  // >>>>> Get Other User Video...
  bool isLoadingVideo = true;
  FetchProfileVideoModel? fetchProfileVideoModel;
  List<ProfileVideoData> videoCollection = [];

  // >>>>> Get Other User Post...
  bool isLoadingPost = true;
  FetchProfilePostModel? fetchProfilePostModel;
  List<ProfilePostData> postCollection = [];

  // >>>>> Get Other User Collection(Gift)...
  bool isLoadingCollection = true;
  FetchProfileCollectionModel? fetchProfileCollectionModel;
  List<ProfileCollectionData> giftCollection = [];

  String userId = ""; // Other User Id...

  // For local persistence / viewer country attempts
  final _storage = GetStorage();

  @override
  Future<void> onInit() async {
    tabController = TabController(length: 3, vsync: this);
    tabController?.addListener(onChangeTabBar);
    Utils.showLog("Preview User Profile Controller Initialize");
    if (Get.arguments != null) {
      userId = Get.arguments;
    }
    init();
    super.onInit();
    //touse
    final loginController = Get.find<LoginController>();
    viewerCountry = loginController.viewerCountry; // 👈 logged-in user's country
  }

  @override
  Future<void> onClose() async {
    tabController?.removeListener(onChangeTabBar);
    Utils.showLog("Preview User Profile Controller Dispose");
    super.onClose();
  }

  Future<void> init() async {
    isLoadingVideo = true;
    isLoadingPost = true;
    isLoadingCollection = true;

    onGetProfile(userId: userId);
    onGetVideo(userId: userId);

      final profile = Database.fetchLoginUserProfileModel?.user;



      Utils.countryController = TextEditingController(text: (profile?.country == null || profile?.country == "") ? "India" : profile!.country!);


  }

  bool isChangingTab = false; // This is use to fixing two time api calling bug...

  Future<void> onChangeTabBar() async {
    isChangingTab = true;

    await 400.milliseconds.delay();

    if (isChangingTab) {
      isChangingTab = false;

      if (tabController?.index == 0) {
        Utils.showLog("Tab Change To Reels => ${tabController?.index}");
        if (isLoadingVideo) {
          onGetVideo(userId: userId);
        }
      } else if (tabController?.index == 1) {
        Utils.showLog("Tab Change To Feeds => ${tabController?.index}");

        if (isLoadingPost) {
          onGetPost(userId: userId);
        }
      } else if (tabController?.index == 2) {
        Utils.showLog("Tab Change To Collections => ${tabController?.index}");

        if (isLoadingCollection) {
          onGetCollection(userId: userId);
        }
      }
    }
  }






  /// Attempt to get viewer country from several places:
  /// 1) Database.selectedCountryCode (this returns a country code in your Database class)
  /// 2) GetStorage key 'country' (if you store the viewer country there)
  /// 3) fallback to 'US'
  /// touse
  String _getViewerCountryRaw() {
    try {
      // Database.selectedCountryCode returns a country code like 'US' in your Database implementation
      final dbCode = viewerCountry;
      if (dbCode.isNotEmpty) return dbCode;
    } catch (_) {}

    final stored = Utils.countryController;
    if (stored != null && stored.text.trim().isNotEmpty) {
      return stored.text; // ✅ use .text, not cast
    }

    // fallback
    return 'United States';
  }

  Future<void> onGetProfile({required String userId}) async {
    isLoadingProfile = true;
    update(["onGetProfile"]);

    fetchProfileModel = await FetchProfileApi.callApi(
        loginUserId: Database.loginUserId, otherUserId: userId);

    final user = fetchProfileModel?.userProfileData?.user;

    if (user?.name != null) {
      isLoadingProfile = false;
      isFollow = user?.isFollow ?? false;

      //touse
      // --- RAW owner amount (per your spec owner's raw value is USD)
      // If the backend actually stores owner value in owner's currency instead, you must change this flow.
      subAmountUSD = double.tryParse(user?.sub?.toString() ?? '0') ?? 0.0;

      // --- Owner currency code detection (from owner's country)
      final ownerCountryRaw = user?.country ?? '';
      ownerCurrencyCode = CurrencyHelper.getCurrencyCodeFromCountry(ownerCountryRaw);

      // Convert USD -> owner's currency
      subAmountOwnerCurrency = await CurrencyHelper.convert(subAmountUSD, 'USD', ownerCurrencyCode);

      // --- Viewer country & currency
      final viewerRaw = _getViewerCountryRaw();
      viewerCurrencyCode = CurrencyHelper.getCurrencyCodeFromCountry(viewerRaw);

      // Convert USD -> viewer currency
      subAmountViewerCurrency = await CurrencyHelper.convert(subAmountUSD, 'USD', viewerCurrencyCode);

      update(["onClickFollow", "onGetProfile"]);
    }
  }

  Future<void> onGetVideo({required String userId}) async {
    isLoadingVideo = true;
    videoCollection.clear();
    update(["onGetVideo"]);
    fetchProfileVideoModel = await FetchProfileVideoApi.callApi(loginUserId: Database.loginUserId, toUserId: userId);
    if (fetchProfileVideoModel?.data != null) {
      videoCollection.clear();
      videoCollection.addAll(fetchProfileVideoModel?.data ?? []);
    }
    isLoadingVideo = false;
    update(["onGetVideo"]);
  }

  Future<void> onGetPost({required String userId}) async {
    isLoadingPost = true;
    postCollection.clear();
    update(["onGetPost"]);
    fetchProfilePostModel = await FetchProfilePostApi.callApi(userId: userId);
    if (fetchProfilePostModel?.data != null) {
      postCollection.clear();
      postCollection.addAll(fetchProfilePostModel?.data ?? []);
    }
    isLoadingPost = false;
    update(["onGetPost"]);
  }

  Future<void> onGetCollection({required String userId}) async {
    isLoadingCollection = true;
    giftCollection.clear();
    update(["onGetCollection"]);
    fetchProfileCollectionModel = await FetchProfileCollectionApi.callApi(userId: userId);
    if (fetchProfileCollectionModel?.data != null) {
      giftCollection.clear();
      giftCollection.addAll(fetchProfileCollectionModel?.data ?? []);
    }
    isLoadingCollection = false;
    update(["onGetCollection"]);
  }

  Future<void> onClickFollow() async {
    if (userId != Database.loginUserId) {
      isFollow = !isFollow;
      update(["onClickFollow"]);
      await FollowUnfollowApi.callApi(loginUserId: Database.loginUserId, userId: userId);
    } else {
      Utils.showToast(EnumLocal.txtYouCantFollowYourOwnAccount.name.tr);
    }
  }

  Future<void> onClickReels(int index) async {
    List<PreviewShortsVideoModel> mainShorts = [];
    for (int index = 0; index < videoCollection.length; index++) {
      final video = videoCollection[index];
      mainShorts.add(
        PreviewShortsVideoModel(
          name: video.name.toString(),
          userId: video.userId.toString(),
          userName: video.userName.toString(),
          userImage: video.userImage.toString(),
          videoId: video.id.toString(),
          videoUrl: video.videoUrl.toString(),
          videoImage: video.videoImage.toString(),
          caption: video.caption.toString(),
          hashTag: video.hashTag ?? [],
          isLike: video.isLike ?? false,
          likes: video.totalLikes ?? 0,
          comments: video.totalComments ?? 0,
          isBanned: video.isBanned ?? false,
          songId: video.songId ?? "",
          isProfileImageBanned: video.isProfileImageBanned ?? false,
        ),
      );
    }
    Get.toNamed(AppRoutes.previewShortsVideoPage, arguments: {"index": index, "video": mainShorts, "previousPageIsAudioWiseVideoPage": false});
  }
}
