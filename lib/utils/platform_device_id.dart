import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

/// Provides device id information.
class PlatformDeviceId {
  /// Provides device and operating system information.
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  /// Information derived from `android`-`androidId` or `ios`-`identifierForVendor`
  static Future<String?> get getDeviceId async {
    String? deviceId;
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }
    } on PlatformException {
      deviceId = '';
    }
    return deviceId;
  }
}
