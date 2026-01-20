import 'dart:io';

abstract class AppConstant {
  static const String languageEn = "en";
  static const String countryCodeEn = "US";

  static const String appFontRegular = "SfProRegular";
  static const String appFontMedium = "SfProMedium";
  static const String appFontBold = "SfProBold";

  static int bottomBarSize = Platform.isAndroid ? 65 : 80;

}
