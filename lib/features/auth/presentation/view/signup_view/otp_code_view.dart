import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpCodeView extends StatefulWidget {
  final int length;
  final double boxSize;
  final Function(String)? onCompleted;
  
  const OtpCodeView({
    super.key,
    this.length = 6,
    this.boxSize = 56,
    this.onCompleted,
  });

  @override
  State<OtpCodeView> createState() => _OtpCodeViewState();
}

class _OtpCodeViewState extends State<OtpCodeView> with TickerProviderStateMixin {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final List<AnimationController> _animationControllers;
  late final List<Animation<double>> _scaleAnimations;
  final ValueNotifier<String> _codeNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    
    // Initialize animations
    _animationControllers = List.generate(
      widget.length,
      (_) => AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      ),
    );
    
    _scaleAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 1.0, end: 1.08).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    // Add focus listeners for animations
    for (int i = 0; i < widget.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _animationControllers[i].forward();
        } else {
          _animationControllers[i].reverse();
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    for (final a in _animationControllers) a.dispose();
    _codeNotifier.dispose();
    super.dispose();
  }

  void _updateCode() {
    final code = _controllers.map((c) => c.text).join();
    _codeNotifier.value = code;
    
    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    _updateCode();
  }

  void _onKey(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isNotEmpty) {
        _controllers[index].clear();
        _updateCode();
      } else if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].clear();
        _updateCode();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Widget box(int index) {
      return ScaleTransition(
        scale: _scaleAnimations[index],
        child: Container(
          width: widget.boxSize,
          height: widget.boxSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) => _onKey(event, index),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.grey[900],
                letterSpacing: 0.5,
              ),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: isDark ? Colors.grey[850] : Colors.grey[50],
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) => _onChanged(value, index),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Verify OTP",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.grey[900],
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 64,
                color: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
              const SizedBox(height: 24),
              Text(
                'Enter Verification Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.grey[900],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We sent a code to your phone',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.length, (i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: i == widget.length - 1 ? 0 : 6,
                    ),
                    child: box(i),
                  );
                }),
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder<String>(
                valueListenable: _codeNotifier,
                builder: (context, code, _) {
                  final isComplete = code.length == widget.length;
                  return AnimatedOpacity(
                    opacity: isComplete ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isComplete
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : (isDark ? Colors.grey[850] : Colors.white),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isComplete
                              ? Theme.of(context).primaryColor.withOpacity(0.3)
                              : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isComplete ? Icons.check_circle_outline : Icons.info_outline,
                            size: 18,
                            color: isComplete
                                ? Theme.of(context).primaryColor
                                : (isDark ? Colors.grey[400] : Colors.grey[600]),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            code.isEmpty
                                ? 'Enter ${widget.length}-digit code'
                                : code.length < widget.length
                                    ? '${widget.length - code.length} digits remaining'
                                    : 'Code complete!',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isComplete
                                  ? Theme.of(context).primaryColor
                                  : (isDark ? Colors.grey[400] : Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () {
                  // Resend code logic
                },
                child: Text(
                  "Didn't receive code? Resend",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}