import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/size_utils.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _twoFactorEnabled = false;
  bool _biometricEnabled = true;
  bool _loginAlerts = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.kH, // Add some top padding
              Text(
                'Authentication',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              12.kH,

              _buildCard(
                isDark,
                [
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.key,
                    title: 'Change Password',
                    subtitle: 'Update your password regularly',
                    onTap: () {
                      Get.snackbar(
                        'Change Password',
                        'Password change feature coming soon!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.shieldCheck,
                    title: 'Two-Factor Authentication',
                    subtitle: _twoFactorEnabled ? 'Enabled' : 'Disabled',
                    trailing: Switch(
                      value: _twoFactorEnabled,
                      onChanged: (value) {
                        setState(() => _twoFactorEnabled = value);
                        Get.snackbar(
                          _twoFactorEnabled ? 'Enabled' : 'Disabled',
                          'Two-factor authentication ${_twoFactorEnabled ? 'enabled' : 'disabled'}',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      activeTrackColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.fingerprint,
                    title: 'Biometric Login',
                    subtitle: 'Use fingerprint or face ID',
                    trailing: Switch(
                      value: _biometricEnabled,
                      onChanged: (value) {
                        setState(() => _biometricEnabled = value);
                      },
                      activeTrackColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              24.kH,

              Text(
                'Privacy',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              12.kH,

              _buildCard(
                isDark,
                [
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.eyeSlash,
                    title: 'Privacy Settings',
                    subtitle: 'Manage your privacy preferences',
                    onTap: () {
                      Get.snackbar(
                        'Privacy Settings',
                        'Privacy settings coming soon!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.userCircleGear,
                    title: 'Account Visibility',
                    subtitle: 'Public',
                    onTap: () {
                      _showVisibilityDialog();
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.shareNetwork,
                    title: 'Data Sharing',
                    subtitle: 'Manage data sharing preferences',
                    onTap: () {
                      Get.snackbar(
                        'Data Sharing',
                        'Data sharing settings coming soon!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
              24.kH,

              Text(
                'Security Alerts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              12.kH,

              _buildCard(
                isDark,
                [
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.bellRinging,
                    title: 'Login Alerts',
                    subtitle: 'Get notified of new login attempts',
                    trailing: Switch(
                      value: _loginAlerts,
                      onChanged: (value) {
                        setState(() => _loginAlerts = value);
                      },
                      activeTrackColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.devices,
                    title: 'Manage Devices',
                    subtitle: '3 devices connected',
                    onTap: () {
                      Get.snackbar(
                        'Manage Devices',
                        'Device management coming soon!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.clockCounterClockwise,
                    title: 'Login History',
                    subtitle: 'View your recent login activity',
                    onTap: () {
                      Get.snackbar(
                        'Login History',
                        'Login history feature coming soon!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
              24.kH,

              Text(
                'Danger Zone',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              12.kH,

              _buildCard(
                isDark,
                [
                  _buildMenuItem(
                    icon: PhosphorIconsRegular.trash,
                    title: 'Delete Account',
                    subtitle: 'Permanently delete your account',
                    iconColor: Colors.red,
                    onTap: () {
                      _showDeleteAccountDialog();
                    },
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(bool isDark, List<Widget> children) {
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
    VoidCallback? onTap,
    Widget? trailing,
    Color? iconColor,
  }) {
    return ListTile(
      onTap: trailing == null ? onTap : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (iconColor ?? Colors.blue).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? Colors.blue, size: 24),
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

  void _showVisibilityDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Account Visibility'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('Public'),
              value: 'public',
              groupValue: 'public',
              onChanged: (value) => Get.back(),
            ),
            RadioListTile(
              title: const Text('Private'),
              value: 'private',
              groupValue: 'public',
              onChanged: (value) => Get.back(),
            ),
            RadioListTile(
              title: const Text('Friends Only'),
              value: 'friends',
              groupValue: 'public',
              onChanged: (value) => Get.back(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            const Icon(PhosphorIconsRegular.warning, color: Colors.red, size: 24),
            12.kW,
            const Text('Delete Account'),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Account Deletion',
                'Account deletion feature will be available soon',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withValues(alpha: 0.1),
                colorText: Colors.red,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
