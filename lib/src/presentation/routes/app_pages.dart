import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/middlewares/auth_middleware.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/login_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/register_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/main_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/splash_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/profile/edit_profile_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/profile/privacy_security_screen.dart';

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
    GetPage(
      name: Routes.categories,
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.products,
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const MainScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => const EditProfileScreen(),
      middlewares: [AuthMiddleware()],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.privacySecurity,
      page: () => const PrivacySecurityScreen(),
      middlewares: [AuthMiddleware()],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
