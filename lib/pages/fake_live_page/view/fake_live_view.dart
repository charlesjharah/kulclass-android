import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/fake_live_page/controller/fake_live_controller.dart';
import 'package:auralive/pages/fake_live_page/widget/fake_live_widget.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/socket_services.dart';
import 'package:auralive/utils/utils.dart';

class FakeLiveView extends StatefulWidget {
  const FakeLiveView({super.key});

  @override
  State<FakeLiveView> createState() => _FakeLiveViewState();
}

class _FakeLiveViewState extends State<FakeLiveView> {
  final controller = Get.put(FakeLiveController());

  bool isHost = false;
  String localUserID = Database.loginUserId;
  String localUserName = "Hello Developer";
  String roomID = "1234";

  Widget? localView;
  int? localViewID;
  Widget? remoteView;
  int? remoteViewID;

  @override
  void initState() {
    SocketServices.mainLiveComments.clear();

    isHost = Get.arguments["isHost"] ?? "";
    roomID = Get.arguments["roomId"] ?? "";
    controller.userId = Get.arguments["userId"] ?? "";
    controller.image = Get.arguments["image"] ?? "";
    controller.name = Get.arguments["name"] ?? "";
    controller.userName = Get.arguments["userName"] ?? "";
    controller.isFollow = Get.arguments["isFollow"] ?? false;
    controller.videoUrl = Get.arguments["videoUrl"] ?? "";

    controller.initializeVideoPlayer();
    Utils.showLog("Is Live User Following => ${controller.isFollow}");
    Utils.showLog("Is Live User Following => ${controller.videoUrl}");

    controller.onChangeTime();

    super.initState();
  }

  @override
  void dispose() {
    controller.isLivePage = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColor.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColor.black,
        child: UserLiveUi(
          liveScreen: remoteView ?? LoadingUi(),
          liveRoomId: roomID,
          liveUserId: controller.userId,
        ),
      ),
    );
  }
}
