import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_clean_architecture_boilerplate/src/domain/entities/user_entity.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/login_usecase.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/models/login_request_model.dart';

class AuthController extends GetxController {
  late final LoginUseCase loginUseCase;

  @override
  void onInit() {
    super.onInit();
    loginUseCase = Get.find<LoginUseCase>();
  }

  // Observables
  final _isLoading = false.obs;
  final _user = Rxn<UserEntity>();

  // Getters
  bool get isLoading => _isLoading.value;
  UserEntity? get user => _user.value;
  bool get isLoggedIn => _user.value != null;

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    _isLoading.value = true;
    try {
      final params = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      final user = await loginUseCase.execute(loginReqModel: params);
      _isLoading.value = false;
      _user.value = user;
      Get.offAllNamed(Routes.home);
      Get.snackbar(
        'Success',
        'Welcome back, [${user.name}]!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void logout() {
    _user.value = null;
    Get.offAllNamed(Routes.login);
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }
}
