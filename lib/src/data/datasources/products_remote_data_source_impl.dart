import 'package:dio/dio.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/api_urls.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/network/api_client.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/models/product_model.dart';

import 'products_remote_data_source.dart';

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiClient apiClient;

  ProductsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts({
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await apiClient.dio.get(
      ApiUrls.getAllProducts,
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final List<dynamic> data = response.data;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await apiClient.dio.get(
      ApiUrls.getCategories,
    );

    return List<String>.from(response.data);
  }

  @override
  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await apiClient.dio.get(
      ApiUrls.getProductsByCategory(category),
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final List<dynamic> data = response.data;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}