import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:auralive/pages/bottom_bar_page/widget/bottom_bar_widget.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomBarController>(
        id: "onChangeBottomBar",
        builder: (logic) {
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logic.bottomBarPages.length,
            controller: logic.pageController,
            onPageChanged: (int index) => logic.onChangeBottomBar(index),
            itemBuilder: (context, index) => logic.bottomBarPages[logic.selectedTabIndex],
          );
        },
      ),
      bottomNavigationBar: const BottomBarUi(),
    );
  }
}
