import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/screen_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/theme_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/check_app_version_usecase.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/repositories/app_version_repository_impl.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/dialog_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/navigators/home_nav.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/navigators/category_nav.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/navigators/products_nav.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/navigators/profile_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // controllers
  final _screenController = Get.find<ScreenController>();

  //variables
  bool _hasCheckedVersion = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkAppVersion(context),
    );
  }

  void _handleBottomNavTap(int index) {
    _screenController.changePage(index);
  }

  Widget _buildBody() {
    return Obx(() => IndexedStack(
          index: _screenController.currentIndex.value,
          children: const [
            HomeNav(),
            CategoryNav(),
            ProductsNav(),
            ProfileNav(),
          ],
        ));
  }

  Future<void> _checkAppVersion(BuildContext context) async {
    if (_hasCheckedVersion) return;
    _hasCheckedVersion = true;

    final useCase = CheckAppVersionUseCase(AppVersionRepositoryImpl());
    final appVersion = await useCase.call();

    final packageInfo = await PackageInfo.fromPlatform();
    final buildVersion = int.tryParse(packageInfo.buildNumber) ?? 1;

    if (buildVersion < appVersion.minimumAppVersion) {
      DialogUtils.showUpdateDialog(
        currentVersion: buildVersion,
        minimumVersion: appVersion.minimumAppVersion,
      );
    } else if (buildVersion < appVersion.currentAppVersion) {
      DialogUtils.showUpdateDialog(
        currentVersion: buildVersion,
        minimumVersion: appVersion.minimumAppVersion,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final currentIndex = _screenController.currentIndex.value;

        // Try to pop from the current nested navigator first
        final navigatorKey = Get.nestedKey(currentIndex);
        final canPop = navigatorKey?.currentState?.canPop() ?? false;

        if (canPop) {
          // Pop from nested navigator
          navigatorKey?.currentState?.pop();
          return;
        }

        // If we're already on home tab and can't pop, show exit confirmation
        if (currentIndex == 0) {
          _showExitConfirmationDialog();
          return;
        }

        // Otherwise navigate to home tab
        _handleBottomNavTap(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Obx(() => Text(_screenController.currentTitle.value)),
          titleSpacing: 0,
          leading: Obx(() {
            final themeController = Get.find<ThemeController>();
            final isDark = themeController.currentTheme.value == ThemeMode.dark;
            final showBack = _screenController.showBackButton.value;

            if (showBack) {
              // Show back button for nested routes
              return IconButton(
                icon: Icon(
                  PhosphorIconsRegular.arrowLeft,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () => _screenController.handleBackButton(),
              );
            }

            // Show drawer icon for main routes
            return Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  PhosphorIconsRegular.sidebar,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            );
          }),
          actions: [
            Obx(() {
              final themeController = Get.find<ThemeController>();
              final isDark = themeController.currentTheme.value == ThemeMode.dark;

              return Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(
                  onPressed: () => themeController.switchTheme(),
                  icon: Icon(
                    isDark ? PhosphorIconsRegular.sun : PhosphorIconsRegular.moon,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              );
            }),
          ],
        ),
        drawer: _buildDrawer(context),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
      final isDark = themeController.currentTheme.value == ThemeMode.dark;
      final currentIndex = _screenController.currentIndex.value;

      return Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          boxShadow: [
            BoxShadow(
              color:
                  isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.3),
              offset: const Offset(0, -2),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => _handleBottomNavTap(index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor:
                  isDark ? Colors.white : Theme.of(context).primaryColor,
              unselectedItemColor: isDark ? Colors.grey[400] : Colors.grey[600],
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
              items: [
                _buildNavItem(
                  PhosphorIconsRegular.houseLine,
                  PhosphorIconsFill.houseLine,
                  'Home',
                  0,
                  currentIndex,
                  isDark,
                ),
                _buildNavItem(
                  PhosphorIconsRegular.squaresFour,
                  PhosphorIconsFill.squaresFour,
                  'Categories',
                  1,
                  currentIndex,
                  isDark,
                ),
                _buildNavItem(
                  PhosphorIconsRegular.package,
                  PhosphorIconsFill.package,
                  'Products',
                  2,
                  currentIndex,
                  isDark,
                ),
                _buildNavItem(
                  PhosphorIconsRegular.user,
                  PhosphorIconsFill.user,
                  'Profile',
                  3,
                  currentIndex,
                  isDark,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    IconData filledIcon,
    String label,
    int index,
    int currentIndex,
    bool isDark,
  ) {
    final isSelected = index == currentIndex;

    Color getActiveColor() {
      if (!isSelected) return Colors.transparent;

      if (isDark) {
        return Colors.white.withValues(alpha: 0.1);
      } else {
        return Theme.of(Get.context!).primaryColor.withValues(alpha: 0.15);
      }
    }

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: getActiveColor(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            isSelected ? filledIcon : icon,
            key: ValueKey<bool>(isSelected),
            size: 24,
          ),
        ),
      ),
      label: label,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            height: 228,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        PhosphorIconsFill.user,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'GetX Boilerplate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Clean Architecture',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.houseLine,
                  title: 'Home',
                  onTap: () {
                    Get.back(); // Close drawer
                    _handleBottomNavTap(0); // Navigate to home
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.user,
                  title: 'Profile',
                  onTap: () {
                    Get.back(); // Close drawer
                    _handleBottomNavTap(3); // Navigate to profile
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.gear,
                  title: 'Settings',
                  onTap: () {
                    Get.back();
                    _showComingSoon('Settings');
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.info,
                  title: 'About',
                  onTap: () {
                    Get.back();
                    _showAboutDialog();
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.question,
                  title: 'Help & Support',
                  onTap: () {
                    Get.back();
                    _showComingSoon('Help & Support');
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.chatCenteredDots,
                  title: 'Feedback',
                  onTap: () {
                    Get.back();
                    _showComingSoon('Feedback');
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.signOut,
                  title: 'Logout',
                  onTap: () {
                    Get.back();
                    _showLogoutDialog();
                  },
                ),
              ],
            ),
          ),

          // App Version
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'GetX Clean Architecture Boilerplate\nVersion 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    );
  }

  void _showComingSoon(String feature) {
    Get.snackbar(
      'Coming Soon',
      '$feature feature will be available in the next update!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withValues(alpha: 0.1),
      colorText: Colors.blue,
      icon: const Icon(PhosphorIconsRegular.info, color: Colors.blue),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  void _showAboutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('About'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GetX Clean Architecture Boilerplate',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'A Flutter boilerplate project implementing clean architecture principles with GetX for state management, routing, and dependency injection.',
            ),
            SizedBox(height: 12),
            Text('Features:', style: TextStyle(fontWeight: FontWeight.w600)),
            Text('• GetX State Management'),
            Text('• Clean Architecture'),
            Text('• API Integration with Dio'),
            Text('• Routing & Navigation'),
            Text('• Theming System'),
            SizedBox(height: 12),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text(
          'Are you sure you want to logout from the application?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Logged Out',
                'You have been successfully logged out',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withValues(alpha: 0.1),
                colorText: Colors.green,
                icon: const Icon(
                  PhosphorIconsRegular.checkCircle,
                  color: Colors.green,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.currentTheme.value == ThemeMode.dark;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                PhosphorIconsRegular.warning,
                color: Colors.orange,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Exit App'),
          ],
        ),
        content: const Text(
          'Are you sure you want to exit the application?',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Exit the app using SystemNavigator
              SystemNavigator.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}

