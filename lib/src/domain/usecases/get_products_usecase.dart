import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call({
    int limit = 20,
    int offset = 0,
  }) async {
    return await repository.getProducts(
      limit: limit,
      offset: offset,
    );
  }
}

class GetCategoriesUseCase {
  final ProductsRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<String>> call() async {
    return await repository.getCategories();
  }
}

class GetProductsByCategoryUseCase {
  final ProductsRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<List<ProductEntity>> call({
    required String category,
    int limit = 20,
    int offset = 0,
  }) async {
    return await repository.getProductsByCategory(
      category: category,
      limit: limit,
      offset: offset,
    );
  }
}