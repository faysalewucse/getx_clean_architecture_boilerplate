import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/login_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/home/home_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/main_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/splash_screen.dart';

class AppPages{
  static List<GetPage> pages = [
    GetPage(
      name: Routes.initialRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}