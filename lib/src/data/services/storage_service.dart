import 'package:get_storage/get_storage.dart';

class StorageService {
  // Singleton instance
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;

  // Private constructor
  StorageService._internal();

  // Initialize GetStorage instance
  final GetStorage _storage = GetStorage();

  // Keys for storing data
  static const String _authTokenKey = 'refreshToken';
  static const String _fcmTokenKey = 'fcmToken';
  static const String _themeModeKey = 'themeMode';
  static const String _languageKey = 'language';

  /// Save Authentication Token
  void saveAuthToken(String token) {
    _storage.write(_authTokenKey, token);
  }

  void saveFCMToken(String token) {
    _storage.write(_fcmTokenKey, token);
  }
  String? getFCMToken() {
    return _storage.read<String>(_fcmTokenKey);
  }

  /// Get Authentication Token
  String? getAuthToken() {
    return _storage.read<String>(_authTokenKey);
  }

  /// Remove Authentication Token
  void removeAuthToken() {
    _storage.remove(_authTokenKey);
  }

  /// Save Theme Mode (Light/Dark)
  void saveThemeMode(String themeMode) {
    // Example values: "light" or "dark"
    _storage.write(_themeModeKey, themeMode);
  }

  /// Get Theme Mode
  String? getThemeMode() {
    return _storage.read<String>(_themeModeKey);
  }

  /// Save Language Preference
  void saveLanguage(String languageCode) {
    // Example values: "en" or "bn"
    _storage.write(_languageKey, languageCode);
  }

  /// Get Language Preference
  String? getLanguage() {
    return _storage.read<String>(_languageKey);
  }

  /// Remove All Stored Data (if needed)
  void clearStorage() {
    _storage.erase();
  }
}
