import 'package:flutter/material.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primary,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black54,
    primaryColor: AppColors.primary,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}
