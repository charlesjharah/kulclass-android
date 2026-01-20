import 'package:get/get.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/fetch_hash_tag_post_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/api/fetch_hash_tag_video_api.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/fetch_hash_tag_post_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/model/fetch_hash_tag_video_model.dart';
import 'package:auralive/pages/preview_hash_tag_page/widget/preview_hash_tag_widget.dart';
import 'package:auralive/pages/preview_shorts_video_page/model/preview_shorts_video_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/database.dart';

class PreviewHashTagController extends GetxController {
  String hashTagId = "";

  int selectedTabIndex = 0;
  final List searchTabPages = [const HashTagVideoUi(), const HashTagPostUi()];

  bool isLoadingVideo = false;
  List<VideoData> hashTagVideos = [];
  FetchHashTagVideoModel? fetchHashTagVideoModel;

  bool isLoadingPost = false;
  List<PostData> hashTagPost = [];
  FetchHashTagPostModel? fetchHashTagPostModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    selectedTabIndex = 0;
    hashTagVideos.clear();
    hashTagPost.clear();

    hashTagId = Get.arguments["id"] ?? "";

    if (hashTagId != "") {
      onGetHashTagVideos();
    }
  }

  void onChangeTabBar(int index) {
    selectedTabIndex = index;
    update(["onChangeTabBar"]);

    if (index == 0 && hashTagVideos.isEmpty) {
      onGetHashTagVideos();
    } else if (index == 1 && hashTagPost.isEmpty) {
      onGetHashTagPost();
    }
  }

  Future<void> onGetHashTagPost() async {
    isLoadingPost = true;
    fetchHashTagPostModel = await FetchHashTagPostApi.callApi(loginUserId: Database.loginUserId, hashTagId: hashTagId);

    if (fetchHashTagPostModel?.data != null) {
      hashTagPost.addAll(fetchHashTagPostModel?.data ?? []);
      isLoadingPost = false;
      update(["onGetHashTagPost"]);
    }
  }

  Future<void> onGetHashTagVideos() async {
    isLoadingVideo = true;
    fetchHashTagVideoModel = await FetchHashTagVideoApi.callApi(loginUserId: Database.loginUserId, hashTagId: hashTagId);

    if (fetchHashTagVideoModel?.data != null) {
      hashTagVideos.addAll(fetchHashTagVideoModel?.data ?? []);
      isLoadingVideo = false;

      update(["onGetHashTagVideos"]);
    }
  }

  Future<void> onClickReels(int index) async {
    List<PreviewShortsVideoModel> mainShorts = [];
    for (int index = 0; index < hashTagVideos.length; index++) {
      final video = hashTagVideos[index];
      mainShorts.add(
        PreviewShortsVideoModel(
          name: video.name.toString(),
          userId: video.userId.toString(),
          userName: video.userName.toString(),
          userImage: video.userImage.toString(),
          videoId: video.videoId.toString(),
          videoUrl: video.videoUrl.toString(),
          videoImage: video.videoImage.toString(),
          caption: video.caption.toString(),
          hashTag: video.hashTag ?? [],
          isLike: video.isLike ?? false,
          likes: video.totalLikes ?? 0,
          comments: video.totalComments ?? 0,
          isBanned: false,
          songId: video.songId ?? "",
          isProfileImageBanned: video.isProfileImageBanned ?? false,
        ),
      );
    }
    Get.toNamed(AppRoutes.previewShortsVideoPage, arguments: {"index": index, "video": mainShorts, "previousPageIsAudioWiseVideoPage": false});
  }
}
