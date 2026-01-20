import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/splash_screen_page/controller/splash_screen_controller.dart';
import 'package:auralive/utils/asset.dart';
import 'package:auralive/utils/color.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  // A method to precache the background image.
  Future<void> _precacheImages(BuildContext context) async {
    // Precache the background image to ensure it is ready when the screen loads.
    await precacheImage(const AssetImage(AppAsset.imgSplashScreen), context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColor.transparent,
      ),
    );
    return Scaffold(
      body: FutureBuilder(
        future: _precacheImages(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppAsset.imgSplashScreen,
                  fit: BoxFit.cover,
                ),
                Center(
                  // We've replaced the static GIF with a Lottie animation for a smoother effect.
                  // This requires the lottie package, which you'll need to add to your pubspec.yaml file.
                  child: Lottie.asset(
                    AppAsset.lottieWaveAnimation,
                    height: Get.height * 0.3,
                    width: Get.width * 0.6,
                  ),
                ),
              ],
            );
          } else {
            // Show a simple loading indicator while the background image is precaching
            return Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
