import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/custom/custom_fetch_user_coin.dart';
import 'package:auralive/ui/confirm_withdraw_dialog_ui.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/pages/splash_screen_page/api/admin_setting_api.dart';
import 'package:auralive/pages/withdraw_page/api/create_withdraw_request_api.dart';
import 'package:auralive/pages/withdraw_page/api/fetch_withdraw_method_api.dart';
import 'package:auralive/pages/withdraw_page/model/create_withdraw_request_model.dart';
import 'package:auralive/pages/withdraw_page/model/fetch_withdraw_method_model.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';

class WithdrawController extends GetxController {
  TextEditingController coinController = TextEditingController();

  bool isLoading = false;
  List<Data> withdrawMethods = [];
  FetchWithdrawMethodModel? fetchWithdrawMethodModel;
  List<TextEditingController> withdrawPaymentDetails = [];

  int? selectedPaymentMethod;
  bool isShowPaymentMethod = false;

  CreateWithdrawRequestModel? createWithdrawRequestModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await onGetWithdrawMethods();
    CustomFetchUserCoin.init();
  }

  Future<void> onGetWithdrawMethods() async {
    isLoading = true;
    fetchWithdrawMethodModel = await FetchWithdrawMethodApi.callApi();
    if (fetchWithdrawMethodModel?.data != null) {
      withdrawMethods.addAll(fetchWithdrawMethodModel?.data ?? []);
      isLoading = false;
      update(["onGetWithdrawMethods"]);
    }
  }

  Future<void> onSwitchWithdrawMethod() async {
    isShowPaymentMethod = !isShowPaymentMethod;
    update(["onSwitchWithdrawMethod", "onChangePaymentMethod"]);
  }

  Future<void> onChangePaymentMethod(int index) async {
    selectedPaymentMethod = index;
    if (isShowPaymentMethod) {
      onSwitchWithdrawMethod();
    }
    withdrawPaymentDetails = List<TextEditingController>.generate(
        withdrawMethods[index].details?.length ?? 0, (counter) => TextEditingController());

    update(["onChangePaymentMethod"]);
  }

  Future<void> onClickWithdraw() async {
    bool isWithdrawDetailsEmpty = false;
    for (int i = 0; i < withdrawPaymentDetails.length; i++) {
      if (withdrawPaymentDetails[i].text.isEmpty) {
        isWithdrawDetailsEmpty = true;
      } else {
        isWithdrawDetailsEmpty = false;
      }
    }

    if (coinController.text.trim().isEmpty) {
      Utils.showToast(EnumLocal.txtPleaseEnterWithdrawCoin.name.tr);
    } else if (int.parse(coinController.text) <
        (AdminSettingsApi.adminSettingModel?.data?.minWithdrawalRequestedCoin ?? 0)) {
      Utils.showToast(EnumLocal.txtWithdrawalRequestedCoinMustBeGreaterThanSpecifiedByTheAdmin.name.tr);
    } else if (int.parse(coinController.text) > CustomFetchUserCoin.coin.value) {
      Utils.showToast(EnumLocal.txtTheUserDoesNotHaveSufficientFundsToMakeTheWithdrawal.name.tr);
    } else if (selectedPaymentMethod == null) {
      Utils.showToast(EnumLocal.txtPleaseSelectWithdrawMethod.name.tr);
    } else if (isWithdrawDetailsEmpty) {
      Utils.showToast(EnumLocal.txtPleaseEnterAllPaymentDetails.name.tr);
    } else {
      ConfirmWithdrawDialogUi.onShow(() => onWithdraw());
    }
  }

  Future<void> onWithdraw() async {
    Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...
    List<String> details = [];

    for (int i = 0; i < withdrawMethods[selectedPaymentMethod ?? 0].details!.length; i++) {
      details.add("${withdrawMethods[selectedPaymentMethod ?? 0].details![i]}:${withdrawPaymentDetails[i].text}");
    }

    await 1.seconds.delay();

    createWithdrawRequestModel = await CreateWithdrawRequestApi.callApi(
      loginUserId: Database.loginUserId,
      coin: coinController.text,
      paymentGateway: withdrawMethods[selectedPaymentMethod ?? 0].name ?? "",
      paymentDetails: details,
    );

    if (createWithdrawRequestModel?.status ?? false) {
      Utils.showToast(createWithdrawRequestModel?.message ?? "");
    }

    Get.close(3); // Stop Loading / Close Dialog / Close Withdraw Page...
  }
}
