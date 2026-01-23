import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/auth_controller.dart';

/// Middleware to handle authentication checks for protected routes
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Check if AuthController is registered
    if (!Get.isRegistered<AuthController>()) {
      return null;
    }

    final authController = Get.find<AuthController>();
    final isLoggedIn = authController.isUserLoggedIn.value;

    // If user is trying to access profile and not logged in, redirect to login
    if (route == Routes.profile && !isLoggedIn) {
      return const RouteSettings(name: Routes.login);
    }

    // If user is trying to access login and already logged in, redirect to home
    if (route == Routes.login && isLoggedIn) {
      return const RouteSettings(name: Routes.home);
    }

    return null; // No redirect needed
  }
}
