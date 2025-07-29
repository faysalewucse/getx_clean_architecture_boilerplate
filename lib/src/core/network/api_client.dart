import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/api_urls.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/network/api_interceptors.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/services/storage_service.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final StorageService _storageService;
  final Logger _logger;

  final Dio dio = Dio();
  final getStorage = GetStorage();

  ApiClient(this._storageService, this._logger) {
    dio.options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      headers: {'Content-Type': 'application/json'},
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    );

    // Add the custom interceptor
    dio.interceptors.add(ApiInterceptor(_storageService, _logger));
  }
}
