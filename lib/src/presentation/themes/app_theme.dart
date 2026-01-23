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
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: _buildTextTheme(Brightness.light),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.3,
        color: AppColors.onSurface,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryContainer,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: _buildTextTheme(Brightness.dark),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.3,
        color: AppColors.onSurfaceDark,
      ),
    ),
  );

  // Helper method to build text theme with proper font weights
  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color textColor = brightness == Brightness.dark
        ? AppColors.onSurfaceDark
        : AppColors.onSurface;

    return GoogleFonts.poppinsTextTheme().copyWith(
      // Display styles
      displayLarge: AppTextStyles.displayLarge.copyWith(color: textColor),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: textColor),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: textColor),

      // Headline styles
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: textColor),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: textColor),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: textColor),

      // Title styles
      titleLarge: AppTextStyles.titleLarge.copyWith(color: textColor),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: textColor),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: textColor),

      // Body styles
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: textColor),

      // Label styles
      labelLarge: AppTextStyles.labelLarge.copyWith(color: textColor),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: textColor),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: textColor),
    );
  }
}
