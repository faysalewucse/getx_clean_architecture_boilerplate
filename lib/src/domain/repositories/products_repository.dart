import '../entities/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> getProducts({
    int limit = 20,
    int offset = 0,
  });

  Future<List<String>> getCategories();

  Future<List<ProductEntity>> getProductsByCategory({
    required String category,
    int limit = 20,
    int offset = 0,
  });
}