import 'package:get/get.dart';
import 'package:auralive/custom/custom_fetch_user_coin.dart';
import 'package:auralive/pages/my_wallet_page/api/fetch_coin_history_api.dart';
import 'package:auralive/pages/my_wallet_page/model/fetch_coin_history_model.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/utils.dart';
import 'package:auralive/utils/currency_helper.dart';

class MyWalletController extends GetxController {
  bool isLoading = false;
  List<Data> coinHistory = [];
  FetchCoinHistoryModel? fetchCoinHistoryModel;

  String startDate = "All";
  String endDate = "All"; // API params
  String rangeDate = "All"; // For UI

  // Reactive variables for currency conversion
  RxDouble convertedBalance = 0.0.obs;
  RxString currencyCode = 'USD'.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    // Get currency code from arguments if passed
    if (Get.arguments != null && Get.arguments['currencyCode'] != null) {
      currencyCode.value = Get.arguments['currencyCode'];
    }

    // Initialize user coin
    CustomFetchUserCoin.init();

    // Convert USD balance to user's currency
    await convertUserCoin();

    // Load coin history
    onGetCoinHistory();

    Utils.showLog("My Wallet Page Controller Initialized");
  }

  Future<void> convertUserCoin() async {
    final coinValue = CustomFetchUserCoin.coin.value.toDouble(); // <-- cast here
    convertedBalance.value =
    await CurrencyHelper.convert(coinValue, 'USD', currencyCode.value);
  }


  Future<void> onGetCoinHistory() async {
    isLoading = true;
    coinHistory.clear();
    update(["onGetCoinHistory"]);

    fetchCoinHistoryModel = await FetchCoinHistoryApi.callApi(
      loginUserId: Database.loginUserId,
      startDate: startDate,
      endDate: endDate,
    );

    if (fetchCoinHistoryModel?.data != null) {
      coinHistory.clear();
      coinHistory.addAll(fetchCoinHistoryModel?.data ?? []);
    }

    isLoading = false;
    update(["onGetCoinHistory"]);
  }

  Future<void> onChangeDate({
    required String startDate,
    required String endDate,
    required String rangeDate,
  }) async {
    this.startDate = startDate;
    this.endDate = endDate;
    this.rangeDate = rangeDate;
    update(["onChangeDate"]);
  }
}
