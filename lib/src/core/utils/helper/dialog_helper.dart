import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/network_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/buttons/primary_button.dart';

class DialogHelper {
  final networkController = Get.find<NetworkController>();

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
}