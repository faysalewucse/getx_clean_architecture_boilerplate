import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/home/home_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/splash_screen.dart';

class AppPages{
  static List<GetPage> pages = [
    GetPage(
      name: Routes.initialRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // TODO: Add other routes when their screens are created
    // GetPage(
    //   name: signIn,
    //   page: () => const SignInScreen(),
    // ),
    // GetPage(
    //   name: profile,
    //   page: () => const ProfileScreen(),
    // ),
    // GetPage(
    //   name: register,
    //   page: () => const RegisterScreen(),
    // ),
    // GetPage(
    //   name: emailVerification,
    //   page: () => const EmailVerificationScreen(),
    // ),
    // GetPage(
    //   name: forgetPassword,
    //   page: () => const ForgetPasswordScreen(),
    // ),
    // GetPage(
    //   name: forgetPasswordEmail,
    //   page: () => const ForgetPasswordEmailScreen(),
    // ),
    // GetPage(
    //   name: setNewPassword,
    //   page: () => const SetNewPasswordScreen(),
    // ),
    // GetPage(
    //   name: changePassword,
    //   page: () => const ChangePasswordScreen(),
    // ),
    // GetPage(
    //   name: emailVerificationForResetPassword,
    //   page: () => const EmailVerificationForResetPasswordScreen(),
    // ),
  ];
}