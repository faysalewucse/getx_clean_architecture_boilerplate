import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_colors.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void showToast({
    required String message,
    bool success = false,
    required Alignment alignment,
  }) {
    toastification.show(
      title: Text(success ? "Success" : "Error"),
      description: Text(message),
      alignment: alignment,
      showProgressBar: false,
      style: ToastificationStyle.fillColored,
      type: success ? ToastificationType.success : ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 3),
      primaryColor: success ? AppColors.success : AppColors.error,
    );
  }

  static void showSuccessToast({
    required String message,
    Alignment alignment = Alignment.bottomCenter,
  }) {
    showToast(message: message, success: true, alignment: alignment);
  }

  static void showErrorToast({
    required String message,
    Alignment alignment = Alignment.bottomCenter,
  }) {
    showToast(message: message, success: false, alignment: alignment);
  }
}