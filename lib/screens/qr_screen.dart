import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────
//  QR Receive Screen
// ─────────────────────────────────────────────
class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  static const _darkGreen = Color(0xFF0A5C38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: Stack(
        children: [
          // Background building watermark
          const Positioned.fill(child: _BackgroundWatermark()),

          SafeArea(
            child: Column(
              children: [
                // ── App bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'ជីប ម៉ុង QR',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── QR Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: const _QRCard(),
                ),

                const SizedBox(height: 20),

                // ── Amount button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: _AmountButton(),
                ),

                const SizedBox(height: 12),

                // ── Account selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: _AccountSelector(),
                ),

                const Spacer(),

                // ── Bottom actions
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: _BottomActions(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Background Watermark
// ─────────────────────────────────────────────
class _BackgroundWatermark extends StatelessWidget {
  const _BackgroundWatermark();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _WatermarkPainter());
  }
}

class _WatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final cx = size.width * 0.75;
    final topY = size.height * 0.05;
    final bottomY = size.height * 0.55;

    for (int i = 0; i < 30; i++) {
      final t = i / 29;
      final hw = math.pow(t, 0.7).toDouble() * size.width * 0.35;
      final y = topY + t * (bottomY - topY);
      final apexY = y - (1 - t) * 12 - t * 3;
      final path = Path()
        ..moveTo(cx - hw, y)
        ..lineTo(cx, apexY)
        ..lineTo(cx + hw, y);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─────────────────────────────────────────────
//  QR Card  –  uses your real QR image asset
// ─────────────────────────────────────────────
class _QRCard extends StatelessWidget {
  const _QRCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Red KHQR header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFCC0000),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: const Center(child: _KHQRLogo()),
          ),

          // ── Name & amount
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'MENG THETH',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'KHR',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Dashed divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _DashedDivider(),
          ),

          // ── QR Image  ← YOUR PHOTO, no painting
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/qr_code.png', // <-- put your image here
                // If you prefer to load from the device during dev, swap with:
                // Image.file(File('/path/to/1777274033470_image.png'))
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Supporting Widgets (unchanged)
// ─────────────────────────────────────────────
class _KHQRLogo extends StatelessWidget {
  const _KHQRLogo();
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'KH QR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 1),
      painter: _DashPainter(),
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..strokeWidth = 1;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + 6, 0), paint);
      x += 10;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _AmountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add_circle_outline, color: Colors.black54, size: 20),
              SizedBox(width: 8),
              Text(
                'បញ្ចូលចំនួនទឹកប្រាក់',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 39, 24),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Text(
            'ទទួលទៅ  10163840 | KHR',
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 22),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: Icons.download_rounded,
          label: 'រក្សាទុក',
          onTap: () {},
        ),
        const SizedBox(width: 40),
        _ActionButton(
          icon: Icons.ios_share_rounded,
          label: 'ចែករំលែក',
          onTap: () {},
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
