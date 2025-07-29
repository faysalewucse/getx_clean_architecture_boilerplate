import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/toast_utils.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/services/storage_service.dart';
import 'package:logger/logger.dart';

class ApiInterceptor extends Interceptor {
  final StorageService _storageService;
  final Logger _logger;

  ApiInterceptor(this._storageService, this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      // 🔐 Skip adding token for public routes

      final token = _storageService.getAuthToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = "Bearer $token";
      }

      if (kDebugMode) {
        final requestData = options.data;
        final dataToLog =
            requestData is FormData
                ? requestData.fields
                    .toString() // avoid files
                : requestData?.toString() ?? "No Data";

        debugPrint("➡️ API REQUEST =>");
        debugPrint("METHOD: ${options.method}");
        debugPrint("URL: ${options.uri}");
        debugPrint("HEADERS: ${options.headers}");
        debugPrint("BODY: $dataToLog");
      }
    } catch (e) {
      _logger.e("Error in API request interceptor", error: e);
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint("✅ API RESPONSE =>");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("DATA: ${response.data}");
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint("❌ API ERROR =>");
      debugPrint("STATUS: ${err.response?.statusCode}");
      debugPrint("MESSAGE: ${err.response?.data?["message"] ?? err.message}");
    }

    // 🍞 Show toast based on error type
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        ToastUtils.showErrorToast(message: '⏱️ Connection Timeout');
        break;
      case DioExceptionType.receiveTimeout:
        ToastUtils.showErrorToast(message: '📥 Receive Timeout');
        break;
      case DioExceptionType.sendTimeout:
        ToastUtils.showErrorToast(message: '📤 Send Timeout');
        break;
      case DioExceptionType.badResponse:
        final message =
            err.response?.data?["message"] ?? "Something went wrong.";
        ToastUtils.showErrorToast(message: message);
        break;
      case DioExceptionType.cancel:
        ToastUtils.showErrorToast(message: '🚫 Request Cancelled');
        break;
      default:
        if (err.message?.contains("Failed host lookup") == true) {
          ToastUtils.showErrorToast(message: "🌐 Service Not Available");
        } else {
          ToastUtils.showErrorToast(message: err.message ?? "❓ Unknown Error");
        }
    }

    handler.next(err);
  }
}
