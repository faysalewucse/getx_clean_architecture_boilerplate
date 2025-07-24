import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/network_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_sizes.dart';
import 'package:getx_clean_architecture_boilerplate/src/app/themes/app_theme.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/buttons/primary_button.dart';

void main() {
  Get.put(NetworkController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Getx Boilerplate',
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppSizes.xxl_20),
          child: Center(
            child: PrimaryButton(onPressed: (){}, label: "Button",),
          ),
        ),
      ),
    );
  }
}