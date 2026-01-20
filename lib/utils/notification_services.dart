import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/pages/profile_page/controller/profile_controller.dart';
import 'package:auralive/routes/app_routes.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/utils.dart';

/// 🔴 Must be a top-level function (outside any class)
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Utils.showLog("🔥 Background Notification: ${message.messageId}");
  if (Database.isShowNotification && Utils.isAppOpen.value == false) {
    await NotificationServices.showNotification(message);
  }
}

class NotificationServices {
  static Callback callback = () {};

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    var androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/shortie_notification_icon');

    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        callback.call();
      },
    );

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

  }

  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Importance Notification",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "your channel description",
      playSound: true,
      priority: Priority.high,
      ticker: "ticker",
      enableVibration: true,
      icon: "@mipmap/shortie_notification_icon",
    );

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      Random.secure().nextInt(100000),
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      notificationDetails,
    );
  }

  static Future<void> firebaseInit() async {
    // This Method Call in Main...
    FirebaseMessaging.onMessage.listen(
          (message) {
        Utils.showLog("Local Notification => Is Show Notification => ${Database.isShowNotification} => Is App Open => ${Utils.isAppOpen}");
        Utils.showLog("Notification => ${message.data}");
        Utils.showLog("Notification Title => ${message.notification?.title.toString()}");
        Utils.showLog("Notification Body => ${message.notification?.body.toString()}");

        if (Database.isShowNotification && Utils.isAppOpen.value) {
          showNotification(message);
          callback = () async {
            try {
              if (message.data["type"] == "CHAT") {
                debugPrint("Click To Chat Notification");
                Get.offAllNamed(AppRoutes.bottomBarPage);
                await 1.seconds.delay();
                final bottomBarController = Get.find<BottomBarController>();
                bottomBarController.onChangeBottomBar(3); // Go To Chat Page...
              } else if (message.data["type"] == "VIDEOLIKE") {
                debugPrint("Click To Video Like Notification");
                Get.offAllNamed(AppRoutes.bottomBarPage);
                await 1.seconds.delay();
                final bottomBarController = Get.find<BottomBarController>();
                bottomBarController.onChangeBottomBar(4); // Go To Profile Page...
              } else if (message.data["type"] == "LIVE") {
                debugPrint("Click To Live Notification");
                Get.offAllNamed(AppRoutes.bottomBarPage);
                await 1.seconds.delay();
                final bottomBarController = Get.find<BottomBarController>();
                bottomBarController.onChangeBottomBar(1); // Go To Stream Page...
              } else if (message.data["type"] == "FOLLOW") {
                debugPrint("Click To Follow Notification");
                Get.offAllNamed(AppRoutes.bottomBarPage);
                await 1.seconds.delay();
                final bottomBarController = Get.find<BottomBarController>();
                bottomBarController.onChangeBottomBar(4); // Go To Profile Page...
              } else if (message.data["type"] == "GIFT") {
                debugPrint("Click To Gift Notification");
                Get.offAllNamed(AppRoutes.bottomBarPage);
                await 1.seconds.delay();
                final bottomBarController = Get.find<BottomBarController>();
                bottomBarController.onChangeBottomBar(4); // Go To Profile Page...
                final profileController = Get.find<ProfileController>();
                await 1.seconds.delay();
                profileController.tabController?.index = 2;
              }
            } catch (e) {
              Utils.showLog("Notification Change Routes Failed => ${e}");
            }
          };
        }
      },
    );
  }

  static Future<void> onShowBackgroundNotification(RemoteMessage message) async {
    Utils.showLog("Background Notification => Is Show Notification => ${Database.isShowNotification} => Is App Open => ${Utils.isAppOpen} => ${message.messageId}");
    // if (Database.isShowNotification && Utils.isAppOpen.value == false) {
    //   showNotification(message);
    // }
  }

  static Future<void> showUploadProgressNotification({
    required int notificationId,
    required String title,
    required String body,
    required int progress,
    required bool isCompleted,
  }) async {
    const String channelId = 'upload_progress';
    const String channelName = 'Upload Progress';

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      channelName,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Video Upload Process',
      importance: Importance.max,
      audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
      category: AndroidNotificationCategory.event,
      enableVibration: true,
      ticker: "Test",
      visibility: NotificationVisibility.public,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      progress: progress.clamp(0, 100),
      maxProgress: 100,
      ongoing: !isCompleted,
      autoCancel: isCompleted,
      playSound: true,
      icon: '@mipmap/shortie_notification_icon',
    );

    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_sound.aiff', // iOS sound file
      subtitle: 'Upload Progress', // Subtitle
      threadIdentifier: 'video-upload', // Thread ID
      badgeNumber: isCompleted ? 1 : null, // Badge when complete
      attachments: null,
      interruptionLevel: isCompleted ? InterruptionLevel.timeSensitive : InterruptionLevel.passive,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<void> cancelUploadNotification(int notificationId) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
