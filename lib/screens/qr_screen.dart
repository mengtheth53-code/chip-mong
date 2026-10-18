import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  static const Color _darkGreen = Color(0xFF084F2B);
  static const Color _red = Color(0xFFE52329);

  // Selected account: 0 for KHR (10163840), 1 for USD (10165272)
  int _selectedAccountIndex = 0;
  String _enteredAmount = '';
  String _amountCurrency = 'KHR';

  void _showAccountPickerSheet(int accountIndex) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final isKhr = accountIndex == 0;
        final title = isKhr ? 'PREMIER ACCOUNT' : 'PREMIER ACCOUNT';
        final badge = isKhr ? 'គណនីគោល' : null;
        final number = isKhr ? '10163840' : '10165272';
        final balance = isKhr ? '94.24 KHR' : '0.00 USD';

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'ជ្រើសរើសគណនីទទួល',
                style: GoogleFonts.battambang(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAccountIndex = accountIndex;
                    _amountCurrency = isKhr ? 'KHR' : 'USD';
                  });
                  Navigator.pop(ctx);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 54,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0FA958),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (badge != null) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD6F0E0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      badge,
                                      style: GoogleFonts.battambang(
                                        fontSize: 11,
                                        color: const Color(0xFF0C6B38),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$number | $balance',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.radio_button_checked_rounded,
                          color: Color(0xFF0FA958),
                          size: 24,
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
    );
  }

  void _showSetAmountSheet() {
    String currentInput = _enteredAmount;
    String currentCurr = _amountCurrency;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'បញ្ចូលចំនួនទឹកប្រាក់',
                      style: GoogleFonts.battambang(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // KHR / USD switcher
                  Container(
                    height: 38,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setModalState(() => currentCurr = 'KHR'),
                            child: Container(
                              decoration: BoxDecoration(
                                color: currentCurr == 'KHR'
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Text(
                                  'KHR',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: currentCurr == 'KHR'
                                        ? const Color(0xFF0FA958)
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setModalState(() => currentCurr = 'USD'),
                            child: Container(
                              decoration: BoxDecoration(
                                color: currentCurr == 'USD'
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Text(
                                  'USD',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: currentCurr == 'USD'
                                        ? const Color(0xFF0FA958)
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Display entered amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentInput.isEmpty ? '0' : currentInput,
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 36,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        color: const Color(0xFF0FA958),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0FA958),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentCurr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Numeric Keypad
                  _buildKeypad(
                    onDigit: (digit) {
                      setModalState(() {
                        if (currentInput.length < 9) {
                          currentInput += digit;
                        }
                      });
                    },
                    onClear: () {
                      setModalState(() => currentInput = '');
                    },
                    onBackspace: () {
                      setModalState(() {
                        if (currentInput.isNotEmpty) {
                          currentInput = currentInput.substring(
                            0,
                            currentInput.length - 1,
                          );
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: currentInput.isNotEmpty
                          ? () {
                              setState(() {
                                _enteredAmount = currentInput;
                                _amountCurrency = currentCurr;
                              });
                              Navigator.pop(ctx);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0FA958),
                        disabledBackgroundColor: const Color(0xFFE2E8F0),
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Text(
                        'បញ្ជាក់',
                        style: GoogleFonts.battambang(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildKeypad({
    required ValueChanged<String> onDigit,
    required VoidCallback onClear,
    required VoidCallback onBackspace,
  }) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['C', '0', '⌫'],
    ];

    return Table(
      children: keys.map((row) {
        return TableRow(
          children: row.map((key) {
            return InkWell(
              onTap: () {
                if (key == 'C') {
                  onClear();
                } else if (key == '⌫') {
                  onBackspace();
                } else {
                  onDigit(key);
                }
              },
              child: SizedBox(
                height: 52,
                child: Center(
                  child: key == '⌫'
                      ? const Icon(
                          Icons.backspace_outlined,
                          size: 22,
                          color: Colors.black87,
                        )
                      : Text(
                          key,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: key == 'C'
                                ? Colors.grey.shade700
                                : Colors.black87,
                          ),
                        ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  void _showShareDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Image.asset('assets/images/qr_code.png'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Image',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'PNG Image • 92 KB',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildShareIcon(Icons.send_rounded, 'Telegram', Colors.blue),
                  _buildShareIcon(
                      Icons.camera_alt_outlined, 'Scanner', Colors.teal),
                  _buildShareIcon(Icons.copy_rounded, 'Copy', Colors.grey),
                  _buildShareIcon(
                      Icons.file_download_outlined, 'Save', Colors.indigo),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: Stack(
        children: [
          const Positioned.fill(child: _BackgroundWatermark()),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top App Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
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
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Top Account Selector Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildAccountPill(
                            index: 0,
                            iconText: '៛',
                            label: 'I...',
                            badge: 'គណនីគោល',
                            number: '10163840',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildAccountPill(
                            index: 1,
                            iconText: '\$',
                            label: 'PREMIER ACC...',
                            badge: null,
                            number: '10165272',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // KHQR Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildKhqrCard(),
                  ),
                  const SizedBox(height: 16),

                  // Enter Amount Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: _showSetAmountSheet,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Color(0xFF0FA958),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _enteredAmount.isEmpty
                                  ? 'បញ្ចូលចំនួនទឹកប្រាក់'
                                  : 'ទឹកប្រាក់: $_enteredAmount $_amountCurrency',
                              style: GoogleFonts.battambang(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Action Buttons
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBottomAction(
                          icon: Icons.file_download_outlined,
                          label: 'ទាញយក',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('បានរក្សាទុកក្នុងវិចិត្រសាល'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 48),
                        _buildBottomAction(
                          icon: Icons.upload_rounded,
                          label: 'ចែករំលែក',
                          onTap: _showShareDialog,
                        ),
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

  Widget _buildAccountPill({
    required int index,
    required String iconText,
    required String label,
    required String? badge,
    required String number,
  }) {
    final isSelected = _selectedAccountIndex == index;
    return GestureDetector(
      onTap: () => _showAccountPickerSheet(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF70B896).withValues(alpha: 0.9)
              : const Color(0xFF5E9C7E).withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(14),
          border: isSelected
              ? Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF0FA958),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  iconText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6F0E0).withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badge,
                            style: GoogleFonts.battambang(
                              fontSize: 9,
                              color: const Color(0xFF0C6B38),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKhqrCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Red KHQR Header with Dog-Ear Notch
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  color: _red,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: const Center(
                  child: Text(
                    'KHQR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CustomPaint(
                  size: const Size(18, 18),
                  painter: _DogEarPainter(),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MENG THETH',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
                if (_enteredAmount.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '$_enteredAmount $_amountCurrency',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0FA958),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                _buildDashedLine(),
                const SizedBox(height: 14),

                // Center QR Image with Chip Mong logo badge
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        padding: const EdgeInsets.all(4),
                        child: Image.asset(
                          'assets/images/qr_code.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.stars_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFCBD5E1)),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildBottomAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DogEarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

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
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final cx = size.width * 0.75;
    final topY = size.height * 0.05;
    final bottomY = size.height * 0.65;

    for (int i = 0; i < 30; i++) {
      final t = i / 29;
      final hw = math.pow(t, 0.7).toDouble() * size.width * 0.4;
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
