import 'package:get/get.dart';
import 'package:auralive/pages/splash_screen_page/api/fetch_user_coin_api.dart';
import 'package:auralive/pages/splash_screen_page/model/fetch_user_coin_model.dart';
import 'package:auralive/utils/database.dart';

class CustomFetchUserCoin {
  static RxInt coin = 0.obs;
  static FetchUserCoinModel? fetchUserCoinModel;
  static RxBool isLoading = false.obs;

  static Future<void> init() async {
    isLoading.value = true;
    fetchUserCoinModel = await FetchUserCoinApi.callApi(loginUserId: Database.loginUserId);

    if (fetchUserCoinModel?.userCoin != null) {
      coin.value = fetchUserCoinModel?.userCoin ?? 0;
      isLoading.value = false;
    }
  }
}
