import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:auralive/custom/custom_format_number.dart';
import 'package:auralive/pages/edit_post_page/controller/edit_post_controller.dart';
import 'package:auralive/shimmer/hash_tag_bottom_sheet_shimmer_ui.dart';
import 'package:auralive/ui/no_data_found_ui.dart';
import 'package:auralive/main.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class PreviewPostCaptionUi extends StatefulWidget {
  const PreviewPostCaptionUi({super.key});

  @override
  State<PreviewPostCaptionUi> createState() => _PreviewPostCaptionUiState();
}

class _PreviewPostCaptionUiState extends State<PreviewPostCaptionUi> {
  final controller = Get.find<EditPostController>();
  FocusNode focusNode = FocusNode();

  String caption = "";

  @override
  void initState() {
    focusNode.requestFocus();
    controller.onToggleHashTag(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SafeArea(
          bottom: false,
          child: Container(
            color: AppColor.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  45.width,
                  Spacer(),
                  Text(
                    EnumLocal.txtCaption.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 19),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: AppColor.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        EnumLocal.txtDone.name.tr,
                        style: AppFontStyle.styleW700(AppColor.primary, 16),
                      ),
                    ),
                  ),
                  5.width,
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          15.height,
          Container(
            height: 130,
            width: Get.width,
            padding: const EdgeInsets.only(left: 15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColor.colorBorder.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
            ),
            child: TextFormField(
              onChanged: (value) => controller.onChangeHashtag(),
              controller: controller.captionController,
              maxLines: 4,
              focusNode: focusNode,
              cursorColor: AppColor.colorTextGrey,
              style: AppFontStyle.styleW600(AppColor.black, 15),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: EnumLocal.txtEnterYourTextWithHashtag.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 15),
              ),
            ),
          ),
          15.height,
          Expanded(
            child: Obx(
              () => Visibility(
                visible: controller.isShowHashTag.value,
                child: GetBuilder<EditPostController>(
                  id: "onGetHashTag",
                  builder: (controller) => controller.isLoadingHashTag
                      ? HashTagBottomSheetShimmerUi()
                      : controller.filterHashtag.isEmpty
                          ? Center(child: SingleChildScrollView(child: NoDataFoundUi(iconSize: 160, fontSize: 19)))
                          : SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.filterHashtag.length,
                                itemBuilder: (context, index) => GetBuilder<EditPostController>(
                                  id: "onSelectHastTag",
                                  builder: (controller) => GestureDetector(
                                    onTap: () => controller.onSelectHashtag(index),
                                    child: Container(
                                      height: 70,
                                      width: Get.width,
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      decoration: BoxDecoration(
                                        border: Border(top: BorderSide(color: AppColor.grey_100)),
                                      ),
                                      child: Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: "# ",
                                              style: AppFontStyle.styleW600(AppColor.primary, 20),
                                              children: [
                                                TextSpan(
                                                  text: controller.filterHashtag[index].hashTag,
                                                  style: AppFontStyle.styleW700(AppColor.black, 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Image.asset(
                                                AppAsset.icViewBorder,
                                                color: AppColor.colorTextGrey,
                                                width: 20,
                                              ),
                                              5.width,
                                              Text(
                                                CustomFormatNumber.convert(controller.filterHashtag[index].totalHashTagUsedCount ?? 0),
                                                style: AppFontStyle.styleW700(AppColor.colorTextGrey, 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CaptionTextFieldUi extends StatelessWidget {
  const CaptionTextFieldUi({
    super.key,
    this.height,
    required this.title,
    required this.maxLines,
    required this.controller,
    this.onClick,
    this.focusNode,
    this.enabled,
  });

  final String title;
  final int? maxLines;
  final double? height;

  final Callback? onClick;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RichText(
            text: TextSpan(
              text: title,
              style: AppFontStyle.styleW700(AppColor.black, 15),
              children: [
                TextSpan(
                  text: " ${EnumLocal.txtOptionalInBrackets.name.tr}",
                  style: AppFontStyle.styleW400(AppColor.coloGreyText, 10),
                ),
              ],
            ),
          ),
        ),
        5.height,
        GestureDetector(
          onTap: onClick,
          child: Container(
            height: height ?? 55,
            width: Get.width,
            padding: const EdgeInsets.only(left: 15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: height == null ? Alignment.center : null,
            decoration: BoxDecoration(
              color: AppColor.colorBorder.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
            ),
            child: TextFormField(
              controller: controller,
              maxLines: maxLines ?? 1,
              enabled: enabled,
              focusNode: focusNode,
              cursorColor: AppColor.colorTextGrey,
              style: AppFontStyle.styleW600(AppColor.black, 15),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: EnumLocal.txtEnterYourTextWithHashtag.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
