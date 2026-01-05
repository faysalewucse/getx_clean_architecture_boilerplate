import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    int limit = 20,
    int offset = 0,
  });

  Future<List<String>> getCategories();

  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int limit = 20,
    int offset = 0,
  });
}