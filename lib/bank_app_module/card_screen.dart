import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';
import 'widgets/app_screen_header.dart';

class CardProduct {
  final String titleKh;
  final String descriptionKh;
  final IconData icon;
  final String? badgeLabel; // e.g. "VISA", "MC"

  const CardProduct({
    required this.titleKh,
    required this.descriptionKh,
    required this.icon,
    this.badgeLabel,
  });
}

final List<CardProduct> cardProductList = [
  CardProduct(
    titleKh: 'ប័ណ្ណឥណពន្ធ',
    descriptionKh:
        'បណ្ណឥណពន្ធ Visa​​ ធ្វើឲ្យការទិញទំនិញប្រចាំថ្ងៃរបស់អ្នកកាន់តែមានភាពងាយស្រួល និងមានសុវត្ថិភាពជាមួយនឹងការផ្ដល់ជូនពិសេសគ្មានដែនកំណត់។',

    icon: Icons.credit_card,
    badgeLabel: 'VISA',
  ),
];

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  static const _green = AppColors.primaryGreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cardProductList.length,
              itemBuilder: (context, index) =>
                  _CardProductTile(item: cardProductList[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: _green),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _HexPatternPainter())),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const AppScreenHeader(
                  title: 'ប័ណ្ណ',
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),

                const SizedBox(height: 8),

                // Icon circle
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E9E5B),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_card_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'ប័ណ្ណថ្មី',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardProductTile extends StatelessWidget {
  final CardProduct item;
  const _CardProductTile({required this.item});

  static const _green = Color(0xFF1A6B3C);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: Colors.white, size: 22),
            ),

            const SizedBox(width: 30),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row with badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.titleKh,
                          style: GoogleFonts.battambang(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (item.badgeLabel != null) ...[
                        const SizedBox(width: 8),
                        _VisaBadge(label: item.badgeLabel!),
                      ],
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    item.descriptionKh,
                    style: GoogleFonts.battambang(
                      fontSize: 23,
                      color: Color.fromARGB(255, 123, 121, 121),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisaBadge extends StatelessWidget {
  final String label;
  const _VisaBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1A1F71), width: 1.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1A1F71),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _HexPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const double r = 28;
    const double w = r * 2;
    final double h = r * 1.732;

    for (double y = -h; y < size.height + h; y += h) {
      for (double x = -w; x < size.width + w; x += w * 1.5) {
        final offset = (y ~/ h) % 2 == 0 ? 0.0 : w * 0.75;
        _drawHex(canvas, paint, Offset(x + offset, y), r);
      }
    }
  }

  void _drawHex(Canvas canvas, Paint paint, Offset center, double r) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * 3.14159 / 180;
      final px = center.dx + r * math.cos(angle);
      final py = center.dy + r * math.sin(angle);
      i == 0 ? path.moveTo(px, py) : path.lineTo(px, py);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HexPatternPainter oldDelegate) => false;
}
