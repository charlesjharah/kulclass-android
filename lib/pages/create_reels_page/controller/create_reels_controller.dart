import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:deepar_flutter_plus/deepar_flutter_plus.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';

// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:auralive/custom/custom_thumbnail.dart';
import 'package:auralive/custom/custom_video_time.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/pages/create_reels_page/api/fetch_all_sound_api.dart';
import 'package:auralive/pages/create_reels_page/api/fetch_favorite_sound_api.dart';
import 'package:auralive/pages/create_reels_page/api/search_sound_api.dart';
import 'package:auralive/pages/create_reels_page/model/fetch_all_sound_model.dart';
import 'package:auralive/pages/create_reels_page/model/fetch_favorite_sound_model.dart';
import 'package:auralive/pages/create_reels_page/model/search_sound_model.dart';
import 'package:auralive/pages/create_reels_page/widget/create_reels_widget.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';

class CreateReelsController extends GetxController {
  // >>>>> >>>>> >>>>> Main Variable <<<<< <<<<< <<<<<

  final bool isUseEffects = Utils.isShowReelsEffect;

  bool isFlashOn = false;

  int countTime = 0;
  Timer? timer;
  int selectedDuration = 5;
  final List<int> recordingDurations = [5, 10, 15, 30];

  double? videoTime;
  String? videoImage;

  String isRecording = "stop"; // Recording Types => [start,pause,stop]

  // >>>>> >>>>> >>>>> Camera Controller <<<<< <<<<< <<<<<

  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

  // >>>>> >>>>> >>>>> Camera Controller <<<<< <<<<< <<<<<

  DeepArControllerPlus deepArController = DeepArControllerPlus();

  final List effectsCollection = [
    "None",
    AppAsset.effectBrightGlasses,
    AppAsset.effectNeonDevilHorns,
    AppAsset.effectMakeupKim,
    AppAsset.effectBurningEffect,
    AppAsset.effectSpringFairy,
    AppAsset.effectBunnyEars,
    AppAsset.effectButterflyHeadband,
    AppAsset.effectCrackedPorcelainFace,
    AppAsset.effectFaceSwap,
    // AppAsset.effectNickShoes,
    AppAsset.effectSequinButterfly,
    AppAsset.effectSpringDeer,
    AppAsset.effectSmallFlowers,
  ];

  final List<String> effectImages = [
    "None",
    AppAsset.imgBrightGlasses,
    AppAsset.imgNeonDevilHorns,
    AppAsset.imgMakeupKim,
    AppAsset.imgBurningEffect,
    AppAsset.imgSpringFairy,
    AppAsset.imgBunnyEars,
    AppAsset.imgButterflyHeadband,
    AppAsset.imgCrackedPorcelainFace,
    AppAsset.imgFaceSwap,
    // AppAsset.imgNickShoes,
    AppAsset.imgSequinButterfly,
    AppAsset.imgSmallFlowers,
    AppAsset.imgSpringDeer,
  ];

  final List<String> effectNames = [
    "None",
    "Bright Glasses",
    "Neon Devil Horns",
    "Makeup Kim",
    "Burning Effect",
    "Spring Fairy",
    "Bunny Ears",
    "Butterfly Headband",
    "Cracked Porcelain Face",
    "Face Swap",
    // "Nick Shoes",
    "Sequin Butterfly",
    "Spring Deer",
    "Small Flowers",
  ];

  final List effectsImageCollection = [];

  bool isShowEffects = false;

  int selectedEffectIndex = 0;

  bool isInitializeEffect = false;

  bool isFrontCamera = false;

  // >>>>> >>>>> >>>>> Initialize Method <<<<< <<<<< <<<<<

  @override
  void onInit() {
    Utils.showLog("Argument => ${Get.arguments}");

    if (Get.arguments != null) {
      selectedSound = Get.arguments;
      initAudio(selectedSound?["link"] ?? "");
    }
    onGetPermission();
    super.onInit();
  }

  @override
  void onClose() {
    if (isUseEffects) {
      onDisposeEffect();
    } else {
      onDisposeCamera();
    }
    super.onClose();
  }

  Future<void> onGetPermission() async {
    final camera = await Permission.camera.request();
    final microphone = await Permission.microphone.request();
    if (camera.isGranted && microphone.isGranted) {
      if (isUseEffects) {
        onInitializeEffect();
      } else {
        onInitializeCamera();
      }
    } else {
      Utils.showToast(EnumLocal.txtPleaseAllowPermission.name.tr);
    }
  }
  // Future<void> onGetPermission() async {
  //   PermissionStatus cameraStatus = await Permission.camera.request();
  //   PermissionStatus storageStatus = await Permission.storage.request();
  //   PermissionStatus microphoneStatus = await Permission.microphone.request();
  //
  //   if (cameraStatus == PermissionStatus.granted && microphoneStatus == PermissionStatus.granted || storageStatus == PermissionStatus.granted) {
  //     if (isUseEffects) {
  //       onInitializeEffect();
  //     } else {
  //       onInitializeCamera();
  //     }
  //   } else {
  //     Utils.showToast(EnumLocal.txtPleaseAllowPermission.name.tr);
  //   }
  // }

  // >>>>> >>>>> >>>>> Camera Controller Method <<<<< <<<<< <<<<<

  Future<void> onInitializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.last; // Use the first available camera
      cameraController = CameraController(camera, ResolutionPreset.medium);
      await cameraController?.initialize();
      update(["onInitializeCamera"]);
    } catch (e) {
      Utils.showLog("Error initializing camera: $e");
    }
  }

  Future<void> onDisposeCamera() async {
    cameraController?.dispose();
    cameraController = null;
    cameraController?.removeListener(cameraControllerListener);

    Utils.showLog("Camera Controller Dispose Success");
  }

  Future<void> cameraControllerListener() async {
    Utils.showLog("Change Camera Event => ${cameraController?.value}");
  }

  Future<void> onSwitchFlash() async {
    if (cameraLensDirection == CameraLensDirection.back) {
      if (isFlashOn) {
        isFlashOn = false;
        await cameraController?.setFlashMode(FlashMode.off);
      } else {
        isFlashOn = true;
        await cameraController?.setFlashMode(FlashMode.torch);
      }
      update(["onSwitchFlash"]);
    }
  }

  Future<void> onSwitchCamera() async {
    Utils.showLog("Switch Normal Camera Method Calling....");

    if (isRecording == "stop") {
      Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
      if (isFlashOn) {
        onSwitchFlash();
      }

      cameraLensDirection = cameraLensDirection == CameraLensDirection.back ? CameraLensDirection.front : CameraLensDirection.back;
      final cameras = await availableCameras();
      final camera = cameras.firstWhere((camera) => camera.lensDirection == cameraLensDirection);
      cameraController = CameraController(camera, ResolutionPreset.high);
      await cameraController!.initialize();
      update(["onInitializeCamera"]);
      Get.back(); // Stop Loading...
    } else {
      Utils.showLog("Please Try After Complete Video Recording...");
    }
  }

  Future<void> onStartRecording() async {
    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
        onRestartAudio();
        await cameraController!.startVideoRecording();
        Get.back(); // Stop Loading...
        if (cameraController!.value.isRecordingVideo) {
          onChangeRecordingEvent("start");
          Utils.showLog("Video Recording Starting....");
        }
      }
    } catch (e) {
      onPauseAudio();
      onChangeRecordingEvent("stop");
      Utils.showLog("Recording Starting Error => $e");
    }
  }

  Future<void> onPauseRecording() async {
    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
        onPauseAudio();
        await cameraController!.pauseVideoRecording();
        Get.back(); // Stop Loading...
        if (cameraController!.value.isRecordingPaused) {
          onChangeRecordingEvent("pause");
          Utils.showLog("Video Recording Pausing....");
        }
      }
    } catch (e) {
      onChangeRecordingEvent("stop");
      Utils.showLog("Recording Pausing Error => $e");
    }
  }

  Future<void> onResumeRecording() async {
    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
        onResumeAudio();
        await cameraController!.resumeVideoRecording();
        Get.back(); // Stop Loading...
        if (cameraController!.value.isRecordingPaused) {
          onChangeRecordingEvent("start");
          Utils.showLog("Video Recording Resume....");
        }
      }
    } catch (e) {
      onPauseAudio();
      onChangeRecordingEvent("stop");
      Utils.showLog("Video Recording Resume Error => $e");
    }
  }

  Future<String?> onStopRecording() async {
    XFile? videoUrl;
    if (Get.currentRoute == AppRoutes.createReelsPage) {
      try {
        if (isFlashOn) {
          onSwitchFlash();
        }
        Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
        onPauseAudio();
        videoUrl = await cameraController!.stopVideoRecording();
        Get.back(); // Stop Loading...
        onChangeRecordingEvent("stop");
        Utils.showLog("Recording Video Path => ${videoUrl.path}");
        return videoUrl.path;
      } catch (e) {
        onChangeRecordingEvent("stop");
        Utils.showLog("Recording Stop Failed !! => $e");
        return null;
      }
    } else {
      onChangeRecordingEvent("stop");
      Utils.showLog("User Back To Create Reels Page....");
      return null;
    }
  }

  Future<void> onClickRecordingButton() async {
    if (isRecording == "stop") {
      onChangeRecordingEvent("start");
      onChangeTimer();
      onStartRecording();
    } else if (isRecording == "start") {
      onChangeRecordingEvent("pause");
      onChangeTimer();
      onPauseRecording();
    } else if (isRecording == "pause") {
      onChangeRecordingEvent("start");
      onChangeTimer();
      onResumeRecording();
    }
  }

  // >>>>> >>>>> >>>>> Effect Controller Method <<<<< <<<<< <<<<<

  Future<void> onInitializeEffect() async {
    try {
      Utils.showLog("Effect Controller Initializing...");

      await deepArController.initialize(
        androidLicenseKey: Utils.effectAndroidLicenseKey,
        iosLicenseKey: Utils.effectIosLicenseKey,
        resolution: Resolution.medium,
      );

      isFrontCamera = true;
      update(["onInitializeEffect"]);

      isInitializeEffect = deepArController.isInitialized;

      Utils.showLog("Effect Controller Initialize => $isInitializeEffect");
    } catch (e) {
      Utils.showLog("Effect Controller Initialize Failed => $e");
    }
  }

  Future<void> onDisposeEffect() async {
    deepArController.destroy();
    deepArController = DeepArControllerPlus();
    isInitializeEffect = false;
    update(["onInitializeEffect"]);
    Utils.showLog("Effect Controller Dispose Success");
  }

  Future<void> onSwitchEffectFlash() async {
    if (isFrontCamera == false) {
      if (isFlashOn) {
        isFlashOn = false;
        await deepArController.toggleFlash();
      } else {
        isFlashOn = true;
        await deepArController.toggleFlash();
      }
      update(["onSwitchEffectFlash"]);
    }
  }

  Future<void> onSwitchEffectCamera() async {
    if (isRecording == "stop") {
      Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
      if (isFlashOn) {
        onSwitchEffectFlash();
      }

      try {
        await deepArController.flipCamera();
        isFrontCamera = !isFrontCamera;
      } catch (e) {
        Utils.showLog("Effect Flip Camera Failed !! =>$e");
      }

      Get.back(); // Stop Loading...
    } else {
      Utils.showLog("Please Try After Complete Video Recording...");
    }
  }

  Future<void> onToggleEffect() async {
    isShowEffects = !isShowEffects;
    update(["onToggleEffect"]);
  }

  Future<void> onChangeEffect(int index) async {
    try {
      selectedEffectIndex = index;
      await deepArController.switchEffect(effectsCollection[selectedEffectIndex]);
      update(["onChangeEffect"]);
    } catch (e) {
      Utils.showLog("Switch Effect Failed => $e");
    }
  }

  Future<void> onClearEffect(int index) async {
    try {
      if (selectedEffectIndex != 0) {
        selectedEffectIndex = index;
        onDisposeEffect();
        onInitializeEffect();
        update(["onChangeEffect"]);
      }
    } catch (e) {
      Utils.showLog("Clear Effect Failed => $e");
    }
  }

  Future<void> onStartEffectRecording() async {
    try {
      if (isInitializeEffect) {
        if (isShowEffects) {
          onToggleEffect();
        }
        onRestartAudio();
        await deepArController.startVideoRecording();
        onChangeRecordingEvent("start");
        Utils.showLog("Video Recording Starting....");
      }
    } catch (e) {
      onPauseAudio();
      onChangeRecordingEvent("stop");
      Utils.showLog("Recording Starting Error => $e");
    }
  }

  Future<String?> onStopEffectRecording() async {
    XFile? videoUrl;
    if (Get.currentRoute == AppRoutes.createReelsPage) {
      try {
        if (isFlashOn) {
          onSwitchEffectFlash();
        }
        Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...

        onPauseAudio();
        final file = await deepArController.stopVideoRecording();
        videoUrl = XFile(file.path);

        Get.back(); // Stop Loading...

        onChangeRecordingEvent("stop");
        Utils.showLog("Recording Video Path => ${videoUrl.path}");

        return videoUrl.path;
      } catch (e) {
        onChangeRecordingEvent("stop");
        Utils.showLog("Recording Stop Failed !! => $e");
        return null;
      }
    } else {
      onChangeRecordingEvent("stop");
      Utils.showLog("User Back To Create Reels Page....");
      return null;
    }
  }

  Future<void> onLongPressStart(LongPressStartDetails details) async {
    onChangeRecordingEvent("start");
    onChangeTimer();
    onStartEffectRecording();
  }

  Future<void> onLongPressEnd(LongPressEndDetails details) async {
    onChangeRecordingEvent("stop");
    onChangeTimer();
    final videoPath = await onStopEffectRecording();
    if (videoPath != null) {
      onPreviewVideo(videoPath);
    }
  }

  //  >>>>> >>>>> >>>>>  Video Duration Method <<<<< <<<<< <<<<<

  Future<void> onChangeTimer() async {
    if (isRecording == "start") {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          if (isRecording == "start" && countTime <= selectedDuration) {
            countTime++;
            update(["onChangeTimer", "onChangeRecordingEvent"]);
            if (countTime == selectedDuration) {
              {
                countTime = 0;
                timer.cancel();
                onChangeRecordingEvent("stop");
                final videoPath = isUseEffects ? await onStopEffectRecording() : await onStopRecording();
                if (videoPath != null) {
                  onPreviewVideo(videoPath);
                }
              }
            }
          }
        },
      );
    } else if (isRecording == "pause") {
      timer?.cancel();
      update(["onChangeTimer", "onChangeRecordingEvent"]);
    } else {
      countTime = 0;
      timer?.cancel();
      onChangeRecordingEvent("stop");
      update(["onChangeTimer", "onChangeRecordingEvent"]);
    }
  }

  Future<void> onChangeRecordingDuration(int index) async {
    selectedDuration = recordingDurations[index];
    update(["onChangeRecordingDuration"]);
  }

  Future<void> onChangeRecordingEvent(String type) async {
    isRecording = type;
    update(["onChangeRecordingEvent"]);
  }

  //  >>>>> >>>>> >>>>>  Preview Video Method <<<<< <<<<< <<<<<

  Future<String?> onRemoveAudio(String videoPath) async {
    final String videoWithoutAudioPath = '${(await getTemporaryDirectory()).path}/RM_${DateTime.now().millisecondsSinceEpoch}.mp4';
    final ffmpegRemoveAudioCommand = '-i $videoPath -c copy -an $videoWithoutAudioPath';
    // final sessionRemoveAudio = await FFmpegKit.executeAsync(ffmpegRemoveAudioCommand);
    // final returnCodeRemoveAudio = await sessionRemoveAudio.getReturnCode();
    Utils.showLog("Remove Audio Path => $videoWithoutAudioPath");
    // Utils.showLog("Return Code => $returnCodeRemoveAudio");
    return videoWithoutAudioPath;
  }

  Future<String?> onMergeAudioWithVideo(String videoPath, String audioPath) async {
    final String path = '${(await getTemporaryDirectory()).path}/FV_${DateTime.now().millisecondsSinceEpoch}.mp4';

    videoTime = (await CustomVideoTime.onGet(videoPath) ?? 0).toDouble();

    final soundTime = (await onGetSoundTime(audioPath) ?? 0);

    if (soundTime != 0 && videoTime != null && videoTime != 0) {
      Utils.showLog("Audio Time => $soundTime Video Time => $videoTime");

      final minTime = (videoTime! < soundTime) ? videoTime : soundTime;

      // final command = '-i $videoPath -i $audioPath -t $minTime -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 $path';

      final command = '-i $videoPath -i $audioPath -t $minTime -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 $path';

      final sessionRemoveAudio = await FFmpegKit.executeAsync(command);
      final returnCodeRemoveAudio = await sessionRemoveAudio.getReturnCode();
      Utils.showLog("Return Code => $returnCodeRemoveAudio");

      Utils.showLog("Merge Video Path => $path");
      return path;
    } else {
      return null;
    }
  }

  Future<void> onClickPreviewButton() async {
    Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
    onChangeRecordingEvent("stop");
    onChangeTimer();
    final videoPath = await onStopRecording();
    Get.back(); // Stop Loading...
    if (videoPath != null) {
      onPreviewVideo(videoPath);
    }
  }

  Future<void> onPreviewVideo(String videoPath) async {
    Get.dialog(barrierDismissible: false, const LoadingUi()); // Start Loading...
    videoImage = await CustomThumbnail.onGet(videoPath);
    if (selectedSound != null) {
      Utils.showLog("Removing Audio From Video...");

      Utils.showToast(EnumLocal.txtPleaseWaitSomeTime.name.tr);
      // final removeVideoPath = await onRemoveAudio(videoPath);
      // await 2.seconds.delay();
      // if (removeVideoPath != null) {
      //   Utils.showLog("REMOVE AUDIO PATH => ${removeVideoPath}");

      Utils.showLog("SONG => ${selectedSound}");

      final mergeVideoPath = await onMergeAudioWithVideo(videoPath, selectedSound?["link"]);
      await 5.seconds.delay();
      Get.back(); // Stop Loading...

      if (mergeVideoPath != null && videoTime != null && videoImage != null) {
        Utils.showLog("Video Path => ${mergeVideoPath}");
        Utils.showLog("Video Image => ${videoImage}");
        Utils.showLog("Video Time => ${videoTime}");

        Get.offAndToNamed(
          AppRoutes.previewCreatedReelsPage,
          arguments: {
            "video": mergeVideoPath,
            "image": videoImage,
            "time": videoTime?.toInt(),
            "songId": selectedSound?["id"] ?? "",
          },
        );
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
        Utils.showLog("Get Video Image/Video Time Failed !!");
      }
      // } else {
      //   Get.back(); // Stop Loading...
      // }
    } else {
      videoTime = (await CustomVideoTime.onGet(videoPath) ?? 0).toDouble();
      Get.back(); // Stop Loading...

      if (videoTime != null && videoImage != null) {
        Utils.showLog("Video Path => ${videoPath}");
        Utils.showLog("Video Image => ${videoImage}");
        Utils.showLog("Video Time => ${videoTime}");

        Get.offAndToNamed(
          AppRoutes.previewCreatedReelsPage,
          arguments: {
            "video": videoPath,
            "image": videoImage,
            "time": videoTime?.toInt(),
            "songId": "",
          },
        );
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
        Utils.showLog("Get Video Image/Video Time Failed !!");
      }
    }
  }

  //  >>>>> >>>>> >>>>>  Music Bottom Sheet <<<<< <<<<< <<<<<

  AudioPlayer _audioPlayer = AudioPlayer();

  Map? selectedSound;

  int selectedTabIndex = 0;
  TextEditingController searchController = TextEditingController();
  final List soundTabPages = [const DiscoverTabUi(), const FavouriteTabUi()];

  bool isLoadingSound = true;
  List<AllSongs> mainSoundCollection = [];
  FetchAllSoundModel? fetchAllSoundModel;

  bool isLoadingFavoriteSound = true;
  List<FavoriteSongs> favoriteSoundCollection = [];
  FetchFavoriteSoundModel? fetchFavoriteSoundModel;
  ScrollController favoriteSoundController = ScrollController();

  bool isSearching = false;
  SearchSoundModel? searchSoundModel;
  List<SearchData> searchSounds = [];
  bool isSearchLoading = false;

  Future<void> onChangeTabBar(int index) async {
    selectedTabIndex = index;
    if (index == 0) {
      initAllSound();
    } else if (index == 1) {
      initFavoriteSound();
    }
    update(["onChangeTabBar"]);
  }

  void onChangeSearchEvent() {
    if (searchController.text.trim().isEmpty) {
      isSearching = false;
      update(["onChangeSearchEvent"]);
    } else if (searchController.text.trim().length == 1) {
      isSearching = true;
      update(["onChangeSearchEvent"]);
    }
  }

  Future<void> onSearchSound() async {
    onChangeSearchEvent();
    if (searchController.text.trim().isNotEmpty) {
      Utils.showLog("Search Sound Method Calling...");

      isSearchLoading = true;
      update(["onSearchSound"]);

      searchSoundModel = await SearchSoundApi.callApi(loginUserId: Database.loginUserId, searchText: searchController.text);

      if (searchSoundModel?.searchData != null) {
        searchSounds.clear();
        searchSounds.addAll(searchSoundModel?.searchData ?? []);
        isSearchLoading = false;
        update(["onSearchSound"]);
      }
    }
  }

  Future<void> initAllSound() async {
    mainSoundCollection.clear();

    onGetAllSound();
  }

  Future<void> onGetAllSound() async {
    if (mainSoundCollection.isEmpty) {
      isLoadingSound = true;
      update(["onGetAllSound"]);
    }

    fetchAllSoundModel = null;
    fetchAllSoundModel = await FetchAllSoundApi.callApi(loginUserId: Database.loginUserId);

    if (fetchAllSoundModel?.songs != null) {
      isLoadingSound = false;
      mainSoundCollection.addAll(fetchAllSoundModel?.songs ?? []);

      Utils.showLog("All Sound Length => ${mainSoundCollection.length}");
    }
    update(["onGetAllSound"]);
  }

  Future<void> initFavoriteSound() async {
    favoriteSoundCollection.clear();
    FetchFavoriteSoundApi.startPagination = 0;
    onGetFavoriteSound();
  }

  Future<void> onGetFavoriteSound() async {
    if (favoriteSoundCollection.isEmpty) {
      isLoadingFavoriteSound = true;
      update(["onGetFavoriteSound"]);
    }

    fetchFavoriteSoundModel = null;
    fetchFavoriteSoundModel = await FetchFavoriteSoundApi.callApi(loginUserId: Database.loginUserId);

    if (fetchFavoriteSoundModel?.songs != null) {
      isLoadingFavoriteSound = false;

      favoriteSoundCollection.addAll(fetchFavoriteSoundModel?.songs ?? []);

      Utils.showLog("Favorite Sound Length => ${favoriteSoundCollection.length}");
    }
    update(["onGetFavoriteSound"]);
  }

  Future<void> onChangeSound(Map sound) async {
    if (selectedSound?["id"] == sound["id"]) {
      selectedSound = null;
    } else {
      selectedSound = {
        "id": sound["id"],
        "name": sound["name"],
        "image": sound["image"],
        "link": sound["link"],
      };
      initAudio(sound["link"]);
    }
    update(["onChangeSound"]);
    Utils.showLog("--------------- ${selectedSound}");
  }

  Future<double?> onGetSoundTime(String audioPath) async {
    await _audioPlayer.setSourceUrl(audioPath);
    Duration? audioDuration = await _audioPlayer.getDuration();
    final audioTime = audioDuration?.inSeconds.toDouble();
    Utils.showLog("Selected Audio Time => $audioTime");
    return audioTime;
  }

  // >>>>> >>>>> >>>>> Play Sound Variable <<<<< <<<<< <<<<<

  AudioPlayer audioPlayer = AudioPlayer();

  void initAudio(String audio) async {
    try {
      await audioPlayer.setSource(UrlSource(audio));
    } catch (e) {
      Utils.showLog("Audio Play Failed !! => $e");
    }
  }

  void onResumeAudio() {
    if (selectedSound != null) {
      try {
        audioPlayer.resume();
      } catch (e) {
        Utils.showLog("Audio Resume Error => $e");
      }
    }
  }

  void onRestartAudio() {
    Utils.showLog("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    if (selectedSound != null) {
      try {
        audioPlayer.seek(Duration(milliseconds: 0));
        audioPlayer.resume();
      } catch (e) {
        Utils.showLog("Audio Restart Error => $e");
      }
    }
  }

  void onPauseAudio() {
    if (selectedSound != null) {
      try {
        audioPlayer.pause();
      } catch (e) {
        Utils.showLog("Audio Pause Error => $e");
      }
    }
  }
}
