import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_colors.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/themes/app_textstyles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      headlineSmall: AppTextStyles.headlineSmall,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineLarge: AppTextStyles.headlineLarge,
      bodySmall: AppTextStyles.bodySmall,
      bodyMedium: AppTextStyles.bodyMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      titleSmall: AppTextStyles.titleSmall,
      titleMedium: AppTextStyles.titleMedium,
      titleLarge: AppTextStyles.titleLarge,
      labelSmall: AppTextStyles.labelSmall,
      labelMedium: AppTextStyles.labelMedium,
      labelLarge: AppTextStyles.labelLarge,
      displaySmall: AppTextStyles.displaySmall,
      displayMedium: AppTextStyles.displayMedium,
      displayLarge: AppTextStyles.displayLarge,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryContainer,
      surface: Color(0xff1E1E1E),
      onSurface: Color(0xffF5F5F5),
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: const Color(0xff121212),
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
}
