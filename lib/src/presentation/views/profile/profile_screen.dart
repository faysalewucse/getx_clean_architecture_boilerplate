import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/theme_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/auth_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/size_utils.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/nav_ids.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final authController = Get.find<AuthController>();
    final isDark = themeController.currentTheme.value == ThemeMode.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
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
              child: Column(
                children: [
                  // Profile Avatar
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: Icon(
                            PhosphorIconsFill.user,
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            PhosphorIconsFill.camera,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.kH,

                  // User Name
                  Obx(() {
                    final userName = authController.user?.name ?? 'User Name';
                    return Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  8.kH,

                  // User Email
                  const Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Stats
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    icon: PhosphorIconsRegular.shoppingCart,
                    label: 'Orders',
                    value: '12',
                    color: Colors.blue,
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                  _buildStatItem(
                    icon: PhosphorIconsRegular.heart,
                    label: 'Wishlist',
                    value: '24',
                    color: Colors.red,
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                  _buildStatItem(
                    icon: PhosphorIconsRegular.star,
                    label: 'Reviews',
                    value: '8',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  12.kH,

                  _buildMenuCard(
                    context,
                    isDark,
                    [
                      _buildMenuItem(
                        icon: PhosphorIconsRegular.userCircle,
                        title: 'Edit Profile',
                        subtitle: 'Update your profile information',
                        onTap: () {
                          Get.toNamed(Routes.editProfile, id: NavIds.profile);
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: PhosphorIconsRegular.bell,
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        onTap: () {
                          Get.snackbar(
                            'Notifications',
                            'Notification settings coming soon!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {},
                          activeTrackColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: PhosphorIconsRegular.lock,
                        title: 'Privacy & Security',
                        subtitle: 'Password, 2FA, and security',
                        onTap: () {
                          Get.toNamed(Routes.privacySecurity, id: NavIds.profile);
                        },
                      ),
                    ],
                  ),
                  20.kH,

                  Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  12.kH,

                  _buildMenuCard(
                    context,
                    isDark,
                    [
                      Obx(() {
                        final isDarkMode =
                            themeController.currentTheme.value == ThemeMode.dark;
                        return _buildMenuItem(
                          icon: PhosphorIconsRegular.moon,
                          title: 'Dark Mode',
                          subtitle: 'Switch to ${isDarkMode ? 'light' : 'dark'} theme',
                          onTap: () => themeController.switchTheme(),
                          trailing: Switch(
                            value: isDarkMode,
                            onChanged: (value) => themeController.switchTheme(),
                            activeTrackColor: Theme.of(context).primaryColor,
                          ),
                        );
                      }),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: PhosphorIconsRegular.translate,
                        title: 'Language',
                        subtitle: 'English (US)',
                        onTap: () {
                          Get.snackbar(
                            'Language',
                            'Language selection coming soon!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ],
                  ),
                  20.kH,

                  Text(
                    'Support',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  12.kH,

                  _buildMenuCard(
                    context,
                    isDark,
                    [
                      _buildMenuItem(
                        icon: PhosphorIconsRegular.question,
                        title: 'Help & Support',
                        subtitle: 'FAQs and customer support',
                        onTap: () {
                          Get.snackbar(
                            'Help & Support',
                            'Support feature coming soon!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: PhosphorIconsRegular.info,
                        title: 'About',
                        subtitle: 'App version and information',
                        onTap: () {
                          _showAboutDialog(context);
                        },
                      ),
                    ],
                  ),
                  24.kH,

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () => _showLogoutDialog(context, authController),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withValues(alpha: 0.1),
                        foregroundColor: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.red.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      icon: const Icon(PhosphorIconsRegular.signOut),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  32.kH,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        8.kH,
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        4.kH,
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context, bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      onTap: trailing == null ? onTap : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.blue, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: trailing ??
          Icon(
            PhosphorIconsRegular.caretRight,
            color: Colors.grey[400],
            size: 20,
          ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.withValues(alpha: 0.1),
      indent: 16,
      endIndent: 16,
    );
  }

  void _showAboutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('About'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/icons/app_icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            16.kH,
            const Center(
              child: Text(
                'AppName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            8.kH,
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            16.kH,
            const Text(
              'GetX Clean Architecture Boilerplate',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            8.kH,
            const Text(
              'A Flutter boilerplate project implementing clean architecture principles with GetX for state management, routing, and dependency injection.',
              style: TextStyle(fontSize: 12),
            ),
            12.kH,
            const Text('Features:', style: TextStyle(fontWeight: FontWeight.w600)),
            4.kH,
            const Text('• GetX State Management', style: TextStyle(fontSize: 12)),
            const Text('• Clean Architecture', style: TextStyle(fontSize: 12)),
            const Text('• API Integration with Dio', style: TextStyle(fontSize: 12)),
            const Text('• Routing & Navigation', style: TextStyle(fontSize: 12)),
            const Text('• Modern UI/UX', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(
              PhosphorIconsRegular.signOut,
              color: Colors.red,
              size: 24,
            ),
            12.kW,
            const Text('Logout'),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout from the application?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              authController.logout();
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
