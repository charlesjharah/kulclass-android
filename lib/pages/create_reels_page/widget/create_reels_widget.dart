import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/custom/custom_format_time.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/shimmer/sound_shimmer_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/create_reels_page/api/favorite_unfavorite_api.dart';
import 'package:auralive/pages/create_reels_page/controller/create_reels_controller.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/size_extension.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class AddMusicBottomSheet {
  static void show({required BuildContext context}) {
    final controller = Get.put(CreateReelsController());
    controller.initAllSound();
    controller.initFavoriteSound();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useSafeArea: true,
      barrierColor: AppColor.black,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: (Get.height - 30),
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 70,
              color: AppColor.grey_50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColor.colorTextDarkGrey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      15.height,
                      Text(
                        EnumLocal.txtAddMusic.name.tr,
                        style: AppFontStyle.styleW700(AppColor.black, 17),
                      ),
                    ],
                  ).paddingOnly(left: 50),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 29,
                      width: 29,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.transparent,
                        border: Border.all(color: AppColor.black),
                      ),
                      child: Center(
                        child: Image.asset(
                          width: 16,
                          AppAsset.icClose,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: SearchSoundFieldUi(
                onChanged: (value) => controller.onSearchSound(),
                controller: controller.searchController,
                onClickClear: () {},
                isShowClearIcon: false,
              ),
            ),
            const SoundTabBarUi(),
            Expanded(
              child: GetBuilder<CreateReelsController>(
                id: "onChangeTabBar",
                builder: (logic) => PageView.builder(
                  itemCount: 2,
                  onPageChanged: (value) => logic.onChangeTabBar(value),
                  itemBuilder: (context, index) => logic.soundTabPages[logic.selectedTabIndex],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SoundTabBarUi extends StatelessWidget {
  const SoundTabBarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.transparent,
        border: Border(bottom: BorderSide(color: AppColor.colorBorder.withOpacity(0.3))),
      ),
      child: GetBuilder<CreateReelsController>(
        id: "onChangeTabBar",
        builder: (logic) => Row(
          children: [
            TabBarItemUi(
              title: EnumLocal.txtDiscover.name.tr,
              callback: () => logic.onChangeTabBar(0),
              isSelected: logic.selectedTabIndex == 0,
            ),
            TabBarItemUi(
              title: EnumLocal.txtFavourite.name.tr,
              callback: () => logic.onChangeTabBar(1),
              isSelected: logic.selectedTabIndex == 1,
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarItemUi extends StatelessWidget {
  const TabBarItemUi({super.key, required this.title, required this.callback, required this.isSelected});

  final String title;
  final Callback callback;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 50,
          color: AppColor.transparent,
          child: Center(
            child: Text(
              title,
              style: AppFontStyle.styleW500(isSelected ? AppColor.primary : AppColor.coloGreyText, 17),
            ),
          ),
        ),
      ),
    );
  }
}

class DiscoverTabUi extends StatelessWidget {
  const DiscoverTabUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateReelsController>(
      id: "onChangeSearchEvent",
      builder: (controller) => controller.isSearching
          ? GetBuilder<CreateReelsController>(
              id: "onSearchSound",
              builder: (controller) => controller.isSearchLoading
                  ? SoundShimmerUi()
                  : controller.searchSounds.isEmpty
                      ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.searchSounds.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.searchSounds[index].id ?? "",
                                songTitle: controller.searchSounds[index].songTitle ?? "",
                                songImage: controller.searchSounds[index].songImage ?? "",
                                songCategoryName: controller.searchSounds[index].songCategoryName ?? "",
                                singerName: controller.searchSounds[index].singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.searchSounds[index].songTime ?? 0),
                                isFavorite: controller.searchSounds[index].isFavorite ?? false,
                                isSelected: controller.selectedSound?["id"] == (controller.searchSounds[index].id ?? ""),
                                callback: () => controller.onChangeSound(
                                  {
                                    "id": controller.searchSounds[index].id ?? "",
                                    "name": controller.searchSounds[index].songTitle ?? "",
                                    "image": controller.searchSounds[index].songImage ?? "",
                                    "link": (controller.searchSounds[index].songLink ?? ""),
                                    "singer": (controller.searchSounds[index].singerName ?? ""),
                                    "duration": (controller.searchSounds[index].songTime ?? ""),
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
            )
          : GetBuilder<CreateReelsController>(
              id: "onGetAllSound",
              builder: (controller) => controller.isLoadingSound
                  ? SoundShimmerUi()
                  : controller.mainSoundCollection.isEmpty
                      ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.mainSoundCollection.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.mainSoundCollection[index].id ?? "",
                                songTitle: controller.mainSoundCollection[index].songTitle ?? "",
                                songImage: controller.mainSoundCollection[index].songImage ?? "",
                                songCategoryName: controller.mainSoundCollection[index].songCategoryName ?? "",
                                singerName: controller.mainSoundCollection[index].singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.mainSoundCollection[index].songTime ?? 0),
                                isFavorite: controller.mainSoundCollection[index].isFavorite ?? false,
                                isSelected: controller.selectedSound?["id"] == (controller.mainSoundCollection[index].id ?? ""),
                                callback: () => controller.onChangeSound({
                                  "id": controller.mainSoundCollection[index].id ?? "",
                                  "name": controller.mainSoundCollection[index].songTitle ?? "",
                                  "image": controller.mainSoundCollection[index].songImage ?? "",
                                  "link": (controller.mainSoundCollection[index].songLink ?? ""),
                                  "singer": (controller.mainSoundCollection[index].singerName ?? ""),
                                  "duration": (controller.mainSoundCollection[index].songTime ?? ""),
                                }),
                              ),
                            ),
                          ),
                        ),
            ),
    );
  }
}

class FavouriteTabUi extends StatelessWidget {
  const FavouriteTabUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateReelsController>(
      id: "onChangeSearchEvent",
      builder: (controller) => controller.isSearching
          ? GetBuilder<CreateReelsController>(
              id: "onSearchSound",
              builder: (controller) => controller.isSearchLoading
                  ? SoundShimmerUi()
                  : controller.searchSounds.isEmpty
                      ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.searchSounds.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.searchSounds[index].id ?? "",
                                songTitle: controller.searchSounds[index].songTitle ?? "",
                                songImage: controller.searchSounds[index].songImage ?? "",
                                songCategoryName: controller.searchSounds[index].songCategoryName ?? "",
                                singerName: controller.searchSounds[index].singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.searchSounds[index].songTime ?? 0),
                                isFavorite: controller.searchSounds[index].isFavorite ?? false,
                                isSelected: controller.selectedSound?["id"] == (controller.searchSounds[index].id ?? ""),
                                callback: () => controller.onChangeSound(
                                  {
                                    "id": controller.searchSounds[index].id ?? "",
                                    "name": controller.searchSounds[index].songTitle ?? "",
                                    "image": controller.searchSounds[index].songImage ?? "",
                                    "link": (controller.searchSounds[index].songLink ?? ""),
                                    "singer": (controller.searchSounds[index].singerName ?? ""),
                                    "duration": (controller.searchSounds[index].songTime ?? ""),
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
            )
          : GetBuilder<CreateReelsController>(
              id: "onGetFavoriteSound",
              builder: (controller) => controller.isLoadingFavoriteSound
                  ? SoundShimmerUi()
                  : controller.favoriteSoundCollection.isEmpty
                      ? NoDataFoundUi(iconSize: 160, fontSize: 19)
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.favoriteSoundCollection.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.favoriteSoundCollection[index].songId?.id ?? "",
                                songTitle: controller.favoriteSoundCollection[index].songId?.songTitle ?? "",
                                songImage: controller.favoriteSoundCollection[index].songId?.songImage ?? "",
                                songCategoryName: controller.favoriteSoundCollection[index].songId?.songCategoryId?.name ?? "",
                                singerName: controller.favoriteSoundCollection[index].songId?.singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.favoriteSoundCollection[index].songId?.songTime ?? 0),
                                isFavorite: true,
                                isSelected: controller.selectedSound?["id"] == (controller.favoriteSoundCollection[index].songId?.id ?? ""),
                                callback: () => controller.onChangeSound({
                                  "id": controller.searchSounds[index].id ?? "",
                                  "name": controller.searchSounds[index].songTitle ?? "",
                                  "image": controller.searchSounds[index].songImage ?? "",
                                  "link": (controller.searchSounds[index].songLink ?? ""),
                                  "singer": (controller.searchSounds[index].singerName ?? ""),
                                  "duration": (controller.searchSounds[index].songTime ?? ""),
                                }),
                              ),
                            ),
                          ),
                        ),
            ),
    );
  }
}

class SoundItemUi extends StatefulWidget {
  const SoundItemUi({
    super.key,
    required this.id,
    required this.songTitle,
    required this.songImage,
    required this.songCategoryName,
    required this.singerName,
    required this.songTime,
    required this.isFavorite,
    required this.isSelected,
    required this.callback,
  });

  final String id;
  final String songTitle;
  final String songImage;
  final String songCategoryName;
  final String singerName;
  final String songTime;
  final bool isFavorite;
  final bool isSelected;
  final Callback callback;

  @override
  State<SoundItemUi> createState() => _SoundItemUiState();
}

class _SoundItemUiState extends State<SoundItemUi> {
  final controller = Get.find<CreateReelsController>();
  RxBool isFavorite = false.obs;

  @override
  void initState() {
    isFavorite.value = widget.isFavorite;
    super.initState();
  }

  Future<void> onChangeFavorite() async {
    isFavorite.value = !isFavorite.value;
    await FavoriteUnFavoriteApi.callApi(loginUserId: Database.loginUserId, soundId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        height: 92,
        width: Get.width,
        padding: EdgeInsets.only(left: 15, right: 5),
        decoration: BoxDecoration(color: widget.isSelected ? AppColor.colorBorder : AppColor.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 76,
              width: 76,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.colorTextGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AppAsset.icImagePlaceHolder, width: 45),
                  AspectRatio(aspectRatio: 1, child: PreviewNetworkImageUi(image: widget.songImage)),
                ],
              ),
            ),
            15.width,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.songTitle,
                      maxLines: 1,
                      style: AppFontStyle.styleW600(AppColor.black, 15),
                    ),
                    Text(
                      widget.songCategoryName,
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.black, 11),
                    ),
                    Text(
                      widget.singerName,
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.black, 11),
                    ),
                    Text(
                      widget.songTime,
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.black, 11),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: onChangeFavorite,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.transparent,
                    ),
                    child: Center(
                      child: Obx(
                        () => Image.asset(
                          isFavorite.value ? AppAsset.icSaveBold : AppAsset.icSaveBorder,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SoundCheckBoxUi extends StatelessWidget {
  const SoundCheckBoxUi({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: isSelected
          ? Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: AppColor.primary,
                gradient: AppColor.primaryLinearGradient,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Icon(Icons.done_rounded, color: AppColor.white, size: 15),
              ),
            )
          : Offstage(),
    );
  }
}

class SearchSoundFieldUi extends StatelessWidget {
  const SearchSoundFieldUi({
    super.key,
    required this.onClickClear,
    required this.controller,
    required this.onChanged,
    required this.isShowClearIcon,
  });

  final Callback onClickClear;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final bool isShowClearIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.colorUnselectedIcon.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 20,
            width: 20,
            AppAsset.icSearch,
            color: AppColor.black,
          ),
          5.width,
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: AppColor.coloGreyText.withOpacity(0.3),
          ),
          5.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColor.colorTextGrey,
              maxLines: 1,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0),
                border: InputBorder.none,
                hintText: EnumLocal.txtSearchHintText.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 17),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClickClear,
            child: Container(
              height: 30,
              width: 30,
              color: AppColor.transparent,
              child: Center(
                child: Image.asset(
                  height: 20,
                  width: 20,
                  AppAsset.icClose,
                  color: AppColor.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
