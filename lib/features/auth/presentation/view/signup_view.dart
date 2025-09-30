import 'package:aura_interiors/app/constant/routes.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_event.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_state.dart';
import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:aura_interiors/features/auth/presentation/widgets/circular_social_button.dart';
import 'package:aura_interiors/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
        } else if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    Image.asset('assets/images/logo.png', height: 60),
                    const SizedBox(height: 42),

                    // Title & Subtitle
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                        letterSpacing: -0.5,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign up to start your design journey',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF6B7280),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Email & Password
                    buildTextField(
                      controller: emailController,
                      label: 'Email',
                      hint: 'Enter your email address',
                      isPasswordVisible: false,
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 16),
                    buildTextField(
                      controller: passwordController,
                      label: 'Password',
                      hint: 'Create a password',
                      isPasswordVisible: !state.obscurePassword,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      onSuffixIconPressed: () {
                        context.read<SignupBloc>().add(
                          PasswordVisibilityToggled(),
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is a required field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.12,
                          child: Checkbox(
                            value: state.agreeToPolicy,
                            onChanged: (value) {
                              context.read<SignupBloc>().add(
                                PrivacyPolicyToggled(value ?? false),
                              );
                            },
                            activeColor: const Color(0xFFDC2626),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                fontSize: 15,
                                color: const Color(0xFF374151),
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFDC2626),
                                  ),
                                ),
                                const TextSpan(text: ' & '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFDC2626),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Button
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: state.agreeToPolicy
                            ? () {
                                context.read<SignupBloc>().add(
                                  SignupSubmitted(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                              }
                            : null,
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
                            gradient: state.agreeToPolicy
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFE53E3E),
                                      Color(0xFFB91C1C),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )
                                : null,
                            color: state.agreeToPolicy
                                ? null
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: state.agreeToPolicy
                                    ? Colors.white
                                    : Colors.grey.shade600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or sign up with',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Social Signup Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildCircularSocialButton(
                          onTap: () {
                            // Handle Google signup
                          },
                          icon: Image.asset(
                            'assets/images/google_logo.png',
                            height: 24,
                          ),
                        ),
                        const SizedBox(width: 20),
                        buildCircularSocialButton(
                          onTap: () {
                            // Handle Apple signup
                          },
                          icon: const Icon(
                            Icons.apple,
                            color: Color(0xFF111827),
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Redirect to Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            context.go(Routes.login);
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
