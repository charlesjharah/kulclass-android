import 'package:audioplayers/audioplayers.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:auralive/custom/custom_format_audio_time.dart';
import 'package:auralive/custom/custom_format_chat_time.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/preview_message_request_page/controller/preview_message_request_controller.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/ui/preview_profile_bottom_sheet_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';

class RequestUserAppBarUi extends GetView<PreviewMessageRequestController> {
  const RequestUserAppBarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: AppColor.transparent,
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
              GestureDetector(
                onTap: () {
                  if (controller.receiverUserId != "") {
                    PreviewProfileBottomSheetUi.show(
                      context: context,
                      userId: controller.receiverUserId,
                    );
                  }
                },
                child: Row(
                  children: [
                    Container(
                      height: 46,
                      width: 46,
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
                            child: PreviewNetworkImageUi(image: controller.receiverImage),
                          ),
                          Visibility(
                            visible: controller.isProfileImageBanned,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: BlurryContainer(
                                  blur: 3,
                                  borderRadius: BorderRadius.zero,
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
                          width: Get.width / 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  controller.receiverName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW700(AppColor.black, 16.5),
                                ).paddingOnly(bottom: 16),
                              ),
                              Visibility(
                                visible: controller.isVerify,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2, bottom: 12),
                                  child: Image.asset(AppAsset.icBlueTick, width: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text(
                            controller.receiverUserName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.styleW500(AppColor.coloGreyText, 12),
                          ).paddingOnly(top: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SenderMessageUi extends StatelessWidget {
  const SenderMessageUi({super.key, required this.message, required this.time});

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: Get.width / 1.6,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12, right: 38, top: 6, bottom: 18),
                decoration: const BoxDecoration(
                  gradient: AppColor.primaryLinearGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  message,
                  style: AppFontStyle.styleW400(AppColor.white, 16),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 6,
                child: Text(
                  time,
                  style: AppFontStyle.styleW500(AppColor.white, 8),
                ),
              ),
            ],
          ),
        ).paddingOnly(bottom: 15),
      ],
    );
  }
}

class ReceiverMessageUi extends StatelessWidget {
  const ReceiverMessageUi({super.key, required this.message, required this.time});

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width / 1.6,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 12, right: 38, top: 6, bottom: 18),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAECF8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      message,
                      style: AppFontStyle.styleW400(AppColor.black, 16),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 10,
                  child: Text(
                    time,
                    style: AppFontStyle.styleW500(AppColor.black, 8),
                  ),
                ),
              ],
            ),
          ),
        ).paddingOnly(bottom: 15),
      ],
    );
  }
}

class SenderImageUi extends StatelessWidget {
  const SenderImageUi({super.key, required this.image, required this.time, required this.isBanned});

  final String image;
  final String time;
  final bool isBanned;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => Get.to(PreviewChatImageUi(image: image, time: time)),
          child: Container(
            height: 250,
            width: Get.width / 2,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              gradient: AppColor.primaryLinearGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 230,
                  width: Get.width / 2,
                  margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 15),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      Center(child: Image.asset(AppAsset.icImagePlaceHolder, width: 100)),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 230,
                        width: Get.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: PreviewNetworkImageUi(image: image),
                      ),
                      Visibility(
                        visible: isBanned,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: BlurryContainer(
                              blur: 8,
                              borderRadius: BorderRadius.zero,
                              color: AppColor.black.withOpacity(0.3),
                              child: Offstage(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 6,
                  child: Text(
                    time,
                    style: AppFontStyle.styleW500(AppColor.white, 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ReceiverImageUi extends StatelessWidget {
  const ReceiverImageUi({super.key, required this.image, required this.time, required this.isBanned});

  final String image;
  final String time;
  final bool isBanned;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Get.to(PreviewChatImageUi(image: image, time: time)),
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Container(
              height: 250,
              width: Get.width / 2,
              decoration: BoxDecoration(
                color: Color(0xFFEAECF8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 230,
                    width: Get.width / 2,
                    margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 15),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        Center(child: Image.asset(AppAsset.icImagePlaceHolder, width: 100)),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: 230,
                          width: Get.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: PreviewNetworkImageUi(image: image),
                        ),
                        Visibility(
                          visible: isBanned,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: BlurryContainer(
                                blur: 8,
                                borderRadius: BorderRadius.zero,
                                color: AppColor.black.withOpacity(0.3),
                                child: Offstage(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 8,
                    child: Text(
                      time,
                      style: AppFontStyle.styleW500(AppColor.black, 8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReceiverAudioUi extends StatefulWidget {
  const ReceiverAudioUi({super.key, required this.id, required this.audio, required this.time});

  final String id;
  final String audio;
  final String time;

  @override
  State<ReceiverAudioUi> createState() => _ReceiverAudioUiState();
}

class _ReceiverAudioUiState extends State<ReceiverAudioUi> {
  AudioPlayer audioPlayer = AudioPlayer();

  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;

  RxInt audioDuration = 0.obs;
  RxInt audioCurrentDuration = 0.obs;

  final controller = Get.find<PreviewMessageRequestController>();

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void onInit() async {
    try {
      isLoading.value = true;
      await audioPlayer.play(UrlSource(widget.audio));
      onPauseAudio();

      final Duration? duration = await audioPlayer.getDuration();

      if (duration != null) {
        audioDuration.value = duration.inSeconds;
        Utils.showLog("Audio Duration => ${audioDuration.value}");
        isLoading.value = false;
      }

      audioPlayer.onPositionChanged.listen((event) {
        audioCurrentDuration.value = event.inSeconds;
        if (controller.currentPlayAudioId != widget.id && isPlaying.value) {
          onPauseAudio();
        }
      });
      audioPlayer.onPlayerComplete.listen(
        (event) async {
          audioCurrentDuration.value = 0;
          onPauseAudio();
          await audioPlayer.play(UrlSource(widget.audio));
          onPauseAudio();
        },
      );
    } catch (e) {
      Utils.showLog("Audio Play Failed !! => $e");
    }
  }

  void onPlayAudio() async {
    isPlaying.value = true;

    audioPlayer.resume();
    controller.currentPlayAudioId = widget.id;
  }

  void onPauseAudio() {
    isPlaying.value = false;
    audioPlayer.pause();

    // audioPlayer.source
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Container(
            height: 75,
            width: Get.width / 1.6,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 75,
                  width: Get.width / 1.6,
                  margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColor.colorBorder.withOpacity(0.6),
                  ),
                  child: Row(
                    children: [
                      Obx(
                        () => isLoading.value
                            ? Padding(
                                padding: EdgeInsets.only(right: 2.5, top: 5, bottom: 5),
                                child: LoadingUi(size: 30),
                              )
                            : GestureDetector(
                                onTap: () => isPlaying.value ? onPauseAudio() : onPlayAudio(),
                                child: Image.asset(isPlaying.value ? AppAsset.icPause : AppAsset.icPlay, width: 30),
                              ),
                      ),
                      5.width,
                      Expanded(
                        child: Obx(
                          () => SliderTheme(
                            data: SliderThemeData(
                              overlayShape: SliderComponentShape.noOverlay,
                              activeTrackColor: AppColor.colorTabBar,
                              thumbColor: AppColor.colorTabBar,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                              trackHeight: 5,
                            ),
                            child: Slider(
                              min: 0,
                              max: audioDuration.value.toDouble(),
                              value: audioCurrentDuration.value.toDouble(),
                              onChanged: (value) {
                                audioPlayer.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                        ),
                      ),
                      3.width,
                      Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primary,
                        ),
                        child: Image.asset(
                          AppAsset.icMicOn,
                          width: 20,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 70,
                  child: Obx(
                    () => Text(
                      CustomFormatAudioTime.convert(audioCurrentDuration.value),
                      style: AppFontStyle.styleW500(AppColor.primary, 9),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 8,
                  child: Text(
                    widget.time,
                    style: AppFontStyle.styleW500(AppColor.black, 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SenderAudioUi extends StatefulWidget {
  const SenderAudioUi({super.key, required this.id, required this.audio, required this.time});

  final String id;
  final String audio;
  final String time;

  @override
  State<SenderAudioUi> createState() => _SenderAudioUiState();
}

class _SenderAudioUiState extends State<SenderAudioUi> {
  AudioPlayer audioPlayer = AudioPlayer();

  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;

  RxInt audioDuration = 0.obs;
  RxInt audioCurrentDuration = 0.obs;

  final controller = Get.find<PreviewMessageRequestController>();

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void onInit() async {
    Utils.showLog("Audio Initializing...  ${widget.audio}");

    isLoading.value = true;
    audioPlayer.audioCache.clearAll();

    await audioPlayer.play(UrlSource(widget.audio));

    onPauseAudio();

    final Duration? duration = await audioPlayer.getDuration();

    if (duration != null) {
      audioDuration.value = duration.inSeconds;
      Utils.showLog("Audio Duration => ${audioDuration.value}");
      isLoading.value = false;
    }

    audioPlayer.onPositionChanged.listen((event) {
      audioCurrentDuration.value = event.inSeconds;

      if (controller.currentPlayAudioId != widget.id && isPlaying.value) {
        onPauseAudio();
      }
    });

    audioPlayer.onPlayerComplete.listen(
      (event) async {
        audioCurrentDuration.value = 0;
        onPauseAudio();
        await audioPlayer.play(UrlSource(widget.audio));
        onPauseAudio();
      },
    );
  }

  void onPlayAudio() async {
    isPlaying.value = true;
    audioPlayer.resume();
    controller.currentPlayAudioId = widget.id;
  }

  void onPauseAudio() {
    isPlaying.value = false;
    audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 75,
          width: Get.width / 1.6,
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            gradient: AppColor.primaryLinearGradient,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 75,
                width: Get.width / 1.6,
                margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Row(
                  children: [
                    Obx(
                      () => isLoading.value
                          ? Padding(
                              padding: EdgeInsets.only(right: 2.5, top: 5, bottom: 5),
                              child: LoadingUi(size: 30),
                            )
                          : GestureDetector(
                              onTap: () => isPlaying.value ? onPauseAudio() : onPlayAudio(),
                              child: Image.asset(isPlaying.value ? AppAsset.icPause : AppAsset.icPlay, width: 30),
                            ),
                    ),
                    5.width,
                    Expanded(
                      child: Obx(
                        () => SliderTheme(
                          data: SliderThemeData(
                            overlayShape: SliderComponentShape.noOverlay,
                            activeTrackColor: AppColor.colorTabBar,
                            thumbColor: AppColor.colorTabBar,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                            trackHeight: 5,
                          ),
                          child: Slider(
                            min: 0,
                            max: audioDuration.value.toDouble(),
                            value: audioCurrentDuration.value.toDouble(),
                            onChanged: (value) {
                              audioPlayer.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                      ),
                    ),
                    3.width,
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primary,
                      ),
                      child: Image.asset(
                        AppAsset.icMicOn,
                        width: 20,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 70,
                child: Obx(
                  () => Text(
                    CustomFormatAudioTime.convert(audioCurrentDuration.value),
                    style: AppFontStyle.styleW500(AppColor.primary, 9),
                  ),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 8,
                child: Text(
                  widget.time,
                  style: AppFontStyle.styleW500(AppColor.white, 8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PreviewChatImageUi extends GetView<PreviewMessageRequestController> {
  const PreviewChatImageUi({super.key, required this.image, required this.time});

  final String image;
  final String time;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: AppColor.black,
            statusBarColor: AppColor.black,
            statusBarBrightness: Brightness.light,
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.black,
          surfaceTintColor: AppColor.transparent,
          shadowColor: AppColor.black.withOpacity(0.4),
          flexibleSpace: SafeArea(
            bottom: false,
            child: Container(
              color: AppColor.transparent,
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
                        child: Center(child: Image.asset(AppAsset.icBack, color: AppColor.white, width: 25)),
                      ),
                    ),
                    2.width,
                    Container(
                      height: 46,
                      width: 46,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.colorBorder,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.white,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(AppAsset.icProfilePlaceHolder),
                          ),
                          AspectRatio(
                            aspectRatio: 1,
                            child: PreviewNetworkImageUi(image: controller.receiverImage),
                          ),
                        ],
                      ),
                    ),
                    10.width,
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Text(
                          controller.receiverName,
                          style: AppFontStyle.styleW700(AppColor.white, 16.5),
                        ).paddingOnly(bottom: 16),
                        Text(
                          controller.receiverUserName,
                          style: AppFontStyle.styleW500(AppColor.white.withOpacity(0.8), 12),
                        ).paddingOnly(top: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAsset.icImagePlaceHolder, height: Get.width / 2),
            PreviewNetworkImageUi(image: image),
          ],
        ),
      ),
    );
  }
}

class UploadAudioUi extends StatelessWidget {
  const UploadAudioUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 75,
          width: Get.width / 1.6,
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            gradient: AppColor.primaryLinearGradient,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 75,
                width: Get.width / 1.6,
                margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Row(
                  children: [
                    Lottie.asset(AppAsset.lottieUpload, width: 35),
                    5.width,
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          overlayShape: SliderComponentShape.noOverlay,
                          activeTrackColor: AppColor.colorTabBar,
                          thumbColor: AppColor.colorTabBar,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                          trackHeight: 5,
                        ),
                        child: Slider(
                          min: 0,
                          max: 10,
                          value: 0,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    3.width,
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primary,
                      ),
                      child: Image.asset(
                        AppAsset.icMicOn,
                        width: 20,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 70,
                child: Text(
                  CustomFormatAudioTime.convert(0),
                  style: AppFontStyle.styleW500(AppColor.primary, 9),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 8,
                child: Text(
                  CustomFormatChatTime.convert(DateTime.now().toString()),
                  style: AppFontStyle.styleW500(AppColor.white, 8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
