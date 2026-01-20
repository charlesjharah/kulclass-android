import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/custom/custom_dot_indicator.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/feed_page/model/post_image_model.dart';
import 'package:auralive/pages/profile_page/controller/profile_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';

class PreviewImageUi extends StatefulWidget {
  PreviewImageUi({
    super.key,
    this.id,
    required this.name,
    required this.userName,
    required this.userImage,
    required this.images,
    this.caption,
    required this.selectedIndex,
  });

  final String? id;
  final String name;
  final String userName;
  final String userImage;
  String? caption;
  final List<PostImage> images;
  final int selectedIndex;

  @override
  State<PreviewImageUi> createState() => _PreviewImageUiState();
}

class _PreviewImageUiState extends State<PreviewImageUi> {
  RxInt currentIndex = 0.obs;

  final profileController = Get.find<ProfileController>();

  PageController pageController = PageController();

  @override
  void initState() {
    pageController = PageController(initialPage: widget.selectedIndex);
    currentIndex.value = widget.selectedIndex;
    super.initState();
  }

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
                    Spacer(),

                    Visibility(
                      visible: widget.id != null,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.editPostPage, arguments: {
                            "images": widget.images,
                            // "images": widget.images.map((item) => item.url as String).toList(),
                            "isEdit": true,
                            "caption": widget.caption ?? "",
                            "postId": widget.id
                          });
                        },
                        child: BlurryContainer(
                          height: 38,
                          width: 38,
                          padding: EdgeInsets.zero,
                          color: AppColor.white.withOpacity(0.2),
                          blur: 5,
                          borderRadius: BorderRadius.circular(100),
                          child: Center(
                            child: Image.asset(
                              AppAsset.icEditPen,
                              color: AppColor.white,
                              width: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    15.width,
                    Visibility(
                      visible: widget.id != null,
                      child: GestureDetector(
                        onTap: () {
                          profileController.onClickDeletePost(postId: widget.id ?? "");
                        },
                        child: BlurryContainer(
                          height: 38,
                          width: 38,
                          padding: EdgeInsets.zero,
                          color: AppColor.white.withOpacity(0.2),
                          blur: 5,
                          borderRadius: BorderRadius.circular(100),
                          child: Center(
                            child: Image.asset(
                              AppAsset.icDelete,
                              color: AppColor.colorRedContainer,
                              width: 22,
                            ),
                          ),
                        ),
                      ),
                    ),

                    15.width,
                    // 2.width,
                    // Container(
                    //   height: 46,
                    //   width: 46,
                    //   clipBehavior: Clip.antiAlias,
                    //   decoration: BoxDecoration(
                    //     color: AppColor.colorBorder,
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: AppColor.white,
                    //         spreadRadius: 0.5,
                    //       ),
                    //     ],
                    //   ),
                    //   child: Stack(
                    //     children: [
                    //       AspectRatio(
                    //         aspectRatio: 1,
                    //         child: Image.asset(AppAsset.icProfilePlaceHolder),
                    //       ),
                    //       AspectRatio(
                    //         aspectRatio: 1,
                    //         child: PreviewNetworkImageUi(image: widget.userImage),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // 10.width,
                    // Stack(
                    //   alignment: Alignment.centerLeft,
                    //   children: [
                    //     Text(
                    //       widget.name,
                    //       style: AppFontStyle.styleW700(AppColor.white, 16.5),
                    //     ).paddingOnly(bottom: 16),
                    //     Text(
                    //       widget.userName,
                    //       style: AppFontStyle.styleW500(AppColor.white.withOpacity(0.8), 12),
                    //     ).paddingOnly(top: 22),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => Get.back(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: PageView.builder(
                itemCount: widget.images.length,
                controller: pageController,
                onPageChanged: (value) => currentIndex.value = value,
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.center,
                  children: [
                    PreviewNetworkImageUi(image: widget.images[index].url),
                    Visibility(
                      visible: widget.images[index].isBanned ?? false,
                      child: BlurryContainer(
                        height: Get.height,
                        width: Get.width,
                        blur: 15,
                        borderRadius: BorderRadius.zero,
                        color: AppColor.black.withOpacity(0.4),
                        child: Offstage(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: Get.height / 6,
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColor.transparent, AppColor.black.withOpacity(0.8)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Visibility(
                visible: widget.images.length > 1,
                child: Obx(() => CustomDotIndicator(index: currentIndex.value, length: widget.images.length)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
