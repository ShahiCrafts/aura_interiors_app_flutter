import 'dart:async';

import 'package:aura_interiors/features/auth/presentation/bloc/otp_code_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/otp_code_event.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/otp_code_state.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCodeView extends StatefulWidget {
  const OtpCodeView({super.key});

  @override
  State<OtpCodeView> createState() => _OtpCodeViewState();
}

class _OtpCodeViewState extends State<OtpCodeView> {
  final _formKey = GlobalKey<FormState>();
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  int _secondsRemaining = 60;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) _focusNodes.first.requestFocus();
    });

    _startResendCountDown();
  }

  void _startResendCountDown() {
    _resendTimer?.cancel();

    setState(() {
      _secondsRemaining = 60;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    final state = context.read<SignupBloc>().state;
    context.read<OtpCodeBloc>().add(OtpResendRequested(state.email));
    _startResendCountDown();
  }

  void _verifyCode() {
    FocusScope.of(context).unfocus();
    final code = context.read<OtpCodeBloc>().state.code;

    if (code.length == 6) {
      final email = context.read<SignupBloc>().state.email;

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please re-enter your email.'),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }

      context.read<OtpCodeBloc>().add(OtpVerifyRequested(email, code));
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();

    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onKey(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isNotEmpty) {
        _controllers[index].clear();
      } else if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].clear();
      }
    }
  }

  Widget _otpBox(int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 48,
      height: 52,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1.4,
        ),
      ),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) => _onKey(event, index),
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            if (value.length == 1 && index < 5) {
              _focusNodes[index + 1].requestFocus();
            }
            context.read<OtpCodeBloc>().add(OtpDigitChanged(index, value));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<OtpCodeBloc, OtpCodeState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Verify OTP',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF111827),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<OtpCodeBloc, OtpCodeState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 64,
                      color: const Color(0xFFDC2626).withValues(alpha: 0.9),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Enter verification code',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      "We've sent a 6-digit OTP code to your registered email. Please check your inbox.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: isDark
                            ? Colors.grey[400]
                            : const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 40),

                    Wrap(
                      key: _formKey,
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 8,
                      children: List.generate(6, (index) => _otpBox(index)),
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: state.status == FormStatus.submitting
                            ? null
                            : _verifyCode,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                        ),
                        child: state.status == FormStatus.submitting
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE53E3E),
                                      Color(0xFFB91C1C),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Verify',
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
                    ),

                    const SizedBox(height: 32),

                    GestureDetector(
                      onTap: _secondsRemaining == 0 ? _resendCode : null,
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't receive the code? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? Colors.grey[400]
                                : const Color(0xFF6B7280),
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: _secondsRemaining == 0
                                  ? "Resend"
                                  : 'Resend in $_secondsRemaining s',
                              style: TextStyle(
                                color: _secondsRemaining == 0
                                    ? const Color(0xFFDC2626)
                                    : (isDark
                                          ? Colors.grey[600]
                                          : Colors.grey[400]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
