import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primary
  );
}
