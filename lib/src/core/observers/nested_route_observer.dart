import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/screen_controller.dart';

class NestedRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _updateTitle(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _updateTitle(previousRoute);
    }
  }

  void _updateTitle(Route route) {
    final screenController = Get.find<ScreenController>();
    if (route.settings.name != null) {
      screenController.updateTitle(route.settings.name!);
    }
  }
}
