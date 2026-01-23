import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/nav_ids.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/products/products_screen.dart';

class ProductsNav extends StatelessWidget {
  const ProductsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.products),
      onGenerateRoute: (settings) {
        // Add more routes here if you have nested screens in Products section
        return GetPageRoute(
          settings: settings,
          page: () => ProductsScreen(),
        );
      },
    );
  }
}
