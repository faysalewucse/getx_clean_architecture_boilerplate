import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/nav_ids.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/category/category_screen.dart';

class CategoryNav extends StatelessWidget {
  const CategoryNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.categories),
      onGenerateRoute: (settings) {
        // Add more routes here if you have nested screens in Category section
        return GetPageRoute(
          settings: settings,
          page: () => CategoryScreen(),
        );
      },
    );
  }
}
