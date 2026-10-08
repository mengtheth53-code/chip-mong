import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipMongMapScreen extends StatefulWidget {
  const ChipMongMapScreen({super.key});

  @override
  State<ChipMongMapScreen> createState() => _ChipMongMapScreenState();
}

class _ChipMongMapScreenState extends State<ChipMongMapScreen> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      body: Stack(
        children: [
          // ── Satellite Map Background View ───────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.52,
            child: _buildSatelliteMap(),
          ),

          // ── Top Search & Control Bar ────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    // Search Bar
                    Expanded(
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Chip Mong Tower',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F2937),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFF4B5563),
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Layers button
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.layers_rounded,
                        color: Color(0xFF374151),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Street View 360 Thumbnail ───────────────────────────
          Positioned(
            top: size.height * 0.36,
            left: 16,
            child: Container(
              width: 80,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF5A7B8E), Color(0xFF243B55)],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.traffic_rounded,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 28,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBBF24),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.sync_rounded,
                        color: Colors.black87,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom Sheet with Location Info & Photos ────────────
          Positioned(
            top: size.height * 0.44,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 8),
                      width: 40,
                      height: 4.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  // Scrollable Content
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildHeaderRow(),
                        const SizedBox(height: 6),
                        _buildRatingRow(),
                        const SizedBox(height: 4),
                        _buildCategoryRow(),
                        const SizedBox(height: 14),
                        _buildActionButtonsRow(),
                        const SizedBox(height: 14),
                        _buildTipCard(),
                        const SizedBox(height: 16),
                        _buildPhotosSection(),
                        const SizedBox(height: 24),
                      ],
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

  // ── Header Row (Title & Top-Right Buttons) ─────────────────
  Widget _buildHeaderRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chip Mong Tower',
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'អាគារជីប ម៉ុង',
                style: GoogleFonts.battambang(
                  fontSize: 15,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRoundIconButton(
              icon: _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: _isSaved ? const Color(0xFF007A87) : const Color(0xFF4B5563),
              onTap: () {
                setState(() => _isSaved = !_isSaved);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isSaved ? 'បានរក្សាទុក Chip Mong Tower' : 'បានលុបការរក្សាទុក',
                      style: GoogleFonts.battambang(),
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            _buildRoundIconButton(
              icon: Icons.ios_share_rounded,
              color: const Color(0xFF4B5563),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'ចែករំលែកទីតាំង Chip Mong Tower',
                      style: GoogleFonts.battambang(),
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            _buildRoundIconButton(
              icon: Icons.close_rounded,
              color: const Color(0xFF4B5563),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoundIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xFFF3F4F6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  // ── Rating & Duration Row ─────────────────────────────────
  Widget _buildRatingRow() {
    return Row(
      children: [
        const Text(
          '4.5',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(width: 4),
        Row(
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star_rounded,
              color: Color(0xFFF59E0B),
              size: 16,
            ),
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          '(178)',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          '·',
          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.two_wheeler_rounded, size: 16, color: Color(0xFF374151)),
        const SizedBox(width: 4),
        const Text(
          '8 min',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  // ── Category Row ──────────────────────────────────────────
  Widget _buildCategoryRow() {
    return Row(
      children: const [
        Text(
          'Shopping mall',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFF4B5563),
          ),
        ),
        SizedBox(width: 6),
        Text('·', style: TextStyle(color: Color(0xFF6B7280))),
        SizedBox(width: 6),
        Icon(
          Icons.accessible_rounded,
          size: 16,
          color: Color(0xFF1D4ED8),
        ),
      ],
    );
  }

  // ── Action Buttons Row ────────────────────────────────────
  Widget _buildActionButtonsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Directions
          _buildPillButton(
            label: 'Directions',
            icon: Icons.directions_rounded,
            isFilled: true,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'កំពុងគណនាផ្លូវទៅកាន់ Chip Mong Tower (8 នាទី)',
                    style: GoogleFonts.battambang(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          // Start
          _buildPillButton(
            label: 'Start',
            icon: Icons.navigation_rounded,
            isFilled: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'ចាប់ផ្តើមការធ្វើដំណើរ...',
                    style: GoogleFonts.battambang(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          // Ask
          _buildPillButton(
            label: 'Ask',
            icon: Icons.auto_awesome_rounded,
            isFilled: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'សួរព័ត៌មានអំពី Chip Mong Tower',
                    style: GoogleFonts.battambang(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          // Call
          _buildPillButton(
            label: 'Call',
            icon: Icons.call_rounded,
            isFilled: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'កំពុងទូរស័ព្ទទៅកាន់ Chip Mong Tower...',
                    style: GoogleFonts.battambang(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton({
    required String label,
    required IconData icon,
    required bool isFilled,
    required VoidCallback onTap,
  }) {
    final bgColor = isFilled ? const Color(0xFF007A87) : const Color(0xFFDFF2F5);
    final fgColor = isFilled ? Colors.white : const Color(0xFF007A87);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: fgColor, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: fgColor,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── "Know Before You Go" Card ─────────────────────────────
  Widget _buildTipCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F1FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.push_pin_rounded,
            color: Color(0xFF4F46E5),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: const Color(0xFF312E81),
                  height: 1.4,
                ),
                children: const [
                  TextSpan(
                    text: 'Know before you go: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Head up to the 44th floor for rooftop drinks and city sunset views',
                  ),
                ],
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF6366F1),
            size: 20,
          ),
        ],
      ),
    );
  }

  // ── Photos Section ────────────────────────────────────────
  Widget _buildPhotosSection() {
    return SizedBox(
      height: 220,
      child: Row(
        children: [
          // Photo 1: Interior Atrium
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFC79267),
                      Color(0xFF8B5E3C),
                      Color(0xFF2C241E),
                    ],
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Architectural lines & ceiling details
                    CustomPaint(
                      painter: _InteriorAtriumPainter(),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Chip Mong Tower Atrium',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Photo 2: Khmer Cultural Performance
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2563EB),
                      Color(0xFF1E3A8A),
                      Color(0xFF0F172A),
                    ],
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Angkor Wat & Golden Dancers
                    CustomPaint(
                      painter: _ApsaraPerformancePainter(),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Cultural Events',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Satellite Map Painter ─────────────────────────────────
  Widget _buildSatelliteMap() {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _SatelliteMapPainter(),
          ),
        ),
        // Red Pin & Marker Bubble
        Positioned(
          top: 135,
          left: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFEF4444),
                    size: 34,
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Chip Mong Tower',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          'Recently viewed',
                          style: TextStyle(
                            color: Color(0xFFD1D5DB),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Satellite Map Custom Painter ──────────────────────────
class _SatelliteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dark aerial terrain base
    final basePaint = Paint()..color = const Color(0xFF2E3B33);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), basePaint);

    // Urban building blocks
    final blockPaint = Paint()..color = const Color(0xFF3D4A41);
    canvas.drawRect(Rect.fromLTWH(10, 10, size.width * 0.45, 90), blockPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.55, 10, size.width * 0.4, 90), blockPaint);

    // Large Chip Mong Tower complex footprint
    final towerRoofPaint = Paint()..color = const Color(0xFF1E2822);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.42, 60, 90, 75), towerRoofPaint);

    // Tree canopy textures
    final treePaint = Paint()..color = const Color(0xFF233B26);
    canvas.drawCircle(Offset(size.width * 0.85, 90), 28, treePaint);
    canvas.drawCircle(Offset(size.width * 0.2, 120), 20, treePaint);

    // 2. Russian Blvd Highway (Golden/Yellow road)
    final roadPaint = Paint()
      ..color = const Color(0xFFE5B55E)
      ..strokeWidth = 24
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(-20, 155);
    path.lineTo(size.width + 20, 145);
    canvas.drawPath(path, roadPaint);

    // Highway divider
    final dividerPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(-20, 155), Offset(size.width + 20, 145), dividerPaint);

    // 3. Side streets
    final sideStreetPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // St 233
    canvas.drawLine(Offset(size.width * 0.35, 155), Offset(size.width * 0.35, size.height), sideStreetPaint);
    // St 112
    canvas.drawLine(Offset(size.width * 0.72, 148), Offset(size.width * 0.72, size.height), sideStreetPaint);
    // St 118
    canvas.drawLine(Offset(size.width * 0.15, 157), Offset(size.width * 0.15, size.height), sideStreetPaint);

    // 4. Street & POI Labels
    _drawLabel(canvas, 'Sky Bridge', const Offset(12, 162), Colors.black87, 10);
    _drawLabel(canvas, 'St 233', Offset(size.width * 0.36, 210), const Color(0xFF475569), 9);
    _drawLabel(canvas, 'St 112', Offset(size.width * 0.73, 185), const Color(0xFF475569), 9);
    _drawLabel(canvas, 'Dumpling Home', Offset(size.width * 0.65, 230), Colors.white, 10);
    _drawLabel(canvas, 'ATHENA BEAUTY', Offset(size.width * 0.42, 195), Colors.white, 10);
  }

  void _drawLabel(Canvas canvas, String text, Offset offset, Color color, double fontSize) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 2,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Atrium Photo Custom Painter ───────────────────────────
class _InteriorAtriumPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Wood ceiling slats
    final slatPaint = Paint()
      ..color = const Color(0xFFA67148)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (double y = 15; y < size.height * 0.55; y += 12) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 20), slatPaint);
    }

    // Glass globes / pendant lights
    final lightPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    final glowPaint = Paint()..color = const Color(0xFFFFECC8).withValues(alpha: 0.4);

    final lightPoints = [
      Offset(size.width * 0.25, size.height * 0.65),
      Offset(size.width * 0.45, size.height * 0.72),
      Offset(size.width * 0.7, size.height * 0.68),
      Offset(size.width * 0.85, size.height * 0.75),
    ];

    for (final pt in lightPoints) {
      canvas.drawCircle(pt, 10, glowPaint);
      canvas.drawCircle(pt, 5, lightPaint);
      canvas.drawLine(
        Offset(pt.dx, pt.dy - 35),
        pt,
        Paint()
          ..color = Colors.white54
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Apsara Performance Custom Painter ─────────────────────
class _ApsaraPerformancePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Temple Towers silhouette
    final templePaint = Paint()..color = const Color(0xFF38271D);
    final path = Path();
    // Central tower
    path.moveTo(size.width * 0.35, size.height * 0.45);
    path.lineTo(size.width * 0.5, size.height * 0.15);
    path.lineTo(size.width * 0.65, size.height * 0.45);
    // Left tower
    path.moveTo(size.width * 0.15, size.height * 0.45);
    path.lineTo(size.width * 0.28, size.height * 0.24);
    path.lineTo(size.width * 0.4, size.height * 0.45);
    // Right tower
    path.moveTo(size.width * 0.6, size.height * 0.45);
    path.lineTo(size.width * 0.72, size.height * 0.24);
    path.lineTo(size.width * 0.85, size.height * 0.45);
    canvas.drawPath(path, templePaint);

    // Golden Apsara dancers silhouettes
    final goldPaint = Paint()..color = const Color(0xFFEAB308);
    // 3 dancers
    for (double dx in [size.width * 0.28, size.width * 0.5, size.width * 0.72]) {
      // Crown (Mokot)
      final crownPath = Path();
      crownPath.moveTo(dx - 6, size.height * 0.6);
      crownPath.lineTo(dx, size.height * 0.52);
      crownPath.lineTo(dx + 6, size.height * 0.6);
      canvas.drawPath(crownPath, goldPaint);

      // Body / silk attire
      canvas.drawCircle(Offset(dx, size.height * 0.63), 6, goldPaint);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(dx - 8, size.height * 0.68, 16, 26),
          const Radius.circular(4),
        ),
        goldPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
