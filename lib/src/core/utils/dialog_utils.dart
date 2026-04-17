import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/network_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_strings.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/url_launcher_utils.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/buttons/primary_button.dart';

class DialogUtils {
  static void showNoInternetDialog() {
    if (!Get.isDialogOpen!) {
      final networkController = Get.find<NetworkController>();

      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off_rounded, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'no_internet_connection'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'please_check_your_internet_connection'.tr,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () async {
                    if (Get.routing.current == Routes.initialRoute) {
                      Get.offAndToNamed(Routes.initialRoute);
                    } else {
                      Get.back();
                      await networkController.retryConnectionCheck();
                    }
                  },
                  label: 'retry'.tr,
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  static void showUpdateDialog({
    required int currentVersion,
    required int minimumVersion,
  }) {
    final mustUpdate = currentVersion < minimumVersion;

    Get.bottomSheet(
      PopScope(
        canPop: !mustUpdate,
        child: _UpdateSheet(mustUpdate: mustUpdate),
      ),
      isDismissible: !mustUpdate,
      enableDrag: !mustUpdate,
      isScrollControlled: true,
    );
  }
}

class _UpdateSheet extends StatefulWidget {
  final bool mustUpdate;

  const _UpdateSheet({required this.mustUpdate});

  @override
  State<_UpdateSheet> createState() => _UpdateSheetState();
}

class _UpdateSheetState extends State<_UpdateSheet> {
  bool _whatsNewExpanded = false;

  bool get mustUpdate => widget.mustUpdate;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // App icon
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
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
              const SizedBox(height: 20),

              // Title
              Text(
                mustUpdate ? 'Update Required' : 'Update Available',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                mustUpdate
                    ? 'This version is no longer supported. Please update to continue using ${AppStrings.appName}.'
                    : 'A new version of ${AppStrings.appName} is available with improvements and bug fixes.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 24),

              // What's new accordion
              GestureDetector(
                onTap: () => setState(() => _whatsNewExpanded = !_whatsNewExpanded),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "What's new",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: _whatsNewExpanded ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              PhosphorIconsRegular.caretDown,
                              size: 18,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              _buildChangelogItem(
                                context,
                                icon: PhosphorIconsRegular.rocket,
                                text: 'Performance improvements',
                                isDark: isDark,
                              ),
                              const SizedBox(height: 8),
                              _buildChangelogItem(
                                context,
                                icon: PhosphorIconsRegular.bug,
                                text: 'Bug fixes and stability',
                                isDark: isDark,
                              ),
                              const SizedBox(height: 8),
                              _buildChangelogItem(
                                context,
                                icon: PhosphorIconsRegular.sparkle,
                                text: 'New features and UI enhancements',
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),
                        crossFadeState: _whatsNewExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons row
              Row(
                children: [
                  if (!mustUpdate)
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Not Now',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ),
                  if (mustUpdate)
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Get.close(0),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(
                              color: Colors.red.withValues(alpha: 0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Exit App',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await UrlLauncherUtils.openUrl(AppStrings.playStoreUrl);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Update Now',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangelogItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark ? Colors.white : Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.grey[300] : Colors.grey[700],
                ),
          ),
        ),
      ],
    );
  }
}
