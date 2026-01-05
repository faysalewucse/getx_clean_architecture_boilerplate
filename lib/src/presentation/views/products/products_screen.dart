import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/controllers/products_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/entities/product_entity.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/widgets/custom_image_viewer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsController productController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: productController.refreshProducts,
        child: Column(
          children: [
            _buildCategoryFilter(),
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value && productController.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (productController.errorMessage.value.isNotEmpty &&
                    productController.products.isEmpty) {
                  return _buildErrorWidget();
                }

                if (productController.products.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return _buildProductsGrid();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: productController.categories.length,
            itemBuilder: (context, index) {
              final category = productController.categories[index];
              final isSelected = productController.selectedCategory.value == category ||
                  (productController.selectedCategory.value.isEmpty && category == 'All');

              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: FilterChip(
                  label: Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) => productController.selectCategory(
                    category == 'All' ? '' : category,
                  ),
                  backgroundColor: Colors.grey[100],
                  selectedColor: Theme.of(context).primaryColor,
                  checkmarkColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              );
            },
          )),
    );
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      controller: productController.scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: productController.products.length + (productController.hasMore.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= productController.products.length) {
          return Obx(() => productController.isLoadingMore.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink());
        }

        final product = productController.products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(ProductEntity product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CustomImageViewer.card(
              imageUrl: product.image,
              width: double.infinity,
              borderRadius: 12,
              fit: BoxFit.cover,
              placeholderColor: Colors.grey[100],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.rate.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' (${product.rating.count})',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => Text(
                productController.errorMessage.value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => productController.refreshProducts(),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
