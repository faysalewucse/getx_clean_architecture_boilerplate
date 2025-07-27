class ApiUrls {
  // Base URL
  static const String baseUrl = "https://api.example.com";

  // Auth
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String logout = "$baseUrl/auth/logout";

  // User
  static const String userProfile = "$baseUrl/user/profile";
  static const String updateProfile = "$baseUrl/user/update";

  // Products
  static const String getAllProducts = "$baseUrl/products";
  static const String getProductById = "$baseUrl/products"; // + /{id}

  // Orders
  static const String createOrder = "$baseUrl/orders";
  static const String getOrderDetails = "$baseUrl/orders"; // + /{id}
}
