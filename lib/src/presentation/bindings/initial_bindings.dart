import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/global_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/network_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/network/api_client.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/datasources/auth_remote_data_sources.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/datasources/auth_remote_data_source_impl.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/repositories/auth_repository_impl.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/services/storage_service.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/repositories/auth_repository.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/login_usecase.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/is_user_logged_in_usecase.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/auth.controller.dart';
import 'package:logger/logger.dart';

class InitialScreenBindings implements Bindings {
  InitialScreenBindings();

  @override
  void dependencies() {
    // Initialize core services first
    Get.lazyPut<Logger>(() => Logger());
    Get.lazyPut<StorageService>(
      () => StorageService(),
    ); // Add StorageService registration

    // Initialize API client with dependencies
    Get.lazyPut<Dio>(
      () => ApiClient(Get.find<StorageService>(), Get.find<Logger>()).dio,
    );

    // Data sources
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: Get.find<Dio>()),
    );

    // Repositories - Use the concrete implementation, not the abstract class
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find<AuthRemoteDataSource>(),
      ),
    );

    // Use cases
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => IsUserLoggedInUseCase(Get.find<AuthRepository>()));

    // Controllers
    Get.put(GlobalController());
    Get.put(NetworkController());
    Get.lazyPut(() => AuthController());
  }
}
