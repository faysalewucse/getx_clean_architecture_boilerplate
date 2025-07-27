import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/global_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/network_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/network/api_client.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/services/storage_service.dart';
import 'package:logger/logger.dart';

class InitialScreenBindings implements Bindings {
  InitialScreenBindings();

  @override
  void dependencies() {
    // Initialize logger first
    Get.lazyPut<Logger>(() => Logger());

    // Initialize storage service
    Get.lazyPut<StorageService>(() => StorageService());

    // Initialize API client with dependencies
    Get.lazyPut<Dio>(
      () => ApiClient(Get.find<StorageService>(), Get.find<Logger>()).dio,
    );

    // Initialize controllers
    Get.put(GlobalController());
    Get.put(NetworkController());
  }
}
