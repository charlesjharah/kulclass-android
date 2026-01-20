// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:auralive/ui/preview_network_image_ui.dart';
// import 'package:auralive/utils/asset.dart';
// import 'package:auralive/utils/color.dart';
//
// class PreviewImagesDialogUi {
//   static RxInt currentIndex = 0.obs;
//   static Future<void> show({required List images}) async {
//     currentIndex.value = 0;
//     Get.dialog(
//       barrierColor: AppColor.black.withOpacity(0.9),
//       Dialog(
//         backgroundColor: AppColor.transparent,
//         elevation: 0,
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColor.transparent,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: AppColor.white, width: 1),
//           ),
//           child: Container(
//             height: Get.height / 2,
//             width: Get.width,
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//               color: AppColor.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Image.asset(AppAsset.icImagePlaceHolder, width: 180),
//                 SizedBox(
//                   height: Get.height / 2,
//                   child: PageView.builder(
//                     itemCount: images.length,
//                     onPageChanged: (value) => currentIndex.value = value,
//                     itemBuilder: (context, index) => Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         PreviewNetworkImageUi(image: images[index]),
//                         Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Container(
//                             height: Get.height / 6,
//                             width: Get.width,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [AppColor.transparent, AppColor.black.withOpacity(0.8)],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: GestureDetector(
//                     onTap: Get.back,
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: AppColor.black,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppColor.white),
//                       ),
//                       alignment: Alignment.center,
//                       child: Image.asset(
//                         height: 18,
//                         width: 18,
//                         AppAsset.icClose,
//                         color: AppColor.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   child: Visibility(
//                     visible: images.length > 1,
//                     child: Obx(
//                       () => DotIndicatorUi(
//                         index: currentIndex.value,
//                         length: images.length,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DotIndicatorUi extends StatelessWidget {
//   const DotIndicatorUi({super.key, required this.index, required this.length});
//
//   final int index;
//   final int length;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 20,
//       width: Get.width / 2,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (int i = 0; i < length; i++)
//             AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               height: 8,
//               width: i == index ? 35 : 10,
//               margin: EdgeInsets.only(left: 5),
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: i == index ? BoxShape.rectangle : BoxShape.circle,
//                   color: i == index ? AppColor.primary : AppColor.white.withOpacity(0.3),
//                   borderRadius: i == index ? BorderRadius.circular(20) : null,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
