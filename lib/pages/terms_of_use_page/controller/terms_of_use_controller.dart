import 'package:get/get.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUseController extends GetxController {
  WebViewController? webViewController;
  @override
  void onInit() {
    onInitializeWebView();
    super.onInit();
  }

  void onInitializeWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.white)
      ..loadRequest(Uri.parse(Utils.termsOfUseLink));
    update(["onInitializeWebView"]);
  }
}
