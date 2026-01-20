import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/localization/localizations_delegate.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/database.dart';

class LanguageController extends GetxController {
  LanguageModel? languageModel;
  String? languageCode;
  String? countryCode;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  final List countryFlags = [
    AppAsset.icArabia,
    AppAsset.icBangladesh,
    AppAsset.icChinese,
    AppAsset.icUnitedStates,
    AppAsset.icFrance,
    AppAsset.icGermany,
    AppAsset.icIndia,
    AppAsset.icItalian,
    AppAsset.icIndonesia,
    AppAsset.icJapan,
    AppAsset.icKorean,
    AppAsset.icIndia,
    AppAsset.icBrazil,
    AppAsset.icRussian,
    AppAsset.icSpain,
    AppAsset.icSwahili,
    AppAsset.icTurkey,
    AppAsset.icIndia,
    AppAsset.icIndia,
    AppAsset.icPakistan,
  ];

  void init() {
    languageCode = Database.selectedLanguage;
    countryCode = Database.selectedCountryCode;
    languageModel = languages
        .where((element) => (element.languageCode == languageCode && element.countryCode == countryCode))
        .toList()[0];
    update(["onChangeLanguage"]);
  }

  void onChangeLanguage(LanguageModel value) {
    languageModel = value;
    Database.onSetSelectedLanguage(languageModel!.languageCode);
    Database.onSetSelectedCountryCode(languageModel!.countryCode);

    Get.updateLocale(Locale(languageModel!.languageCode, languageModel!.countryCode));
    update(["onChangeLanguage"]);
  }
}
