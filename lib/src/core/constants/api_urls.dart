import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_environments.dart';

class ApiUrls {
  static String get baseUrl => AppEnvironment.baseUrl;

  // Auth
  static String get login => "$baseUrl/auth/login";
  static String get register => "$baseUrl/auth/register";
  static String get logout => "$baseUrl/auth/logout";

  // User
  static String get userProfile => "$baseUrl/user/profile";
  static String get updateProfile => "$baseUrl/user/update";

  // Products
  static String get getAllProducts => "$baseUrl/products";
  static String getProductById(String id) => "$baseUrl/products/$id";
  static String get getCategories => "$baseUrl/products/categories";
  static String getProductsByCategory(String category) => "$baseUrl/products/category/$category";

  // Orders
  static String get createOrder => "$baseUrl/orders";
  static String getOrderDetails(String id) => "$baseUrl/orders/$id";
}
