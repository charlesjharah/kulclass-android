import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:auralive/utils/utils.dart';

class InternetConnection {
  static RxBool isConnect = false.obs;

  static Future<void> init() async {
    // ✅ check immediately at startup
    final results = await Connectivity().checkConnectivity();
    if (results.isNotEmpty) {
      final result = results.first;
      _updateStatus(result);
    }

    // ✅ listen for changes
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        _updateStatus(results.first);
      } else {
        isConnect.value = false;
        Utils.showLog("No Connectivity Results Found...");
      }
    });
  }

  static void _updateStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        isConnect.value = false;
        Utils.showLog("Network Not Connected...");
        break;
      case ConnectivityResult.bluetooth:
        isConnect.value = true;
        Utils.showLog("Network Connected to Bluetooth...");
        break;
      case ConnectivityResult.wifi:
        isConnect.value = true;
        Utils.showLog("Network Connected to Wifi...");
        break;
      case ConnectivityResult.ethernet:
        isConnect.value = true;
        Utils.showLog("Network Connected to Ethernet...");
        break;
      case ConnectivityResult.mobile:
        isConnect.value = true;
        Utils.showLog("Network Connected to Mobile...");
        break;
      case ConnectivityResult.vpn:
        isConnect.value = true;
        Utils.showLog("Network Connected to VPN...");
        break;
      case ConnectivityResult.other:
        isConnect.value = true;
        Utils.showLog("Network Connected to Other...");
        break;
    }
  }
}
