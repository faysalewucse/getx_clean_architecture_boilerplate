import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/auth/auth_controller.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/inputs/input_field.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/buttons/primary_button.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/size_utils.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/app_paddings.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final authController = Get.find<AuthController>();
    _nameController = TextEditingController(text: authController.user?.name ?? 'User Name');
    _emailController = TextEditingController(text: 'user@example.com');
    _phoneController = TextEditingController(text: '+1 234 567 8900');
    _bioController = TextEditingController(text: 'Flutter Developer | Tech Enthusiast');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green,
        icon: const Icon(PhosphorIconsRegular.checkCircle, color: Colors.green),
      );
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.screenPaddingAll,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  16.kH, // Add some top padding
                // Profile Picture Section
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          PhosphorIconsFill.user,
                          size: 60,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.snackbar(
                            'Change Photo',
                            'Photo picker coming soon!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            PhosphorIconsFill.camera,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                32.kH,

                // Full Name
                InputField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  controller: _nameController,
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
                20.kH,

                // Email
                InputField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    PhosphorIconsRegular.envelope,
                    color: Colors.grey[600],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                20.kH,

                // Phone
                InputField(
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(
                    PhosphorIconsRegular.phone,
                    color: Colors.grey[600],
                  ),
                ),
                20.kH,

                // Bio
                InputField(
                  label: 'Bio',
                  hintText: 'Tell us about yourself',
                  controller: _bioController,
                  maxLines: 4,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Icon(
                      PhosphorIconsRegular.textAlignLeft,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                32.kH,

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: 'Save Changes',
                    onPressed: _saveProfile,
                  ),
                ),
                16.kH,

                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
