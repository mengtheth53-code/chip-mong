import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  bool _isFlashOn = false;
  double _zoomLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            // ── Top Header ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
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
                    'ស្កេន',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ── Camera Viewfinder Container ──────────────────────────────
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Scanner Frame with 4 rounded white corner brackets
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: CustomPaint(
                          painter: _ScannerBracketPainter(),
                        ),
                      ),
                    ),

                    // Zoom Pill Control
                    Positioned(
                      bottom: 78,
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF262626).withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_zoomLevel > 1.0) _zoomLevel -= 0.5;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.zoom_out,
                                  color: _zoomLevel > 1.0
                                      ? const Color(0xFFFBBF24)
                                      : Colors.white70,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_zoomLevel < 3.0) _zoomLevel += 0.5;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.zoom_in,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Control Toolbar: ពិល | បើក QR | QR ថ្មីៗ
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            // ពិល (Flashlight)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => _isFlashOn = !_isFlashOn);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _isFlashOn
                                          ? Icons.flashlight_on
                                          : Icons.flashlight_on_outlined,
                                      color: _isFlashOn
                                          ? const Color(0xFFFBBF24)
                                          : Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'ពិល',
                                      style: GoogleFonts.battambang(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.white24,
                            ),
                            // បើក QR (Upload from gallery)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'សូមជ្រើសរើសរូបភាព QR ពីវិចិត្រសាល',
                                        style: GoogleFonts.battambang(),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'បើក QR',
                                      style: GoogleFonts.battambang(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.white24,
                            ),
                            // QR ថ្មីៗ (Recent Scans)
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _showRecentScansModal(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.grid_view_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'QR ថ្មីៗ',
                                      style: GoogleFonts.battambang(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Partner Badges Row: Chip Mong, KHQR, VietQR, LAPNet ───────
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPartnerBadge(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0FA958),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.account_balance,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildPartnerBadge(
                    bgColor: const Color(0xFFE52329),
                    child: const Text(
                      'KHQR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildPartnerBadge(
                    bgColor: Colors.white,
                    child: const Text(
                      'VIETQR',
                      style: TextStyle(
                        color: Color(0xFF005BAA),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildPartnerBadge(
                    bgColor: const Color(0xFF003A70),
                    child: const Text(
                      'LAPNet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7.5,
                        fontWeight: FontWeight.w900,
                      ),
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

  Widget _buildPartnerBadge({required Widget child, Color? bgColor}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  // ── Modal Bottom Sheet: ការស្កេនថ្មីៗ ────────────────────────────────────
  void _showRecentScansModal(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'THETH MENG',
        'subtitle': '014951053 | KHR',
        'isBakong': true,
      },
      {
        'title': 'CHILDREN SURGICAL CENTRE4',
        'subtitle': null,
        'isBakong': false,
      },
      {
        'title': 'OUN SREYYOU',
        'subtitle': null,
        'isBakong': false,
      },
      {
        'title': 'Meng Theth',
        'subtitle': null,
        'isBakong': false,
      },
      {
        'title': 'BUN PHANIT',
        'subtitle': null,
        'isBakong': false,
      },
      {
        'title': 'CHHAN SREYNICH',
        'subtitle': null,
        'isBakong': false,
      },
      {
        'title': 'CHHAN SREYNICH',
        'subtitle': null,
        'isBakong': false,
      },
      {
        'title': 'OENG KIMHEAK',
        'subtitle': null,
        'isBakong': false,
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, scrollController) {
            return Column(
              children: [
                // Modal Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                  child: Row(
                    children: [
                      Text(
                        'ការស្កេនថ្មីៗ',
                        style: GoogleFonts.battambang(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFF9E9E9E),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ស្វែងរក',
                          style: GoogleFonts.battambang(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // List of Recent Scans
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isBakong = item['isBakong'] as bool;

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF3F4F6)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Left Icon
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE52329),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: isBakong
                                  ? const Icon(
                                      Icons.brightness_7,
                                      color: Colors.white,
                                      size: 26,
                                    )
                                  : const Text(
                                      'KHQR',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  if (item['subtitle'] != null) ...[
                                    const SizedBox(height: 3),
                                    Text(
                                      item['subtitle'] as String,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF757575),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.more_horiz,
                                  color: Color(0xFF6B7280),
                                  size: 20,
                                ),
                                SizedBox(height: 6),
                                Icon(
                                  Icons.push_pin_outlined,
                                  color: Color(0xFFD1D5DB),
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// ── Custom Painter for Scanner 4 Corner Brackets ────────────────────────────
class _ScannerBracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const cornerLength = 48.0;
    const cornerRadius = 24.0;

    // Top-Left Corner
    final tlPath = Path()
      ..moveTo(0, cornerLength)
      ..lineTo(0, cornerRadius)
      ..quadraticBezierTo(0, 0, cornerRadius, 0)
      ..lineTo(cornerLength, 0);
    canvas.drawPath(tlPath, paint);

    // Top-Right Corner
    final trPath = Path()
      ..moveTo(size.width - cornerLength, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, cornerRadius)
      ..lineTo(size.width, cornerLength);
    canvas.drawPath(trPath, paint);

    // Bottom-Left Corner
    final blPath = Path()
      ..moveTo(0, size.height - cornerLength)
      ..lineTo(0, size.height - cornerRadius)
      ..quadraticBezierTo(0, size.height, cornerRadius, size.height)
      ..lineTo(cornerLength, size.height);
    canvas.drawPath(blPath, paint);

    // Bottom-Right Corner
    final brPath = Path()
      ..moveTo(size.width - cornerLength, size.height)
      ..lineTo(size.width - cornerRadius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - cornerRadius)
      ..lineTo(size.width, size.height - cornerLength);
    canvas.drawPath(brPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
