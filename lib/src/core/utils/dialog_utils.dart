import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    bool mustUpdate = currentVersion < minimumVersion;

    Get.dialog(
      PopScope(
        canPop: !mustUpdate,
        child: AlertDialog(
          title: Text(mustUpdate ? 'mandatoryUpdateTitle'.tr : 'optionalUpdateTitle'.tr),
          content: Text(
            mustUpdate
                ? 'mandatoryUpdateMessage'.tr
                : 'optionalUpdateMessage'.tr,
          ),
          actions: [
            if (!mustUpdate)
              TextButton(
                onPressed: () => Get.back(),
                child: Text('later'.tr),
              ),
            if (mustUpdate)
              TextButton(
                onPressed: () => Get.close(0), // Exit the app
                child: Text('exit'.tr),
              ),
            TextButton(
              onPressed: () async {
                await UrlLauncherUtils.openUrl(AppStrings.playStoreUrl);
              },
              child: Text('update'.tr),
            ),
          ],
        ),
      ),
      barrierDismissible: !mustUpdate,
    );
  }
}
