import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/audio_wise_videos_page/api/fetch_audio_wise_videos_api.dart';
import 'package:auralive/pages/audio_wise_videos_page/model/fetch_audio_wise_videos_model.dart';
import 'package:auralive/pages/preview_shorts_video_page/model/preview_shorts_video_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/utils.dart';

class AudioWiseVideosController extends GetxController {
  ScrollController scrollController = ScrollController();
  FetchAudioWiseVideosModel? fetchAudioWiseVideosModel;
  bool isPaginationLoading = false;
  List<Videos> videos = [];
  bool isLoading = false;

  String songId = "";
  String songTitle = "";
  String songImage = "";
  String singerName = "";
  String songLink = "";
  double songDuration = 0;
  double songCurrentPosition = 0;
  int totalVideo = 0;

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void onInit() {
    songId = Get.arguments ?? "";
    scrollController.addListener(onPagination);
    init();
    super.onInit();
  }

  @override
  void onClose() {
    onDisposeAudio();
    super.onClose();
  }

  void init() {
    FetchAudioWiseVideosApi.startPagination = 0;
    videos.clear();
    isLoading = true;
    onGetVideos();
  }

  void onPagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && isPaginationLoading == false) {
      isPaginationLoading = true;
      update(["onPagination"]);
      await onGetVideos();
      isPaginationLoading = false;
      update(["onPagination"]);
    }
  }

  Future<void> onGetVideos() async {
    fetchAudioWiseVideosModel = await FetchAudioWiseVideosApi.callApi(loginUserId: Database.loginUserId, songId: songId);

    if (fetchAudioWiseVideosModel?.videos != null) {
      videos.addAll(fetchAudioWiseVideosModel?.videos ?? []);
      isLoading = false;
      update(["onGetVideos"]);

      if (FetchAudioWiseVideosApi.startPagination == 1) {
        totalVideo = fetchAudioWiseVideosModel?.totalVideosOfSong ?? 0;
        songLink = videos[0].songLink ?? "";
        songTitle = videos[0].songTitle ?? "";
        songImage = videos[0].songImage ?? "";
        singerName = videos[0].singerName ?? "";

        onInitializeAudio();
      }
    }
  }

  void onUseAudio() {
    onPauseAudio();
    Get.toNamed(
      AppRoutes.createReelsPage,
      arguments: {
        "id": songId,
        "name": songTitle,
        "image": songImage,
        "link": Api.baseUrl + songLink,
      },
    );
  }

  void onInitializeAudio() async {
    if (songLink != "") {
      try {
        await audioPlayer.setSource(UrlSource(Api.baseUrl + songLink));
        Duration? duration = await audioPlayer.getDuration();
        songDuration = duration?.inMilliseconds.toDouble() ?? 0;
        Utils.showLog("Audio Initialize Success");
        update(["onChangeAudioEvent"]);
        audioPlayer.onPositionChanged.listen(
          (event) {
            songCurrentPosition = event.inMilliseconds.toDouble();

            update(["onChangeAudioEvent"]);

            if ((songCurrentPosition + 100) >= songDuration) {
              onRestartAudio();
            }
            if (Utils.isAppOpen.value == false) {
              onPauseAudio();
            }
          },
        );
      } catch (e) {
        Utils.showLog("Audio Play Failed !! => $e");
      }
    }
  }

  void onResumeAudio() {
    if (songLink != "") {
      try {
        audioPlayer.resume();
        isPlaying = true;
        update(["onChangeAudioEvent"]);
      } catch (e) {
        Utils.showLog("Audio Resume Error => $e");
      }
    }
  }

  void onRestartAudio() {
    if (songLink != "") {
      try {
        audioPlayer.seek(Duration(milliseconds: 0));
        audioPlayer.resume();
      } catch (e) {
        Utils.showLog("Audio Restart Error => $e");
      }
    }
  }

  void onPauseAudio() {
    if (songLink != "") {
      try {
        audioPlayer.pause();
        isPlaying = false;
        update(["onChangeAudioEvent"]);
      } catch (e) {
        Utils.showLog("Audio Pause Error => $e");
      }
    }
  }

  void onSkipAudio(double value) {
    if (songLink != "") {
      try {
        songCurrentPosition = value;
        audioPlayer.seek(Duration(milliseconds: value.toInt()));
        update(["onChangeAudioEvent"]);
      } catch (e) {
        Utils.showLog("Audio Skip Error => $e");
      }
    }
  }

  void onDisposeAudio() {
    if (songLink != "") {
      try {
        audioPlayer.pause();
        isPlaying = false;
        update(["onChangeAudioEvent"]);
        audioPlayer.dispose();
      } catch (e) {
        Utils.showLog("Audio Pause Error => $e");
      }
    }
  }

  Future<void> onClickReels(int index) async {
    onPauseAudio();
    Utils.showLog("Selected Reels Index => $index");

    List<PreviewShortsVideoModel> mainShorts = [];

    for (int index = 0; index < videos.length; index++) {
      final video = videos[index];
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
    Get.toNamed(AppRoutes.previewShortsVideoPage, arguments: {"index": index, "video": mainShorts, "previousPageIsAudioWiseVideoPage": true});
  }

  String onConvertTime(double milliseconds) {
    int totalSeconds = (milliseconds / 1000).toInt();
    int hours = (totalSeconds ~/ 3600).toInt();
    int remainingSeconds = (totalSeconds % 3600).toInt();
    int minutes = (remainingSeconds ~/ 60).toInt();
    int remainingSecondsFinal = (remainingSeconds % 60).toInt();

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSecondsFinal.toString().padLeft(2, '0')}';
  }
}
