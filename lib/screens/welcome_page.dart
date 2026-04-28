import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

import 'fill_screen.dart';
import 'onboarding_steps_screen.dart';

// ─────────────────────────────────────────────
//  Main Screen
// ─────────────────────────────────────────────
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const Color _green = Color.fromARGB(255, 30, 171, 96);
  static const Color _cardBg = Color(0xFFEEF8F2);

  void _openOnboarding(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const OnboardingStepsScreen()));
  }

  void _openTransfer(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const FillScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 171, 96),
      body: Column(
        children: [
          // ── Top bar + hero section (expands to fill available space)
          Expanded(
            child: Stack(
              children: [
                // Building illustration (right-aligned, full height)
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _BuildingIllustration(),
                  ),
                ),

                // Foreground content
                SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.maybePop(context),
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.arrow_back_ios_new_sharp,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:  [
                                      Text(
                                        'សូមស្វាគមន៍មកកាន់',
                                        style: GoogleFonts.battambang(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        'CHIP MONG BANK',
                                        style: GoogleFonts.battambang(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Headset button
                            _CircleButton(
                              child: const Icon(
                                Icons.headset_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Flag / language button
                            _CircleButton(child: const _KhmerFlag()),
                          ],
                        ),
                      ),

                      // ── Hero text
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 180, 48),
                        child: Text(
                          'គ្រប់គ្រង ហិរញ្ញវត្ថុ និងបង្កើនប្រាក់របស់អ្នក',
                          style: GoogleFonts.battambang(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            height: 1.50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom sheet
          Container(
            decoration: const BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  // Login button (light)
                  _MenuTile(
                    icon: Icons.credit_card_rounded,
                    iconBg: const Color(0xFFD4EFE0),
                    iconColor: _green,
                    label: 'ចូលគណនី',
                    dark: false,
                    onTap: () => _openTransfer(context),
                  ),
                  const SizedBox(height: 10),

                  // Register button (dark green)
                  _MenuTile(
                    icon: Icons.badge_outlined,
                    iconBg: Colors.white.withValues(alpha: 0.22),
                    iconColor: Colors.white,
                    label: 'បង្កើតគណនី បើកភ្លាម ប្រើភ្លាម',
                    dark: true,
                    onTap: () => _openOnboarding(context),
                  ),
                  const SizedBox(height: 18),

                  // Version
                  Text(
                    'កំណែកម្មវិធី 5.2.2 - 5020200',
                    style: GoogleFonts.battambang(
                      color: Color.fromARGB(255, 87, 90, 88),
                      fontSize: 11.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '( 04 Apr 2026 05:16 AM )',
                    style: TextStyle(color: Color(0xFF8A9E93), fontSize: 11.5),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _CircleButton extends StatelessWidget {
  final Widget child;
  const _CircleButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        shape: BoxShape.circle,
      ),
      child: Center(child: child),
    );
  }
}


class _KhmerFlag extends StatelessWidget {
  const _KhmerFlag();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 22,
        height: 22,
        child: CustomPaint(painter: _KhmerFlagPainter()),
      ),
    );
  }
}

class _KhmerFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Three horizontal bands: blue / red / blue
    final blue = Paint()..color = const Color(0xFF032EA1);
    final red = Paint()..color = const Color(0xFFE00025);

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h / 3), blue);
    canvas.drawRect(Rect.fromLTWH(0, h / 3, w, h / 3), red);
    canvas.drawRect(Rect.fromLTWH(0, 2 * h / 3, w, h / 3), blue);

    // Simple white Angkor Wat silhouette (3 towers)
    final white = Paint()..color = Colors.white;
    final cx = w / 2;
    final baseY = h * 0.72;

    // Base rectangle
    canvas.drawRect(
      Rect.fromLTWH(cx - w * 0.3, baseY, w * 0.6, h * 0.1),
      white,
    );

    // Centre tower
    canvas.drawRect(
      Rect.fromLTWH(cx - w * 0.07, baseY - h * 0.25, w * 0.14, h * 0.25),
      white,
    );
    _drawTriangle(canvas, white, cx, baseY - h * 0.35, w * 0.09, h * 0.12);

    // Side towers
    for (final sx in [cx - w * 0.22, cx + w * 0.22 - w * 0.08]) {
      canvas.drawRect(
        Rect.fromLTWH(sx, baseY - h * 0.16, w * 0.08, h * 0.16),
        white,
      );
      _drawTriangle(
        canvas,
        white,
        sx + w * 0.04,
        baseY - h * 0.22,
        w * 0.06,
        h * 0.08,
      );
    }
  }

  void _drawTriangle(
    Canvas canvas,
    Paint paint,
    double cx,
    double tipY,
    double hw,
    double h,
  ) {
    final path = Path()
      ..moveTo(cx, tipY)
      ..lineTo(cx - hw, tipY + h)
      ..lineTo(cx + hw, tipY + h)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}


class _MenuTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final bool dark;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.dark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = dark ? const Color(0xFF0FA958) : Colors.white;
    final textColor = dark ? Colors.white : const Color(0xFF0D1F17);
    final chevronColor = dark ? Colors.white70 : const Color(0xFF8A9E93);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.battambang(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: chevronColor, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}


class _BuildingIllustration extends StatelessWidget {
  const _BuildingIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
      child: CustomPaint(painter: _TowerPainter()),
    );
  }
}

class _TowerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    const int lines = 44;

    
    final double peakX = size.width * 0.38;
    final double peakY = size.height * 0.04;

  
    final double bottomSpreadHalf = size.width * 0.46;
    final double bottomY = size.height * 0.96;

    for (int i = 0; i < lines; i++) {
      final double t = i / (lines - 1); // 0 … 1 (top → bottom)

    
      final double y = peakY + t * (bottomY - peakY);

    
      final double hw = math.pow(t, 0.72).toDouble() * bottomSpreadHalf;

      final double leftX = peakX - hw;
      final double rightX = peakX + hw;

     
      final double apexY = y - (1 - t) * 14 - t * 4; 

      final path = Path()
        ..moveTo(leftX, y)
        ..lineTo(peakX, apexY)
        ..lineTo(rightX, y);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
