import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/constant.dart';

class BottomBarUi extends StatelessWidget {
  const BottomBarUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      id: "onChangeBottomBar",
      builder: (logic) {
        return SizedBox(
          height: AppConstant.bottomBarSize.toDouble(),
          width: Get.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 0 ? AppAsset.icReelsSelected : AppAsset.icReels,
                callback: () => logic.onChangeBottomBar(0),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 1 ? AppAsset.icStreamingSelected : AppAsset.icStreaming,
                callback: () => logic.onChangeBottomBar(1),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 2 ? AppAsset.icFeedsSelected : AppAsset.icFeeds,
                callback: () => logic.onChangeBottomBar(2),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 3 ? AppAsset.icMessageSelected : AppAsset.icMessage,
                callback: () => logic.onChangeBottomBar(3),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 4 ? AppAsset.icProfileSelected : AppAsset.icProfile,
                callback: () => logic.onChangeBottomBar(4),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomBarIconUi extends StatelessWidget {
  const _BottomBarIconUi({required this.icon, required this.callback});

  final String icon;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          color: AppColor.transparent,
          child: Center(child: Image.asset(icon, width: 32)),
        ),
      ),
    );
  }
}
