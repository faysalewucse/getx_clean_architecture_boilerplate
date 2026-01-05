import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/entities/product_entity.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/get_products_usecase.dart';

class ProductsController extends GetxController {
  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  ProductsController({
    GetProductsUseCase? getProductsUseCase,
    GetCategoriesUseCase? getCategoriesUseCase,
    GetProductsByCategoryUseCase? getProductsByCategoryUseCase,
  })  : _getProductsUseCase = getProductsUseCase ?? Get.find<GetProductsUseCase>(),
        _getCategoriesUseCase = getCategoriesUseCase ?? Get.find<GetCategoriesUseCase>(),
        _getProductsByCategoryUseCase = getProductsByCategoryUseCase ?? Get.find<GetProductsByCategoryUseCase>();

  final ScrollController scrollController = ScrollController();

  // Observable variables
  final RxList<ProductEntity> products = <ProductEntity>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxString selectedCategory = ''.obs;
  final RxString errorMessage = ''.obs;

  // Pagination
  final int _limit = 10;
  int _currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (!isLoadingMore.value && hasMore.value) {
          loadMoreProducts();
        }
      }
    });
  }

  Future<void> _loadInitialData() async {
    await loadCategories();
    await loadProducts();
  }

  Future<void> loadCategories() async {
    try {
      final result = await _getCategoriesUseCase.call();
      categories.value = ['All', ...result];
    } catch (e) {
      errorMessage.value = 'Failed to load categories: $e';
      Get.snackbar(
        'Error',
        'Failed to load categories',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    }
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 0;
      hasMore.value = true;
      products.clear();
    }

    if (isLoading.value && !refresh) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      List<ProductEntity> result;

      if (selectedCategory.value.isEmpty || selectedCategory.value == 'All') {
        result = await _getProductsUseCase.call(
          limit: _limit,
          offset: _currentPage * _limit,
        );
      } else {
        result = await _getProductsByCategoryUseCase.call(
          category: selectedCategory.value,
          limit: _limit,
          offset: _currentPage * _limit,
        );
      }

      if (result.length < _limit) {
        hasMore.value = false;
      }

      if (refresh) {
        products.value = result;
      } else {
        products.addAll(result);
      }

      _currentPage++;
    } catch (e) {
      errorMessage.value = 'Failed to load products: $e';
      Get.snackbar(
        'Error',
        'Failed to load products',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (!hasMore.value || isLoadingMore.value) return;

    isLoadingMore.value = true;

    try {
      List<ProductEntity> result;

      if (selectedCategory.value.isEmpty || selectedCategory.value == 'All') {
        result = await _getProductsUseCase.call(
          limit: _limit,
          offset: _currentPage * _limit,
        );
      } else {
        result = await _getProductsByCategoryUseCase.call(
          category: selectedCategory.value,
          limit: _limit,
          offset: _currentPage * _limit,
        );
      }

      if (result.length < _limit) {
        hasMore.value = false;
      }

      products.addAll(result);
      _currentPage++;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load more products',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    _currentPage = 0;
    hasMore.value = true;
    products.clear();
    loadProducts();
  }

  Future<void> refreshProducts() async {
    await loadProducts(refresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}