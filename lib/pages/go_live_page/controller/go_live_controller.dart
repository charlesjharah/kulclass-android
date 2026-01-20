import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/pages/go_live_page/api/create_live_user_api.dart';
import 'package:auralive/pages/go_live_page/model/create_live_user_model.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class GoLiveController extends GetxController {
  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

  bool isFlashOn = false;

  @override
  void onInit() {
    onRequestPermissions();
    super.onInit();
  }

  @override
  void onClose() {
    onDisposeCamera();
    super.onClose();
  }

  Future<void> onRequestPermissions() async {
    // Corrected code: Check if the app is NOT running on the web
    if (!kIsWeb) {
      final camera = await Permission.camera.request();
      final microphone = await Permission.microphone.request();
      if (camera.isGranted && microphone.isGranted) {
        onInitializeCamera();
      } else {
        Utils.showToast(EnumLocal.txtPleaseAllowPermission.name.tr);
      }
    } else {
      // For web, you might still want to initialize the camera
      // as browser permissions are handled automatically by the Camera package
      onInitializeCamera();
    }
  }

  Future<void> onInitializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.last; // Use the first available camera
      cameraController = CameraController(camera, ResolutionPreset.medium);
      await cameraController!.initialize();
      update(["onInitializeCamera"]);
    } catch (e) {
      Utils.showLog("Error initializing camera: $e");
    }
  }

  Future<void> onDisposeCamera() async {
    cameraController?.dispose();
    cameraController = null;

    Utils.showLog("Camera Controller Dispose Success");
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

    Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingUi())); // Start Loading...
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
  }

  Future<void> onClickGoLive() async {
    CreateLiveUserModel? createLiveUserModel;

    Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingUi())); // Start Loading...
    createLiveUserModel = await CreateLiveUserApi.callApi(loginUserId: Database.loginUserId);

    Get.back(); // Stop Loading...

    if (createLiveUserModel?.data?.liveHistoryId != null) {
      Utils.showLog("Live User Room Id => ${createLiveUserModel?.data?.liveHistoryId}");
      Get.offAndToNamed(AppRoutes.livePage, arguments: {
        "roomId": createLiveUserModel?.data?.liveHistoryId,
        "isHost": true,
        "userId": Database.loginUserId,
        "image": Database.fetchLoginUserProfileModel?.user?.image ?? "",
        "name": Database.fetchLoginUserProfileModel?.user?.name ?? "",
        "userName": Database.fetchLoginUserProfileModel?.user?.userName ?? "",
        "isFollow": false,
      });
    }
  }
}