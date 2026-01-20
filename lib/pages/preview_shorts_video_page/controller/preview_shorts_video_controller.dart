import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:auralive/pages/preview_shorts_video_page/model/preview_shorts_video_model.dart';

class PreviewShortsVideoController extends GetxController {
  bool isLoading = false;
  int currentPageIndex = 0;
  List<PreviewShortsVideoModel> mainShorts = [];
  PreloadPageController preloadPageController = PreloadPageController();

  bool previousPageIsAudioWiseVideoPage = false;

  @override
  void onInit() {
    onGetShorts();
    super.onInit();
  }

  void onGetShorts() async {
    isLoading = true;
    if (Get.arguments["video"] != null) {
      mainShorts.addAll(Get.arguments["video"]);
    }
    isLoading = false;
    update(["onGetShorts"]);
    currentPageIndex = Get.arguments["index"];
    previousPageIsAudioWiseVideoPage = Get.arguments["previousPageIsAudioWiseVideoPage"];
    preloadPageController = PreloadPageController(initialPage: currentPageIndex);
  }

  void onChangePage(int index) async {
    currentPageIndex = index;
    update(["onChangePage"]);
  }
}
