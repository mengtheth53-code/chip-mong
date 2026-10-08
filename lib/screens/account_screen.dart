import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

import 'account_history_screen.dart';
import 'open_account_screen.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  static const Color _green = Color(0xFF0FA958);
  static const Color _darkHeaderGreen = Color(0xFF085329);
  static const Color _bgGray = Color(0xFFF2F4F7);

  int _selectedTab = 0;
  bool _hideBalance = false;

  final List<String> _tabs = ['ទាំងអស់', 'គណនីសន្សំ', 'គណនីបញ្ញើ'];

  final List<Map<String, dynamic>> _accounts = [
    {
      'title': 'PREMIER ACCOUNT',
      'badge': 'គណនីគោល',
      'number': '10163840',
      'balance': '94.24 KHR',
      'hasBadge': true,
      'isKHR': true,
    },
    {
      'title': 'PREMIER ACCOUNT',
      'badge': '',
      'number': '10165272',
      'balance': '0.00 USD',
      'hasBadge': false,
      'isKHR': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkHeaderGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Green Header with Summary Card ─────────────────────────────
            _buildTopHeader(),

            // ── Scrollable Body Area ───────────────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    // Pill Tab Bar
                    _buildPillTabBar(),
                    const SizedBox(height: 10),

                    // Tab Content
                    Expanded(
                      child: _selectedTab == 2
                          ? _buildTermDepositEmptyState()
                          : _buildAccountList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // ── Fixed Bottom Button: បើកគណនី ─────────────────────────────────────
      bottomNavigationBar: Container(
        color: _bgGray,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const OpenAccountScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'បើកគណនី',
              style: GoogleFonts.battambang(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Top Header Widget ────────────────────────────────────────────────────
  Widget _buildTopHeader() {
    return Column(
      children: [
        // App Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              Text(
                'គណនី',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Summary Card with Hide Balance Switch & Donut Ring
        Container(
          margin: const EdgeInsets.fromLTRB(16, 6, 16, 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF053B1D).withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              // Hide Balance Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'លាក់ទឹកប្រាក់',
                    style: GoogleFonts.battambang(
                      fontSize: 12.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: _hideBalance,
                      activeTrackColor: _green,
                      onChanged: (val) {
                        setState(() => _hideBalance = val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // White Card with Donut Chart and Currencies
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Donut Chart
                    SizedBox(
                      width: 78,
                      height: 78,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(78, 78),
                            painter: _DonutRingPainter(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.1,
                                ),
                              ),
                              Text(
                                'គណនី',
                                style: GoogleFonts.battambang(
                                  fontSize: 11,
                                  color: const Color(0xFF757575),
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Currencies (KHR and USD)
                    Expanded(
                      child: Column(
                        children: [
                          // KHR Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _hideBalance ? '••••••' : '94.24',
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFF4E9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '៛',
                                  style: GoogleFonts.battambang(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                              height: 1,
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          // USD Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _hideBalance ? '••••••' : '0.00',
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFF4E9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '\$',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Pill Tab Bar ─────────────────────────────────────────────────────────
  Widget _buildPillTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  _tabs[index],
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? _green : const Color(0xFF555555),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Tab 1 & Tab 2: Account List ──────────────────────────────────────────
  Widget _buildAccountList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _accounts.length,
      itemBuilder: (context, index) {
        final a = _accounts[index];
        final balanceText = _hideBalance
            ? (a['isKHR'] ? '•••••• KHR' : '•••••• USD')
            : (a['balance'] as String);

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AccountHistoryScreen(
                  accountNumber: a['number'] as String,
                  accountName: a['title'] as String,
                  balance: a['balance'] as String,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  // Green Accent Bar on the left
                  Container(
                    width: 4,
                    height: 90,
                    color: _green,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                a['title'] as String,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              if (a['hasBadge'] as bool) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDFF4E9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    a['badge'] as String,
                                    style: GoogleFonts.battambang(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: _green,
                                    ),
                                  ),
                                ),
                              ],
                              const Spacer(),
                              const Icon(
                                Icons.more_horiz,
                                color: Colors.black54,
                                size: 22,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            a['number'] as String,
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: const Color(0xFF757575),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                              height: 1,
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              balanceText,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
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
        );
      },
    );
  }

  // ── Tab 3: Empty State for Term Deposit (គណនីបញ្ញើ) ─────────────────────────
  Widget _buildTermDepositEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              color: const Color(0xFFDFF4E9),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: SizedBox(
                width: 44,
                height: 52,
                child: CustomPaint(
                  painter: _DocumentIconPainter(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'មិនទាន់មានគណនី',
            style: GoogleFonts.battambang(
              fontSize: 15,
              color: const Color(0xFF8E8E93),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

// ── Custom Donut Ring Painter ───────────────────────────────────────────────
class _DonutRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 10) / 2;

    final bgPaint = Paint()
      ..color = const Color(0xFFDFF4E9)
      ..strokeWidth = 6.5
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = const Color(0xFF0FA958)
      ..strokeWidth = 6.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Background circle
    canvas.drawCircle(center, radius, bgPaint);

    // Active arc (showing ~80% ring)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 1.7,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Custom Folded Document Painter ──────────────────────────────────────────
class _DocumentIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bodyPaint = Paint()
      ..color = const Color(0xFF0FA958)
      ..style = PaintingStyle.fill;

    final foldPaint = Paint()
      ..color = const Color(0xFF0C8E48)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = const Color(0xFF086A34)
      ..style = PaintingStyle.fill;

    const foldSize = 12.0;

    final bodyPath = Path()
      ..moveTo(0, 4)
      ..quadraticBezierTo(0, 0, 4, 0)
      ..lineTo(size.width - foldSize, 0)
      ..lineTo(size.width, foldSize)
      ..lineTo(size.width, size.height - 4)
      ..quadraticBezierTo(size.width, size.height, size.width - 4, size.height)
      ..lineTo(4, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 4)
      ..close();

    canvas.drawPath(bodyPath, bodyPaint);

    final foldPath = Path()
      ..moveTo(size.width - foldSize, 0)
      ..lineTo(size.width, foldSize)
      ..lineTo(size.width - foldSize, foldSize)
      ..close();

    canvas.drawPath(foldPath, foldPaint);

    final line1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 20, size.width - 16, 3),
      const Radius.circular(2),
    );
    canvas.drawRRect(line1, linePaint);

    final line2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 28, size.width - 16, 3),
      const Radius.circular(2),
    );
    canvas.drawRRect(line2, linePaint);

    final line3 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 36, size.width - 24, 3),
      const Radius.circular(2),
    );
    canvas.drawRRect(line3, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
