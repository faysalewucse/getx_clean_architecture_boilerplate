import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/network_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_radius.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_colors.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/buttons/primary_button.dart';

class DialogUtils {
  static void showNoInternetDialog() {
    if (!Get.isDialogOpen!) {
      final networkController = Get.find<NetworkController>();

      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
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
                    await networkController.retryConnectionCheck();
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
    bool mustUpdate = currentVersion < minimumVersion;

    Get.dialog(
      PopScope(
        canPop: !mustUpdate,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radius10,
          ),
          title: const Text("Update Available!"),
          content: Text(
            mustUpdate
                ? "You must update to keep using Mediwhole."
                : "A new version of Mediwhole is available. Please update to the latest version.",
            textAlign: TextAlign.justify,
            style: TextStyle(color: AppColors.secondary, fontSize: 14),
          ),
          actions: [
            if (!mustUpdate)
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Later",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            TextButton(
              onPressed: () async {

              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade50,
                foregroundColor: Colors.green,
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                "Update",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: !mustUpdate, // disables tap outside to close
    );
  }
}