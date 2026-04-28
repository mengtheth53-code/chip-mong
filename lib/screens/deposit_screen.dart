import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;


class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  static const _green = Color(0xFF0FA958);
  static const _bgGray = Color(0xFFF2F2F7);

  bool _isKHR = true;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: Column(
        children: [
          _GreenHeader(green: _green),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AccountSelector(green: _green),
                  const SizedBox(height: 12),
                  _AmountInput(
                    green: _green,
                    isKHR: _isKHR,
                    controller: _amountController,
                    onCurrencyToggle: (val) => setState(() => _isKHR = val),
                  ),
                  const SizedBox(height: 12),
                  _InfoBanner(),
                  const SizedBox(height: 12),
                  _NoteInput(controller: _noteController),
                ],
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}


class _GreenHeader extends StatelessWidget {
  final Color green;
  const _GreenHeader({required this.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: green,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _WatermarkPainter())),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'ដាក់ប្រាក់ដោយគ្មានប័ណ្ណ',
                          style: GoogleFonts.battambang(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF26A9D0),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.credit_card_off_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _WatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;
    final cx = size.width * 0.82;
    final topY = size.height * 0.05;
    final bottomY = size.height * 0.95;
    for (int i = 0; i < 24; i++) {
      final t = i / 23;
      final hw = math.pow(t, 0.7).toDouble() * size.width * 0.28;
      final y = topY + t * (bottomY - topY);
      final apexY = y - (1 - t) * 10 - t * 3;
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


class _AccountSelector extends StatelessWidget {
  final Color green;
  const _AccountSelector({required this.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ពីគណនី',
            style: GoogleFonts.battambang(
              fontSize: 15,
              color: const Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'PREMIER ACCOUNT ••• 3840',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: green.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'គណនីគោល',
                        style: GoogleFonts.battambang(
                          fontSize: 11,
                          color: green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade500,
                size: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _AmountInput extends StatelessWidget {
  final Color green;
  final bool isKHR;
  final TextEditingController controller;
  final ValueChanged<bool> onCurrencyToggle;

  const _AmountInput({
    required this.green,
    required this.isKHR,
    required this.controller,
    required this.onCurrencyToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── White card: label + toggle + text field
        Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label + currency toggle
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'ទឹកប្រាក់',
                      style: GoogleFonts.battambang(
                        fontSize: 15,
                        color: const Color(0xFF888888),
                      ),
                    ),
                  ),
                  Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _CurrencyChip(
                          label: 'USD',
                          active: !isKHR,
                          green: green,
                          onTap: () => onCurrencyToggle(false),
                        ),
                        _CurrencyChip(
                          label: 'KHR',
                          active: isKHR,
                          green: green,
                          onTap: () => onCurrencyToggle(true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Amount field
              TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: GoogleFonts.battambang(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),

        // ── Range hint OUTSIDE the card, on gray background
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'ចំនួនទឹកប្រាក់គួរតែចាប់ពី20,000.00 KHR ទៅ 8,000,000.00 KHR',
            style: GoogleFonts.battambang(
              fontSize: 14,
              color: const Color(0xFF999999),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}


class _CurrencyChip extends StatelessWidget {
  final String label;
  final bool active;
  final Color green;
  final VoidCallback onTap;

  const _CurrencyChip({
    required this.label,
    required this.active,
    required this.green,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? green : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: GoogleFonts.battambang(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : const Color(0xFF888888),
          ),
        ),
      ),
    );
  }
}


class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFE0A0), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFFE6A817),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'ATM ផ្ដល់តែប្រភេទក្រដាស់ប្រាក់ ២០,០០០ រ៉ៀល និង ៥០,០០០ រ៉ៀល ប៉ុណ្ណោះ:',
              style: GoogleFonts.battambang(
                fontSize: 15,
                color: const Color(0xFF8B6914),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _NoteInput extends StatelessWidget {
  final TextEditingController controller;
  const _NoteInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.notoSansKhmer(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          hintText: 'ចំណាំ ( មិនដាក់ក៏បាន )',
          hintStyle: GoogleFonts.battambang(
            fontSize: 15,
            color: const Color(0xFFBBBBBB),
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}



