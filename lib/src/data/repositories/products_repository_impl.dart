import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_data_source.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProducts({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        limit: limit,
        offset: offset,
      );
      return products.map((product) => product.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      return await remoteDataSource.getCategories();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory({
    required String category,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final products = await remoteDataSource.getProductsByCategory(
        category: category,
        limit: limit,
        offset: offset,
      );
      return products.map((product) => product.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get products by category: $e');
    }
  }
}