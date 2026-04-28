import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Number',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1AAD5E)),
      ),
      home: const PhoneNumberScreen(),
    );
  }
}

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasInput = false;

  // Total steps in the registration flow
  static const int _totalSteps = 4;
  static const int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() => _hasInput = _phoneController.text.trim().isNotEmpty);
    });
    // Auto-focus keyboard
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A6B3C),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // ── Green header ──────────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: back + help
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Text(
                        'ត្រូវការជំនួយ?',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Step label + progress bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'លេខទូរសព្ទ',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _StepProgressBar(
                        totalSteps: _totalSteps,
                        currentStep: _currentStep,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── White body ────────────────────────────────────────────────────
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F4F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFF5EC),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.phone_android_rounded,
                              color: Color(0xFF1AAD5E),
                              size: 26,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Title
                          Text(
                            'បញ្ចូលលេខទូរសព្ទ',
                            style: GoogleFonts.battambang(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Subtitle
                          Text(
                            'សូមប្រាកដថាស៊ីមកាតនៃលេខទូរសព្ទនេះបានភ្ជាប់ប្រើជាមួយទូរសព្ទមួយនេះ.',
                            style: GoogleFonts.battambang(
                              fontSize: 18,
                              color: Color(0xFF777777),
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Phone input field
                          _PhoneInputField(
                            controller: _phoneController,
                            focusNode: _focusNode,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Bottom button ─────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      22,
                      8,
                      22,
                      MediaQuery.of(context).viewInsets.bottom > 0
                          ? MediaQuery.of(context).viewInsets.bottom + 12
                          : 28,
                    ),
                    child: _PrimaryButton(
                      label: 'បន្ត',
                      enabled: _hasInput,
                      onTap: _hasInput
                          ? () {
                              HapticFeedback.lightImpact();
                              FocusScope.of(context).unfocus();
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step progress bar ─────────────────────────────────────────────────────────

class _StepProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const _StepProgressBar({required this.totalSteps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (i) {
        final isActive = i < currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < totalSteps - 1 ? 6 : 0),
            height: 3.5,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}

// ── Phone input field ─────────────────────────────────────────────────────────

class _PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _PhoneInputField({required this.controller, required this.focusNode});

  @override
  State<_PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<_PhoneInputField> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => _isFocused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isFocused ? const Color(0xFF1AAD5E) : const Color(0xFFE0E0E0),
          width: _isFocused ? 1.5 : 1,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: const Color(0xFF1AAD5E).withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'លេខទូរសព្ទ',
              style: GoogleFonts.battambang(
                fontSize: 15,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s\-]')),
              ],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
                letterSpacing: 0.5,
              ),
              decoration: InputDecoration(
                hintText: '+855 XXXXXXXXX',
                hintStyle: GoogleFonts.battambang(
                  fontSize: 16,
                  color: Color(0xFFBBBBBB),
                  fontWeight: FontWeight.w400,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              cursorColor: const Color(0xFF1AAD5E),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Primary button ────────────────────────────────────────────────────────────

class _PrimaryButton extends StatefulWidget {
  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  const _PrimaryButton({
    required this.label,
    required this.enabled,
    this.onTap,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onTap?.call();
            }
          : null,
      onTapCancel: widget.enabled
          ? () => setState(() => _pressed = false)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: double.infinity,
        height: 54,
        transform: _pressed
            ? (Matrix4.identity()..scaleByDouble(0.97, 0.97, 1.0, 1.0))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.enabled
              ? (_pressed ? const Color(0xFF158F4E) : const Color(0xFF1AAD5E))
              : const Color(0xFFCCCCCC),
          borderRadius: BorderRadius.circular(32),
          boxShadow: widget.enabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF1AAD5E).withValues(alpha: 0.30),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            widget.label,
            style: GoogleFonts.battambang(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: widget.enabled ? Colors.white : const Color(0xFF999999),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
