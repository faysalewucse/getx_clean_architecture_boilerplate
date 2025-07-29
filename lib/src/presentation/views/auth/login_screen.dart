import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_paddings.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/auth_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/buttons/primary_button.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/input_field_validators.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/inputs/input_field.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/size_utils.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/loaders/primary_loader.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenPaddingAll,
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo/Title
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                20.kH,

                // Email Field
                InputField(
                  hintText: 'Email',
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: InputFieldValidators.email,
                ),
                16.kH,

                // Password Field
                InputField(
                  hintText: 'Password',
                  controller: controller.passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  validator: InputFieldValidators.password,
                  onFieldSubmitted: (_) => controller.login(),
                ),
                12.kH,

                // Remember Me
                Obx(
                  () => CheckboxListTile(
                    title: const Text('Remember me'),
                    value: controller.rememberMe.value,
                    onChanged: (_) => controller.toggleRememberMe(),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                20.kH,

                // Login Button
                Obx(
                  () =>
                      controller.isLoading
                          ? const PrimaryLoader()
                          : PrimaryButton(label: 'Login', onPressed: controller.login),
                ),
                16.kH,

                // Forgot Password
                TextButton(
                  onPressed: () {
                    // Navigate to forgot password
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
