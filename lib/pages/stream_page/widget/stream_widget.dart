import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/ui/gradient_text_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/stream_page/controller/stream_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';
import 'package:auralive/utils/utils.dart';

class StreamAppBarUi extends StatelessWidget {
  const StreamAppBarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientTextUi(
                gradient: AppColor.primaryLinearGradientText,
                EnumLocal.txtLiveStreaming.name.tr,
                style: AppFontStyle.appBarStyle(),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.searchPage);
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: const BoxDecoration(gradient: AppColor.primaryLinearGradient, shape: BoxShape.circle),
                      child: Center(child: Image.asset(AppAsset.icSearch, width: 20)),
                    ),
                  ),
                  8.width,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.goLivePage);
                    },
                    child: Container(
                      height: 42,
                      width: 100,
                      decoration: BoxDecoration(gradient: AppColor.primaryLinearGradient, borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAsset.icTopStreaming, height: 22),
                          5.width,
                          Text(
                            EnumLocal.txtGoLive.name.tr,
                            style: AppFontStyle.styleW600(AppColor.white, 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.width,
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.scanQrCodePage),
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: const BoxDecoration(gradient: AppColor.primaryLinearGradient, shape: BoxShape.circle),
                      child: Center(child: Image.asset(AppAsset.icQr, color: AppColor.white, width: 22)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LiveUserUi extends StatelessWidget {
  const LiveUserUi({
    super.key,
    required this.image,
    required this.name,
    required this.userName,
    required this.views,
    required this.countryFlag,
    required this.roomId,
    required this.liveUserId,
    required this.isFollow,
    required this.isVerified,
    required this.isFake,
    required this.videoUrl,
    required this.isProfileImageBanned,
  });

  final String image;
  final String name;
  final String userName;
  final int views;
  final String countryFlag;
  final bool isFollow;
  final bool isVerified;
  final bool isFake;
  final bool isProfileImageBanned;
  final String videoUrl;
  final String roomId;
  final String liveUserId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isFake
          ? () {
              Utils.showLog("Join User Room Id => ${roomId}");
              Utils.showLog("Join User Room Id => ${videoUrl}");
              Get.toNamed(AppRoutes.fakeLivePage, arguments: {
                "roomId": roomId,
                "isHost": false,
                "userId": liveUserId,
                "image": image,
                "name": name,
                "userName": userName,
                "isFollow": isFollow,
                "videoUrl": videoUrl,
              })?.then(
                (value) {
                  final controller = Get.find<StreamController>();
                  controller.init();
                },
              );
            }
          : () {
              Utils.showLog("Join User Room Id => ${roomId}");

              Get.toNamed(AppRoutes.livePage, arguments: {
                "roomId": roomId,
                "isHost": false,
                "userId": liveUserId,
                "image": image,
                "name": name,
                "userName": userName,
                "isFollow": isFollow,
                "isProfileImageBanned": isProfileImageBanned,
              })?.then(
                (value) {
                  final controller = Get.find<StreamController>();
                  controller.init();
                },
              );
            },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.colorBorderGrey.withOpacity(0.8)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  Container(
                      height: 180,
                      width: Get.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 50,
                            child: Center(
                              child: Image.asset(AppAsset.icImagePlaceHolder, width: 100),
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: Get.width / 2,
                            width: Get.width / 2.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AspectRatio(aspectRatio: 1, child: PreviewNetworkImageUi(image: image)),
                                Visibility(
                                  visible: isProfileImageBanned,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: BlurryContainer(
                                        blur: 5,
                                        borderRadius: BorderRadius.zero,
                                        color: AppColor.black.withOpacity(0.5),
                                        child: Offstage(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                    top: 12,
                    left: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAsset.icView, width: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            CustomFormatNumber.convert(views),
                            style: AppFontStyle.styleW700(AppColor.white, 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 10,
                    child: Container(
                      height: 20,
                      width: 45,
                      decoration: BoxDecoration(
                        color: AppColor.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColor.white, width: 0.3),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: -5,
                            child: Lottie.asset(AppAsset.lottieWaveAnimation, fit: BoxFit.cover, height: 20, width: 15),
                          ),
                          Positioned(
                            right: 5,
                            child: Text(
                              EnumLocal.txtLive.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white, 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(AppAsset.icProfilePlaceHolder),
                          ),
                          AspectRatio(
                            aspectRatio: 1,
                            child: PreviewNetworkImageUi(image: image),
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
                    6.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 90,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW700(AppColor.black, 12),
                                ),
                              ),
                              Visibility(
                                visible: isVerified,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Image.asset(AppAsset.icBlueTick, width: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            userName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.styleW400(AppColor.black, 10),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    isFake
                        ? Container(height: 20, width: 20, child: Image.network(countryFlag))
                        : Text(
                            countryFlag,
                            style: AppFontStyle.styleW700(AppColor.black, 18),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
