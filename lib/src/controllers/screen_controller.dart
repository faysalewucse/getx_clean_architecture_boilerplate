import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_strings.dart';

class ScreenController extends GetxController {
  static ScreenController get to => Get.find();

  var currentIndex = 0.obs;
  var currentTitle = AppStrings.appName.obs;

  // Route titles mapping for AppBar
  final Map<int, String> tabTitles = {
    0: AppStrings.appName,
    1: 'Categories',
    2: 'Products',
    3: 'Profile',
  };

  void changePage(int index) {
    currentIndex.value = index;
    currentTitle.value = tabTitles[index] ?? AppStrings.appName;
  }
}
