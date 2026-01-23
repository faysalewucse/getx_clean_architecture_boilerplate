import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/screen_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/theme_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/check_app_version_usecase.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/repositories/app_version_repository_impl.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/dialog_utils.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_strings.dart';
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
      onPopInvokedWithResult: (didPop, result) async {
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
              selectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
              unselectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 9,
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
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: getActiveColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            isSelected ? filledIcon : icon,
            key: ValueKey<bool>(isSelected),
            size: 20,
          ),
        ),
      ),
      label: label,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.currentTheme.value == ThemeMode.dark;

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Column(
        children: [
          // Minimalist Header
          SafeArea(
            bottom: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF252525)
                    : const Color(0xFFFAFAFA),
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? const Color(0xFF333333)
                        : const Color(0xFFE5E5E5),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Avatar
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      PhosphorIconsRegular.user,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // App Name
                  Text(
                    AppStrings.appName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Subtitle
                  Text(
                    'Clean Architecture',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.grey[400]
                          : Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                const SizedBox(height: 8),
                // Navigation Section
                _buildSectionLabel('Navigation', isDark),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.houseLine,
                  title: 'Home',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _handleBottomNavTap(0);
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.squaresFour,
                  title: 'Categories',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _handleBottomNavTap(1);
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.package,
                  title: 'Products',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _handleBottomNavTap(2);
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.user,
                  title: 'Profile',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _handleBottomNavTap(3);
                  },
                ),

                const SizedBox(height: 8),
                Divider(
                  color: isDark
                      ? const Color(0xFF333333)
                      : const Color(0xFFE5E5E5),
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                const SizedBox(height: 8),

                // General Section
                _buildSectionLabel('General', isDark),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.gear,
                  title: 'Settings',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _showComingSoon('Settings');
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.info,
                  title: 'About',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _showAboutDialog();
                  },
                ),

                const SizedBox(height: 8),
                Divider(
                  color: isDark
                      ? const Color(0xFF333333)
                      : const Color(0xFFE5E5E5),
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                const SizedBox(height: 8),

                // Support Section
                _buildSectionLabel('Support', isDark),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.lifebuoy,
                  title: 'Help & Support',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _showComingSoon('Help & Support');
                  },
                ),
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.chatCircleDots,
                  title: 'Feedback',
                  isDark: isDark,
                  onTap: () {
                    Get.back();
                    _showComingSoon('Feedback');
                  },
                ),

                const SizedBox(height: 8),
                Divider(
                  color: isDark
                      ? const Color(0xFF333333)
                      : const Color(0xFFE5E5E5),
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                const SizedBox(height: 8),

                // Logout
                _buildDrawerItem(
                  icon: PhosphorIconsRegular.signOut,
                  title: 'Logout',
                  isDark: isDark,
                  textColor: Colors.red,
                  onTap: () {
                    Get.back();
                    _showLogoutDialog();
                  },
                ),
              ],
            ),
          ),

          // App Version - Minimalist
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? const Color(0xFF333333)
                      : const Color(0xFFE5E5E5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: isDark ? Colors.grey[500] : Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isDark,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: textColor != null
                        ? textColor.withValues(alpha: 0.1)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.grey.withValues(alpha: 0.08)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: textColor ??
                        (isDark ? Colors.grey[300] : Colors.grey[700]),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor ??
                          (isDark ? Colors.grey[200] : Colors.grey[800]),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                Icon(
                  PhosphorIconsRegular.caretRight,
                  size: 16,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
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
      Builder(
        builder: (dialogContext) => AlertDialog(
          title: const Text('About'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.appName,
                style: Theme.of(dialogContext).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A Flutter boilerplate project implementing clean architecture principles with GetX for state management, routing, and dependency injection.',
                style: Theme.of(dialogContext).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Features:',
                style: Theme.of(dialogContext).textTheme.titleSmall,
              ),
              Text('• GetX State Management', style: Theme.of(dialogContext).textTheme.bodyMedium),
              Text('• Clean Architecture', style: Theme.of(dialogContext).textTheme.bodyMedium),
              Text('• API Integration with Dio', style: Theme.of(dialogContext).textTheme.bodyMedium),
              Text('• Routing & Navigation', style: Theme.of(dialogContext).textTheme.bodyMedium),
              Text('• Theming System', style: Theme.of(dialogContext).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Text(
                'Version: 1.0.0',
                style: Theme.of(dialogContext).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Close')),
          ],
        ),
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
        content: Text(
          'Are you sure you want to exit the application?',
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              'Cancel',
              style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
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
            child: Text(
              'Exit',
              style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
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

