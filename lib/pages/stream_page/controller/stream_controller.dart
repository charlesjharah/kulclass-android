import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/stream_page/api/fetch_live_user_api.dart';
import 'package:auralive/pages/stream_page/model/fetch_live_user_model.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/utils.dart';

class StreamController extends GetxController {
  ScrollController scrollController = ScrollController();
  bool isPaginationLoading = false;

  FetchLiveUserModel? fetchLiveUserModel;
  bool isLoading = false;
  List<LiveUserList> liveUsers = [];

  Future<void> init() async {
    try {
      isLoading = true;
      FetchLiveUserApi.startPagination = 0;
      liveUsers.clear();
      update(["onGetLiveUser"]);
      await onGetLiveUser();
      scrollController.removeListener(onPagination);
      scrollController.addListener(onPagination);
    } catch (e) {
      Utils.showLog("Steam Controller Failed => $e");
    }
  }

  Future<void> onGetLiveUser() async {
    fetchLiveUserModel = await FetchLiveUserApi.callApi(loginUserId: Database.loginUserId);

    if (fetchLiveUserModel?.liveUserList?.isNotEmpty ?? false) {
      Utils.showLog("Live User Pagination Data Length => ${fetchLiveUserModel?.liveUserList}");

      liveUsers.addAll(fetchLiveUserModel?.liveUserList ?? []);
      update(["onGetLiveUser"]);
    } else {
      FetchLiveUserApi.startPagination--;
    }
    if (isLoading) {
      isLoading = false;

      update(["onGetLiveUser"]);
    }
  }

  void onPagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && isPaginationLoading == false) {
      isPaginationLoading = true;
      update(["onPagination"]);
      await onGetLiveUser();
      isPaginationLoading = false;
      update(["onPagination"]);
    }
  }
}
