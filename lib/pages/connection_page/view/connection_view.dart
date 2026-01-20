import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/pages/connection_page/controller/connection_controller.dart';
import 'package:auralive/pages/connection_page/widget/connection_widget.dart';

class ConnectionView extends StatelessWidget {
  const ConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConnectionAppBarUi(),
      body: Column(
        children: [
          const ConnectionTabBarUi(),
          Expanded(
            child: GetBuilder<ConnectionController>(
              id: "onChangeTabBar",
              builder: (logic) => PageView.builder(
                itemCount: 2,
                onPageChanged: (value) => logic.onChangeTabBar(value),
                itemBuilder: (context, index) => logic.connectionTabPages[logic.selectedTabIndex],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
