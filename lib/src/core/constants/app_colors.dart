import 'dart:ui';

class AppColors {
  // Primary Brand Colors - Modern Blue Palette
  static const Color primary = Color(0xFF2563EB); // Blue-600
  static const Color primaryLight = Color(0xFF3B82F6); // Blue-500
  static const Color primaryDark = Color(0xFF1D4ED8); // Blue-700
  static const Color primaryContainer = Color(0xFFDBEAFE); // Blue-100
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF1E3A8A); // Blue-800

  // Secondary Brand Colors - Complementary Amber
  static const Color secondary = Color(0xFFF59E0B); // Amber-500
  static const Color secondaryLight = Color(0xFFFBBF24); // Amber-400
  static const Color secondaryDark = Color(0xFFD97706); // Amber-600
  static const Color secondaryContainer = Color(0xFFFEF3C7); // Amber-100
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF92400E); // Amber-800

  // Background Colors
  static const Color background = Color(0xFFFAFAFA); // Neutral-50
  static const Color backgroundDark = Color(0xFF0F172A); // Slate-900
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B); // Slate-800
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate-100
  static const Color surfaceVariantDark = Color(0xFF334155); // Slate-700

  // Text Colors - High Contrast for Accessibility
  static const Color onBackground = Color(0xFF0F172A); // Slate-900
  static const Color onBackgroundDark = Color(0xFFE2E8F0); // Slate-200
  static const Color onSurface = Color(0xFF1E293B); // Slate-800
  static const Color onSurfaceDark = Color(0xFFE2E8F0); // Slate-200
  static const Color onSurfaceVariant = Color(0xFF64748B); // Slate-500
  static const Color outline = Color(0xFFCBD5E1); // Slate-300
  static const Color outlineDark = Color(0xFF475569); // Slate-600

  // Text Hierarchy
  static const Color textPrimary = Color(0xFF0F172A); // Slate-900
  static const Color textPrimaryDark = Color(0xFFE2E8F0); // Slate-200
  static const Color textSecondary = Color(0xFF475569); // Slate-600
  static const Color textSecondaryDark = Color(0xFF94A3B8); // Slate-400
  static const Color textTertiary = Color(0xFF64748B); // Slate-500
  static const Color textTertiaryDark = Color(0xFF64748B); // Slate-500
  static const Color textDisabled = Color(0xFF94A3B8); // Slate-400
  static const Color textDisabledDark = Color(0xFF64748B); // Slate-500

  // Border Colors
  static const Color border = Color(0xFFE2E8F0); // Slate-200
  static const Color borderDark = Color(0xFF334155); // Slate-700
  static const Color borderStrong = Color(0xFFCBD5E1); // Slate-300
  static const Color borderStrongDark = Color(0xFF475569); // Slate-600
  static const Color divider = Color(0xFFE2E8F0); // Slate-200
  static const Color dividerDark = Color(0xFF334155); // Slate-700

  // State Colors
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color errorLight = Color(0xFFFEE2E2); // Red-100
  static const Color errorDark = Color(0xFFDC2626); // Red-600
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF991B1B); // Red-800

  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color successLight = Color(0xFFD1FAE5); // Emerald-100
  static const Color successDark = Color(0xFF059669); // Emerald-600
  static const Color onSuccess = Color(0xFFFFFFFF);

  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color warningLight = Color(0xFFFEF3C7); // Amber-100
  static const Color warningDark = Color(0xFFD97706); // Amber-600
  static const Color onWarning = Color(0xFFFFFFFF);

  static const Color info = Color(0xFF3B82F6); // Blue-500
  static const Color infoLight = Color(0xFFDBEAFE); // Blue-100
  static const Color infoDark = Color(0xFF1D4ED8); // Blue-700
  static const Color onInfo = Color(0xFFFFFFFF);

  // Neutral Palette
  static const Color neutral50 = Color(0xFFF8FAFC); // Slate-50
  static const Color neutral100 = Color(0xFFF1F5F9); // Slate-100
  static const Color neutral200 = Color(0xFFE2E8F0); // Slate-200
  static const Color neutral300 = Color(0xFFCBD5E1); // Slate-300
  static const Color neutral400 = Color(0xFF94A3B8); // Slate-400
  static const Color neutral500 = Color(0xFF64748B); // Slate-500
  static const Color neutral600 = Color(0xFF475569); // Slate-600
  static const Color neutral700 = Color(0xFF334155); // Slate-700
  static const Color neutral800 = Color(0xFF1E293B); // Slate-800
  static const Color neutral900 = Color(0xFF0F172A); // Slate-900

  // Special Colors
  static const Color shadow = Color(0x1A000000); // 10% opacity black
  static const Color overlay = Color(0x80000000); // 50% opacity black
  static const Color scrim = Color(0x66000000); // 40% opacity black

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE2E8F0); // Slate-200
  static const Color shimmerHighlight = Color(0xFFF1F5F9); // Slate-100
  static const Color shimmerBaseDark = Color(0xFF334155); // Slate-700
  static const Color shimmerHighlightDark = Color(0xFF475569); // Slate-600

  // Focus & Selection
  static const Color focus = Color(0xFF3B82F6); // Blue-500
  static const Color selection = Color(0x4D3B82F6); // Blue-500 with 30% opacity
  static const Color hover = Color(0x0D000000); // 5% opacity black
  static const Color pressed = Color(0x1A000000); // 10% opacity black

  // Chart Colors (for data visualization)
  static const List<Color> chartColors = [
    Color(0xFF3B82F6), // Blue
    Color(0xFFF59E0B), // Amber
    Color(0xFF10B981), // Emerald
    Color(0xFFEF4444), // Red
    Color(0xFF8B5CF6), // Violet
    Color(0xFFF97316), // Orange
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEC4899), // Pink
  ];
}