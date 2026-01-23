import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/nav_ids.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/observers/nested_route_observer.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/profile/profile_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/profile/edit_profile_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/profile/privacy_security_screen.dart';

class ProfileNav extends StatelessWidget {
  const ProfileNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.profile),
      observers: [NestedRouteObserver()],
      onGenerateRoute: (settings) {
        if (settings.name == '/profile/edit-profile') {
          return GetPageRoute(
            settings: settings,
            page: () => const EditProfileScreen(),
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300),
          );
        } else if (settings.name == '/profile/privacy-security') {
          return GetPageRoute(
            settings: settings,
            page: () => const PrivacySecurityScreen(),
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300),
          );
        } else {
          // Default to profile main screen
          return GetPageRoute(
            settings: settings,
            page: () => const ProfileScreen(),
          );
        }
      },
    );
  }
}
