import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/main.dart';
import 'package:auralive/pages/edit_post_page/controller/edit_post_controller.dart';
import 'package:auralive/pages/edit_post_page/widget/edit_post_widget.dart';
import 'package:auralive/ui/app_button_ui.dart';
import 'package:auralive/ui/preview_network_image_ui.dart';
import 'package:auralive/ui/simple_app_bar_ui.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/font_style.dart';

class EditPostView extends GetView<EditPostController> {
  const EditPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtEditPost.name.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            width: Get.width,
            color: AppColor.colorBorder.withOpacity(0.2),
            child: GetBuilder<EditPostController>(
              id: "onChangeImages",
              builder: (logic) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: logic.selectedImages.length,
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: SizedBox(
                      width: 135,
                      child: Container(
                        height: 140,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Colors.grey.shade200),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: PreviewNetworkImageUi(image: controller.selectedImages[index].url),
                            ),
                            Visibility(
                              visible: (controller.selectedImages[index].isBanned ?? false),
                              child: BlurryContainer(
                                height: Get.height,
                                width: Get.width,
                                blur: 5,
                                borderRadius: BorderRadius.zero,
                                color: AppColor.black.withOpacity(0.3),
                                child: Offstage(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          20.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: RichText(
              text: TextSpan(
                text: EnumLocal.txtCaption.name.tr,
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
            onTap: () {
              Get.to(
                PreviewPostCaptionUi(),
                transition: Transition.downToUp,
                duration: Duration(milliseconds: 300),
              );
            },
            child: GetBuilder<EditPostController>(
              id: "onChangeHashtag",
              builder: (controller) => Container(
                height: 130,
                width: Get.width,
                padding: const EdgeInsets.only(left: 15, top: 5),
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColor.colorBorder.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    controller.captionController.text.isEmpty ? EnumLocal.txtEnterYourTextWithHashtag.name.tr : controller.captionController.text,
                    style: controller.captionController.text.isEmpty ? AppFontStyle.styleW400(AppColor.coloGreyText, 15) : AppFontStyle.styleW600(AppColor.black, 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppButtonUi(
        title: EnumLocal.txtSubmit.name.tr,
        gradient: AppColor.primaryLinearGradient,
        callback: controller.onEditPost,
      ).paddingSymmetric(horizontal: Get.width / 6.5, vertical: 25),
    );
  }
}
