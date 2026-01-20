import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:auralive/pages/search_page/controller/search_controller.dart' as controller;
import 'package:auralive/pages/search_page/widget/search_widget.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/enums.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          shadowColor: AppColor.black.withOpacity(0.4),
          flexibleSpace: Center(child: SearchAppBar(title: EnumLocal.txtSettings.name.tr)),
        ),
      ),
      body: GetBuilder<controller.SearchController>(
        id: "onChangeTabBar",
        builder: (logic) => PageView.builder(
          itemCount: 2,
          onPageChanged: (value) => logic.onChangeTabBar(value),
          itemBuilder: (context, index) => logic.searchTabPages[logic.selectedTabIndex],
        ),
      ),
    );
  }
}
