import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _performStartupTasks();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  Future<void> _performStartupTasks() async {
    try {
      // Wait for animations to start
      await Future.delayed(const Duration(milliseconds: 500));

      // Simulate API calls and initialization tasks
      await _initializeServices();
      await _checkUserAuthentication();
      await _loadInitialData();

      // Minimum splash screen display time
      await Future.delayed(const Duration(milliseconds: 2000));

      // Navigate to home screen
      if (mounted) {
        Get.offAllNamed(Routes.home);
      }
    } catch (e) {
      // Handle errors gracefully
      _handleStartupError(e);
    }
  }

  Future<void> _initializeServices() async {
    // Initialize your services here
    // Example: Analytics, Firebase, etc.
    await Future.delayed(const Duration(milliseconds: 300));
    debugPrint('Services initialized');
  }

  Future<void> _checkUserAuthentication() async {
    // Check if user is logged in
    // Example: Check token validity, user session, etc.
    await Future.delayed(const Duration(milliseconds: 400));
    debugPrint('User authentication checked');
  }

  Future<void> _loadInitialData() async {
    // Load any initial data required by the app
    // Example: User profile, app settings, cached data, etc.
    await Future.delayed(const Duration(milliseconds: 500));
    debugPrint('Initial data loaded');
  }

  void _handleStartupError(dynamic error) {
    // Handle startup errors
    debugPrint('Startup error: $error');

    // Show error dialog or navigate to error screen
    Get.snackbar(
      'Error',
      'Failed to initialize app. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withValues(alpha: 0.1),
      colorText: Colors.red,
    );

    // Still navigate to home screen after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Get.offAllNamed(Routes.home);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.rocket_launch,
                        size: 60,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // App Name
                    const Text(
                      'GetX Boilerplate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Tagline
                    Text(
                      'Clean Architecture Made Simple',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Loading Indicator
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}