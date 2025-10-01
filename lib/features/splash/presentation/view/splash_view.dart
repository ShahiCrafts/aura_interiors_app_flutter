import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Scale animation with slight overshoot effect
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Start animation
    _controller.forward();

    // Navigate after delay
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login/view');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/logo.png',
                      width: 168,
                      height: 88,
                    ),
                    // Brand name
                    const Text(
                      'Aura Interiors',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Tagline
                    Text(
                      'ELEVATE YOUR SPACE',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Colors.grey[600],
                        letterSpacing: 1.8,
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
