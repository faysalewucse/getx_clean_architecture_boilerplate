import 'package:flutter/foundation.dart';

class AppEnvironment {
  static const String _debugBaseUrl = "https://dev-api.example.com";
  static const String _releaseBaseUrl = "https://api.example.com";
  static const String _debugInReleaseBaseUrl = "https://staging-api.example.com";

  /// Use this flag to force debug API even in release build
  static const bool forceDebugApi =
  bool.fromEnvironment('FORCE_DEBUG_API', defaultValue: false);

  static String get baseUrl {
    if (forceDebugApi) {
      return _debugInReleaseBaseUrl;
    } else if (kReleaseMode) {
      return _releaseBaseUrl;
    } else {
      return _debugBaseUrl;
    }
  }
}
