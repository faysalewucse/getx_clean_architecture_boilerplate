import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/products_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/network/api_client.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/datasources/products_remote_data_source.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/datasources/products_remote_data_source_impl.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/repositories/products_repository_impl.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/repositories/products_repository.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/get_products_usecase.dart';

class ProductsBindings implements Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()),
    );

    // Repositories
    Get.lazyPut<ProductsRepository>(
      () => ProductsRepositoryImpl(remoteDataSource: Get.find<ProductsRemoteDataSource>()),
    );

    // Use cases
    Get.lazyPut<GetProductsUseCase>(
      () => GetProductsUseCase(Get.find<ProductsRepository>()),
    );
    Get.lazyPut<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(Get.find<ProductsRepository>()),
    );
    Get.lazyPut<GetProductsByCategoryUseCase>(
      () => GetProductsByCategoryUseCase(Get.find<ProductsRepository>()),
    );

    // Controller
    Get.lazyPut<ProductsController>(() => ProductsController());
  }
}