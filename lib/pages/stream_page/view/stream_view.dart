import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/shimmer/stream_shimmer_ui.dart';
import 'package:auralive/pages/stream_page/controller/stream_controller.dart';
import 'package:auralive/pages/stream_page/widget/stream_widget.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/constant.dart';

class StreamView extends StatelessWidget {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StreamController());
    controller.init();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.find<BottomBarController>().onChangeBottomBar(0);
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          surfaceTintColor: AppColor.transparent,
          flexibleSpace: const StreamAppBarUi(),
        ),
        body: RefreshIndicator(
          color: AppColor.primary,
          onRefresh: () async => controller.init(), // This is Working => No Data...
          child: SingleChildScrollView(
            child: SizedBox(
              height: Get.height + 1 - AppConstant.bottomBarSize, // This Is Use To Active Refresh Indicator
              child: GetBuilder<StreamController>(
                id: "onGetLiveUser",
                builder: (controller) => controller.isLoading
                    ? StreamShimmerUi()
                    : controller.liveUsers.isEmpty
                        ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                        : RefreshIndicator(
                            onRefresh: () async => await controller.init(), // This is Working => Multiple Data...
                            child: SingleChildScrollView(
                              controller: controller.scrollController,
                              child: Column(
                                children: [
                                  GridView.builder(
                                    itemCount: controller.liveUsers.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 8),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      mainAxisExtent: 230,
                                    ),
                                    itemBuilder: (context, index) {
                                      final liveUser = controller.liveUsers[index];
                                      return LiveUserUi(
                                        image: liveUser.image ?? "",
                                        name: liveUser.name ?? "",
                                        userName: liveUser.userName ?? "",
                                        views: liveUser.view ?? 0,
                                        countryFlag: (liveUser.countryFlagImage != null && liveUser.countryFlagImage != "") ? liveUser.countryFlagImage! : "🇮🇳",
                                        roomId: liveUser.liveHistoryId ?? "",
                                        liveUserId: liveUser.id ?? "",
                                        isFollow: liveUser.isFollow ?? false,
                                        isVerified: liveUser.isVerified ?? false,
                                        isFake: liveUser.isFake ?? false,
                                        videoUrl: liveUser.videoUrl ?? "",
                                        isProfileImageBanned: liveUser.isProfileImageBanned ?? false,
                                      );
                                    },
                                  ),
                                  SizedBox(height: AppConstant.bottomBarSize + 20), // Use For Last Element Proper Show...
                                ],
                              ),
                            ),
                          ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: GetBuilder<StreamController>(
          id: "onPagination",
          builder: (controller) => Visibility(
            visible: controller.isPaginationLoading,
            child: LinearProgressIndicator(color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
