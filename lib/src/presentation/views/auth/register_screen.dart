import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_paddings.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/buttons/primary_button.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/input_field_validators.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/inputs/input_field.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/size_utils.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/loaders/primary_loader.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement registration logic
      Get.snackbar(
        'Success',
        'Registration functionality coming soon!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            PhosphorIconsRegular.arrowLeft,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.screenPaddingAll,
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  20.kH,

                  // App Icon
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/icons/app_icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  20.kH,

                  // App Name
                  const Text(
                    'AppName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  8.kH,

                  // Create Account Text
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  32.kH,

                  // Name Field
                  InputField(
                    hintText: 'Full Name',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    prefixIcon: Icon(
                      PhosphorIconsRegular.user,
                      color: Colors.grey[600],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  16.kH,

                  // Email Field
                  InputField(
                    hintText: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    prefixIcon: Icon(
                      PhosphorIconsRegular.envelope,
                      color: Colors.grey[600],
                    ),
                    validator: InputFieldValidators.email,
                  ),
                  16.kH,

                  // Password Field
                  InputField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.newPassword],
                    prefixIcon: Icon(
                      PhosphorIconsRegular.lock,
                      color: Colors.grey[600],
                    ),
                    validator: InputFieldValidators.password,
                  ),
                  16.kH,

                  // Confirm Password Field
                  InputField(
                    hintText: 'Confirm Password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    prefixIcon: Icon(
                      PhosphorIconsRegular.lock,
                      color: Colors.grey[600],
                    ),
                    validator: _validateConfirmPassword,
                    onFieldSubmitted: (_) => _register(),
                  ),
                  24.kH,

                  // Register Button
                  _isLoading
                      ? const PrimaryLoader()
                      : PrimaryButton(
                          label: 'Sign Up',
                          onPressed: _register,
                        ),
                  24.kH,

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
