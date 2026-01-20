import 'package:get/get.dart';
import 'package:auralive/ui/loading_ui.dart';
import 'package:auralive/pages/payment_page/api/create_coin_plan_history_api.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/enums.dart';
import 'package:auralive/utils/utils.dart';

class PaymentController extends GetxController {
  String coinPlanId = "";
  int coinAmount = 0;
  String productKey = "";

  @override
  void onInit() {
    Utils.showLog("Selected Plan => ${Get.arguments}");
    if (Get.arguments != null) {
      coinPlanId = Get.arguments["id"];
      coinAmount = Get.arguments["amount"];
      productKey = Get.arguments["productKey"];
    }
    super.onInit();
  }

  Future<void> onClickPayNow() async {
    try {
      Get.dialog(const LoadingUi(), barrierDismissible: false); // Start loading...
      final isSuccess = await CreateCoinPlanHistoryApi.callApi(
        loginUserId: Database.loginUserId,
        coinPlanId: coinPlanId,
        paymentType: "InApp", // just a placeholder
      );
      Get.back(); // Stop loading
      if (isSuccess) {
        Utils.showToast(EnumLocal.txtCoinRechargeSuccess.name.tr);
        Get.close(2);
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
      }
    } catch (e) {
      Get.back(); // Stop loading
      Utils.showLog("Payment Failed => $e");
    }
  }
}
