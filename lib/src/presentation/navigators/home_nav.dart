import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/nav_ids.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/home/home_screen.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.home),
      onGenerateRoute: (settings) {
        // Add more routes here if you have nested screens in Home section
        return GetPageRoute(
          settings: settings,
          page: () => HomeScreen(),
        );
      },
    );
  }
}
