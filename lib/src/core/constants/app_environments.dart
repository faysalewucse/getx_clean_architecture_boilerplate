import 'package:flutter/foundation.dart';

class AppEnvironment {
  static const String _debugBaseUrl = "https://fakestoreapi.com";
  static const String _releaseBaseUrl = "https://fakestoreapi.com";
  static const String _debugInReleaseBaseUrl = "https://fakestoreapi.com";

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
