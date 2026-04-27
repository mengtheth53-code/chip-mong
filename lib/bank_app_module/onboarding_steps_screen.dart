import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'success_screen.dart';

class OnboardingStepsScreen extends StatefulWidget {
  const OnboardingStepsScreen({super.key});

  @override
  State<OnboardingStepsScreen> createState() => _OnboardingStepsScreenState();
}

class _OnboardingStepsScreenState extends State<OnboardingStepsScreen> {
  bool _agreed = false;

  final List<_StepItem> _steps = const [
    _StepItem(
      number: '1',
      label: 'សូមបញ្ចូលលេខទូរសព្ទ',
      icon: Icons.phone_android_rounded,
      iconBg: Color(0xFFDFF5EC),
      iconColor: Color(0xFF1AAD5E),
    ),
    _StepItem(
      number: '2',
      label: 'បកខ្លឹមមុខរបស់អ្នក',
      icon: Icons.menu_book_rounded,
      iconBg: Color(0xFFDFF5EC),
      iconColor: Color(0xFF1AAD5E),
    ),
    _StepItem(
      number: '3',
      label: 'បកអត្តសញ្ញាណបណ្ណ បូ\nលិខិតឆ្លងដែនរបស់អ្នក',
      icon: Icons.person_outline_rounded,
      iconBg: Color(0xFFDFF5EC),
      iconColor: Color(0xFF1AAD5E),
    ),
    _StepItem(
      number: '4',
      label: 'បង្កើតលេខសម្ងាត់ (PIN) 6 ខ្ទង់',
      icon: Icons.settings_outlined,
      iconBg: Color(0xFFDFF5EC),
      iconColor: Color(0xFF1AAD5E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1AAD5E),
      body: Column(
        children: [
          // Green app bar area
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
          ),

          // White card body
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F8FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Hero icon
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFF5EC),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Icon(
                              Icons.receipt_long_rounded,
                              color: Color(0xFF1AAD5E),
                              size: 40,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Title
                          Text(
                            'ជំហានចុះឈ្មោះរបស់ គណនី\nបើកភ្លាម ប្រើភ្លាម',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.battambang(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A1A),
                              height: 1.45,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Subtitle
                          Text(
                            'បើកគណនីត្រឹមតែ ២ នៅ ៣នាទី បំណ្លោះ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.battambang(
                              fontSize: 18,
                              color: Color(0xFF888888),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Steps list
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: List.generate(_steps.length, (i) {
                                final step = _steps[i];
                                final isLast = i == _steps.length - 1;
                                return _StepRow(
                                  step: step,
                                  showDivider: !isLast,
                                );
                              }),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Terms checkbox row
                          GestureDetector(
                            onTap: () => setState(() => _agreed = !_agreed),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 22,
                                  height: 22,
                                  margin: const EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(
                                    color: _agreed
                                        ? const Color(0xFF1AAD5E)
                                        : Colors.white,
                                    border: Border.all(
                                      color: _agreed
                                          ? const Color(0xFF1AAD5E)
                                          : const Color(0xFFCCCCCC),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: _agreed
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.battambang(
                                        fontSize: 15,
                                        color: Color(0xFF555555),
                                        height: 1.6,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text:
                                              'ខ្ញុំបានអាន និងយល់ព្រម តាមលក្ខខណ្ឌនៃកម្មវិធីទូរសព្ទ Chip Mong Bank App និង គណនី Instant Account ',
                                        ),
                                        TextSpan(
                                          text: 'ខចែង និងលក្ខខណ្ឌទូទៅ',
                                          style: GoogleFonts.battambang(
                                            color: Color(0xFF1AAD5E),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // Bottom button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                    child: _PrimaryButton(
                      label: 'បន្ត',
                      enabled: _agreed,
                      onTap: _agreed
                          ? () {
                              HapticFeedback.lightImpact();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SuccessScreen(
                                    userName: 'MENG THETH',
                                    accountLabel: 'គណនីប្រាក់រៀលបស់អ្នក',
                                    accountNumber: '1016 3840',
                                    buttonLabel: 'ទំព័រដើម',
                                    successLabel: 'អបអរសាទរ!',
                                  ),
                                ),
                              );
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

// ── Step data model ───────────────────────────────────────────────────────────

class _StepItem {
  final String number;
  final String label;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const _StepItem({
    required this.number,
    required this.label,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });
}

// ── Step row widget ───────────────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final _StepItem step;
  final bool showDivider;

  const _StepRow({required this.step, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon bubble
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: step.iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(step.icon, color: step.iconColor, size: 24),
              ),

              const SizedBox(width: 14),

              // Step number
              Text(
                step.number,
                style: GoogleFonts.battambang(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFAAAAAA),
                ),
              ),

              const SizedBox(width: 10),

              // Label
              Expanded(
                child: Text(
                  step.label,
                  style: GoogleFonts.battambang(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFF0F0F0),
            indent: 16,
            endIndent: 16,
          ),
      ],
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
