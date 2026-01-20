import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/live_page/controller/live_controller.dart';
import 'package:auralive/pages/live_page/widget/live_widget.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/socket_services.dart';
import 'package:auralive/utils/utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  final controller = Get.put(LiveController());

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
    controller.isProfileImageBanned = Get.arguments["isProfileImageBanned"] ?? false;

    Utils.showLog("Is Live User Following => ${controller.isFollow}");

    startListenEvent();
    loginRoom();

    if (isHost) {
      controller.onChangeTime();
    } else {
      Timer(
        Duration(seconds: 5),
        () {
          if (remoteView == null) {
            Get.back();
          }
        },
      );
    }
    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    if (isHost == false) {
      stopListenEvent();
    }
    logoutRoom();
    SocketServices.onLiveRoomExit(isHost: isHost, liveHistoryId: roomID);
    controller.isLivePage = false;
    WakelockPlus.disable();
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
        child: isHost
            ? HostLiveUi(liveScreen: localView ?? const SizedBox.shrink())
            : UserLiveUi(
                liveScreen: remoteView ?? LoadingUi(),
                liveRoomId: roomID,
                liveUserId: controller.userId,
              ),
      ),
    );
  }

  Future<ZegoRoomLoginResult> loginRoom() async {
    final user = ZegoUser(localUserID, localUserName);

    final roomID = this.roomID;

    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()..isUserStatusNotify = true;

    return ZegoExpressEngine.instance.loginRoom(roomID, user, config: roomConfig).then((ZegoRoomLoginResult loginRoomResult) {
      debugPrint('loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
      if (loginRoomResult.errorCode == 0) {
        if (isHost) {
          startPreview();
          startPublish();
          SocketServices.userWatchCount.value = 0;
          SocketServices.userChats.clear();
          SocketServices.onLiveRoomConnect(loginUserId: Database.loginUserId, liveHistoryId: roomID);
        } else {
          SocketServices.userChats.clear();
          SocketServices.onAddView(loginUserId: Database.loginUserId, liveHistoryId: roomID);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('loginRoom failed: ${loginRoomResult.errorCode}')));
      }
      return loginRoomResult;
    });
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(this.roomID);
  }

  void startListenEvent() {
    ZegoExpressEngine.onRoomUserUpdate = (roomID, updateType, List<ZegoUser> userList) {
      debugPrint('onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
    };
    ZegoExpressEngine.onRoomStreamUpdate = (roomID, updateType, List<ZegoStream> streamList, extendedData) {
      debugPrint('onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
      if (updateType == ZegoUpdateType.Add) {
        for (final stream in streamList) {
          startPlayStream(stream.streamID);
        }
      } else {
        for (final stream in streamList) {
          stopPlayStream(stream.streamID);
        }
      }
    };
    ZegoExpressEngine.onRoomStateUpdate = (roomID, state, errorCode, extendedData) {
      debugPrint('onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };

    ZegoExpressEngine.onPublisherStateUpdate = (streamID, state, errorCode, extendedData) {
      debugPrint('onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };
  }

  void stopListenEvent() {
    SocketServices.onLessView(loginUserId: Database.loginUserId, liveHistoryId: roomID);

    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
  }

  Future<void> startPreview() async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      localViewID = viewID;
      ZegoCanvas previewCanvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);

      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    }).then((canvasViewWidget) {
      setState(() => localView = canvasViewWidget);
    });
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
      localViewID = null;
      localView = null;
    }
  }

  Future<void> startPublish() async {
    String streamID = '${roomID}_${localUserID}_call';
    return ZegoExpressEngine.instance.startPublishingStream(streamID);
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }

  Future<void> startPlayStream(String streamID) async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      remoteViewID = viewID;
      ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoPlayerConfig config = ZegoPlayerConfig.defaultConfig();
      config.resourceMode = ZegoStreamResourceMode.Default;
      ZegoExpressEngine.instance.enableCamera(true, channel: ZegoPublishChannel.Main);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas, config: config);
    }).then((canvasViewWidget) {
      setState(() => remoteView = canvasViewWidget);
    });
  }

  Future<void> stopPlayStream(String streamID) async {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    if (remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
      setState(() {
        remoteViewID = null;
        remoteView = null;
      });
    }
  }
}
