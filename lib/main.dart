import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/network_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/theme_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/services/storage_service.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/bindings/initial_bindings.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_pages.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/themes/app_theme.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/translations/translation_service.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage first
  await GetStorage.init();

  // Initialize services
  Get.put(StorageService());
  Get.put(ThemeController(Get.find()));
  Get.put(NetworkController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return ToastificationWrapper(
      child: Obx(
        () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Getx Boilerplate',
          initialBinding: InitialScreenBindings(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          translations: AppTranslations(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.currentTheme.value,
          initialRoute: Routes.initialRoute,
          getPages: AppPages.pages,
        ),
      ),
    );
  }
}
