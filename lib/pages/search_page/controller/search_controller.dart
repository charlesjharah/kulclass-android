import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/search_page/api/search_hash_tag_api.dart';
import 'package:auralive/pages/search_page/api/search_user_api.dart';
import 'package:auralive/pages/search_page/model/search_hash_tag_model.dart';
import 'package:auralive/pages/search_page/model/search_user_model.dart';
import 'package:auralive/pages/search_page/widget/search_widget.dart';
import 'package:auralive/utils/database.dart';

class SearchController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();

  int selectedTabIndex = 0;
  final List searchTabPages = [const SearchUserTabUi(), const HashTagTabUi()];

  bool isSearching = false;

  // >>>> >>>> >>>> Search User <<<< <<<< <<<<

  SearchUserModel? searchUserModel;

  bool isLoadingUser = false;
  List<SearchUserData> userCollection = [];

  bool isSearchingUser = false;
  List<SearchUserData> searchUsers = [];

  // >>>> >>>> >>>> Search HashTag <<<< <<<< <<<<

  SearchHashTagModel? searchHashTagModel;

  bool isLoadingHashTag = false;
  List<SearchHashTagData> hashTagCollection = [];

  bool isSearchingHashTag = false;
  List<SearchHashTagData> searchHashTags = [];

  @override
  void onInit() async {
    init();
    super.onInit();
  }

  Future<void> init() async {
    isSearching = false;
    userCollection.clear();
    hashTagCollection.clear();
    onChangeTabBar(0);
  }

  void onChangeTabBar(int index) {
    selectedTabIndex = index;
    update(["onChangeTabBar"]);

    if (index == 0 && userCollection.isEmpty) {
      onGetUser();
    } else if (index == 1 && hashTagCollection.isEmpty) {
      onGetHashTag();
    }
  }

  Future<void> onGetUser() async {
    isLoadingUser = true;
    searchUserModel = null;
    searchUserModel = await SearchUserApi.callApi(loginUserId: Database.loginUserId, searchText: "");
    if (searchUserModel?.searchData != null) {
      userCollection.addAll(searchUserModel?.searchData ?? []);
      isLoadingUser = false;
      update(["onGetUser"]);
    }
  }

  Future<void> onGetHashTag() async {
    isLoadingHashTag = true;
    searchHashTagModel = null;
    searchHashTagModel = await SearchHashTagApi.callApi(loginUserId: Database.loginUserId, searchText: "");
    if (searchHashTagModel?.searchData != null) {
      hashTagCollection.addAll(searchHashTagModel?.searchData ?? []);
      isLoadingHashTag = false;
      update(["onGetHashTag"]);
    }
  }

  Future<void> onSearching() async {
    if (searchFieldController.text.trim().isNotEmpty) {
      isSearching = true; // Show Search Data...
      update(["onSearching"]);

      if (selectedTabIndex == 0) {
        await onSearchUser(searchFieldController.text);
      } else {
        await onSearchHashTag(searchFieldController.text);
      }
    } else if (searchFieldController.text.isEmpty) {
      isSearching = false; // Show All Data...
      update(["onSearching"]);
    }
  }

  Future<void> onSearchUser(String searchText) async {
    searchUserModel = null;
    searchUsers.clear();
    isSearchingUser = true;
    update(["onSearchUser"]);

    searchUserModel = await SearchUserApi.callApi(loginUserId: Database.loginUserId, searchText: searchText);
    if (searchUserModel?.searchData != null) {
      searchUsers.clear();
      searchUsers.addAll(searchUserModel?.searchData ?? []);
      isSearchingUser = false;
      update(["onSearchUser"]);
    }
  }

  Future<void> onSearchHashTag(String searchText) async {
    searchHashTagModel = null;
    searchHashTags.clear();
    isSearchingHashTag = true;
    update(["onSearchHashTag"]);
    searchHashTagModel = await SearchHashTagApi.callApi(loginUserId: Database.loginUserId, searchText: searchText);
    if (searchHashTagModel?.searchData != null) {
      searchHashTags.clear();
      searchHashTags.addAll(searchHashTagModel?.searchData ?? []);
      isSearchingHashTag = false;
      update(["onSearchHashTag"]);
    }
  }
}
