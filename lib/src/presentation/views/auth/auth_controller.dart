import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/models/login_request_model.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/entities/user_entity.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/login_usecase.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/usecases/is_user_logged_in_usecase.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/toast_utils.dart';

class AuthController extends GetxController {
  late final LoginUseCase loginUseCase;
  late final IsUserLoggedInUseCase isUserLoggedInUseCase;
  final RxBool isUserLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    loginUseCase = Get.find<LoginUseCase>();
    isUserLoggedInUseCase = Get.find<IsUserLoggedInUseCase>();
    isUserLoggedIn.value = isUserLoggedInUseCase.execute();
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
      isUserLoggedIn.value = true;
      Get.offAllNamed(Routes.home);
      ToastUtils.showSuccessToast(message: 'Welcome back, ${user.name}!');
    } catch (e) {
      isUserLoggedIn.value = false;
      _isLoading.value = false;
      ToastUtils.showErrorToast(message: e.toString());
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
