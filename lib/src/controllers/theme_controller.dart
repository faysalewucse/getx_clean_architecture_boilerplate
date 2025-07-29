import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/services/storage_service.dart';

class ThemeController extends GetxController {
  final StorageService _storageService;

  ThemeController(this._storageService);

  // Initialize with default value to prevent null access
  final Rx<ThemeMode> _currentTheme = ThemeMode.system.obs;

  // Getter for current theme
  Rx<ThemeMode> get currentTheme => _currentTheme;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }

  /// Load theme from storage with fallback to system theme
  void _loadThemeFromStorage() {
    try {
      final savedTheme = _storageService.getThemeMode();

      if (savedTheme != null) {
        _currentTheme.value = _stringToThemeMode(savedTheme);
      } else {
        // Default to system theme if no preference is saved
        _currentTheme.value = ThemeMode.system;
        _saveCurrentTheme();
      }
    } catch (e) {
      // Fallback to system theme on error
      _currentTheme.value = ThemeMode.system;
      debugPrint('Error loading theme: $e');
    }
  }

  /// Convert string to ThemeMode enum
  ThemeMode _stringToThemeMode(String themeString) {
    switch (themeString.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  /// Convert ThemeMode enum to string
  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  /// Save current theme to storage
  void _saveCurrentTheme() {
    try {
      _storageService.saveThemeMode(_themeModeToString(_currentTheme.value));
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  /// Switch between light and dark themes
  void switchTheme() {
    _currentTheme.value =
        _currentTheme.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;

    _saveCurrentTheme();
    update(); // Notify GetBuilder listeners
  }

  /// Set specific theme mode
  void setThemeMode(ThemeMode themeMode) {
    if (_currentTheme.value != themeMode) {
      _currentTheme.value = themeMode;
      _saveCurrentTheme();
      update(); // Notify GetBuilder listeners
    }
  }

  /// Toggle between light, dark, and system themes
  void toggleTheme() {
    switch (_currentTheme.value) {
      case ThemeMode.light:
        _currentTheme.value = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _currentTheme.value = ThemeMode.system;
        break;
      case ThemeMode.system:
        _currentTheme.value = ThemeMode.light;
        break;
    }
    _saveCurrentTheme();
    update(); // Notify GetBuilder listeners
  }

  /// Check if current theme is dark
  bool get isDarkMode {
    if (_currentTheme.value == ThemeMode.system) {
      // Get system brightness
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _currentTheme.value == ThemeMode.dark;
  }

  /// Check if current theme is light
  bool get isLightMode {
    if (_currentTheme.value == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.light;
    }
    return _currentTheme.value == ThemeMode.light;
  }
}
