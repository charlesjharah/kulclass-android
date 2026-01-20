import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auralive/custom/custom_image_picker.dart';
import 'package:auralive/pages/help_page/api/help_api.dart';
import 'package:auralive/pages/help_page/model/help_model.dart';
import 'package:auralive/ui/image_picker_bottom_sheet_ui.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';

class HelpController extends GetxController {
  TextEditingController complaintController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  HelpModel? helpModel;

  String? pickImage;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    complaintController.clear();
    contactController.clear();
    onCancelImage();
  }

  Future<void> onSendComplaint() async {
    if (complaintController.text.trim().isEmpty) {
      Utils.showToast(EnumLocal.txtPleaseEnterYourComplain.name.tr);
    } else if (contactController.text.trim().isEmpty) {
      Utils.showToast(EnumLocal.txtPleaseEnterYourContactNumber.name.tr);
    }
    // *** TODO *** => Validation Code...
    // else if (pickImage == null) {
    //   Utils.showToast(EnumLocal.txtPleaseUploadScreenShort.name.tr);
    // }
    else {
      Utils.showLog("Complain Sending....");

      FocusManager.instance.primaryFocus?.unfocus();

      Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...
      helpModel = await HelpApi.callApi(
        loginUserId: Database.loginUserId,
        complaint: complaintController.text,
        contact: contactController.text,
        image: pickImage,
      );

      if (helpModel?.status ?? false) {
        Utils.showToast(EnumLocal.txtYourComplainSendSuccessfully.name.tr);
        Get.back();
      } else {
        Utils.showToast(helpModel?.message ?? "");
      }
      Get.back(); // Stop Loading...
    }
  }

  Future<void> onPickImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          pickImage = imagePath;
          update(["onPickImage"]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          pickImage = imagePath;
          update(["onPickImage"]);
        }
      },
    );
  }

  Future<void> onCancelImage() async {
    pickImage = null;
    update(["onPickImage"]);
  }
}
