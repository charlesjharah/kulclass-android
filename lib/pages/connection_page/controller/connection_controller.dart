import 'package:get/get.dart';
import 'package:auralive/pages/connection_page/api/fetch_followers_api.dart';
import 'package:auralive/pages/connection_page/api/fetch_following_api.dart';
import 'package:auralive/pages/connection_page/model/fetch_followers_model.dart';
import 'package:auralive/pages/connection_page/model/fetch_following_model.dart';
import 'package:auralive/pages/connection_page/widget/connection_widget.dart';

class ConnectionController extends GetxController {
  @override
  void onInit() {
    if (Get.arguments != null) {
      onChangeTabBar(Get.arguments["type"]);
    }
    super.onInit();
  }

  void init() async {
    onGetFollowing();
    onGetFollowers();
  }

  int selectedTabIndex = 0;
  final List connectionTabPages = [const FollowingTabUi(), const FollowersTabUi()];

  bool isLoadingFollowing = false;
  bool isLoadingFollowers = false;

  FetchFollowingModel? fetchFollowingModel;
  FetchFollowersModel? fetchFollowersModel;

  List<FollowingData> following = [];
  List<FollowersData> followers = [];

  Future<void> onGetFollowing() async {
    isLoadingFollowing = true;

    following.clear();

    fetchFollowingModel = await FetchFollowingApi.callApi(userId: Get.arguments["userId"]);

    if (fetchFollowingModel?.followerFollowing != null) {
      following.addAll(fetchFollowingModel?.followerFollowing ?? []);

      isLoadingFollowing = false;

      update(["onGetFollowing"]);
    }
  }

  Future<void> onGetFollowers() async {
    isLoadingFollowers = true;

    followers.clear();

    fetchFollowersModel = null;

    fetchFollowersModel = await FetchFollowersApi.callApi(userId: Get.arguments["userId"]);

    if (fetchFollowersModel?.followerFollowing != null) {
      followers.addAll(fetchFollowersModel?.followerFollowing ?? []);

      isLoadingFollowers = false;

      update(["onGetFollowers"]);
    }
  }

  void onChangeTabBar(int index) {
    selectedTabIndex = index;

    if (index == 0 && following.isEmpty) {
      onGetFollowing();
    }
    if (index == 1 && followers.isEmpty) {
      onGetFollowers();
    }

    update(["onChangeTabBar"]);
  }
}
