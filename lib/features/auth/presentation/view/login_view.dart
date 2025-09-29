import 'package:aura_interiors/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLogo(),
              const SizedBox(height: 48),
              _buildWelcomeText(),
              const SizedBox(height: 40),
              _buildLoginForm(),
              const SizedBox(height: 20),
              _buildRememberMeSection(),
              const SizedBox(height: 32),
              _buildLoginButton(),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildSocialLoginButtons(),
              const SizedBox(height: 32),
              _buildSignUpLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'AURA',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1F2937),
                  letterSpacing: 3,
                ),
              ),
              TextSpan(
                text: ' INTERIORS',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF6B7280),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 80,
          height: 3,
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFDC2626), Color(0xFFB91C1C)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF111827),
            letterSpacing: -0.5,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue your design journey',
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF6B7280),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        buildTextField(
          label: 'Email',
          hint: 'Enter your email address',
          icon: Icons.email_outlined,
        ),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Password',
          hint: 'Enter your password',
          icon: Icons.lock_outline,
          isPassword: true,
          onSuffixIconPressed: () {},
        ),
      ],
    );
  }

  Widget _buildRememberMeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: rememberMe,
                onChanged: (value) {
                  setState(() => rememberMe = value ?? false);
                },
                activeColor: const Color(0xFFDC2626),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Remember me',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Handle forgot password
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFDC2626),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Handle login
        },
        style:
            ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ).copyWith(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => null,
              ),
            ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE53E3E), Color(0xFFB91C1C)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircularSocialButton(
          onTap: () {
            // Handle Google login
          },
          icon: Image.asset('assets/images/google_logo.png', height: 24),
        ),
        const SizedBox(width: 20),
        _buildCircularSocialButton(
          onTap: () {
            // Handle Apple login
          },
          icon: const Icon(Icons.apple, color: Color(0xFF111827), size: 26),
        ),
      ],
    );
  }

  Widget _buildCircularSocialButton({
    required VoidCallback onTap,
    required Widget icon,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16, color: const Color(0xFF6B7280)),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            // Navigate to sign up
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFDC2626),
            ),
          ),
        ),
      ],
    );
  }
}
