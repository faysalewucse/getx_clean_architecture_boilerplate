import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_strings.dart';

class ScreenController extends GetxController {
  static ScreenController get to => Get.find();

  var currentIndex = 0.obs;
  var currentTitle = AppStrings.appName.obs;
  var showBackButton = false.obs;

  // Route titles mapping for AppBar
  final Map<int, String> tabTitles = {
    0: AppStrings.appName,
    1: 'Categories',
    2: 'Products',
    3: 'Profile',
  };

  final Map<String, String> nestedRouteTitles = {
    '/profile/edit-profile': 'Edit Profile',
    '/profile/privacy-security': 'Privacy & Security',
  };

  void changePage(int index) {
    currentIndex.value = index;
    currentTitle.value = tabTitles[index] ?? AppStrings.appName;
    showBackButton.value = false;
  }

  void updateTitle(String route) {
    if (nestedRouteTitles.containsKey(route)) {
      currentTitle.value = nestedRouteTitles[route]!;
      showBackButton.value = true;
    } else {
      currentTitle.value = tabTitles[currentIndex.value] ?? AppStrings.appName;
      showBackButton.value = false;
    }
  }

  void handleBackButton() {
    final navigatorKey = Get.nestedKey(currentIndex.value);
    if (navigatorKey?.currentState?.canPop() ?? false) {
      navigatorKey?.currentState?.pop();
      // Reset to main title after popping
      currentTitle.value = tabTitles[currentIndex.value] ?? AppStrings.appName;
      showBackButton.value = false;
    }
  }
}