import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

// ───────────────────────────────────────────────────────────────
//  Accounts Screen
// ───────────────────────────────────────────────────────────────
class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});
  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  static const _green = Color(0xFF0FA958);
  static const _lightGray = Color(0xFFF2F2F7);

  int _selectedTab = 0;
  final _tabs = ['ទាំងអស់', 'គណនីសន្សំ', 'គណនីបញ្ញើ'];

  final _accounts = [
    {
      'title': 'PREMIER ACCOUNT',
      'badge': 'គណនីគោល',
      'number': '10163840',
      'balance': '0.00 KHR',
      'hasBadge': true,
    },
    {
      'title': 'PREMIER ACCOUNT',
      'badge': '',
      'number': '10165272',
      'balance': '0.00 USD',
      'hasBadge': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightGray,
      body: Column(
        children: [
          // ── Green header
          _GreenHeader(green: _green),

          // ── Scrollable body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab bar
                  _TabBar(
                    tabs: _tabs,
                    selected: _selectedTab,
                    green: _green,
                    onTap: (i) => setState(() => _selectedTab = i),
                  ),
                  const SizedBox(height: 10),

                  // Account cards
                  ..._accounts.map(
                    (a) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _AccountCard(
                        title: a['title'] as String,
                        badge: a['badge'] as String,
                        accountNumber: a['number'] as String,
                        balance: a['balance'] as String,
                        hasBadge: a['hasBadge'] as bool,
                        green: _green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Bottom button
      bottomNavigationBar: _BottomBar(green: _green),
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
        child: Column(
          children: [
            // App bar row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
                        size: 22,
                      ),
                    ),
                  ),
                  Text(
                    'គណនី',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Summary card
            Container(
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Balances
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ទឹកប្រាក់សរុប',
                          style: GoogleFonts.battambang(
                            fontSize: 20,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _BalanceRow(
                          currency: '៛',
                          amount: '0.00',
                          color: green,
                        ),
                        const Divider(height: 20, color: Color(0xFFEEEEEE)),
                        _BalanceRow(
                          currency: '\$',
                          amount: '0.00',
                          color: green,
                        ),
                      ],
                    ),
                  ),

                  // Circle badge
                  const SizedBox(width: 16),
                  _CircleBadge(count: 2, green: green),
                ],
              ),
            ),

            const SizedBox(height: 10), // 👉 ចន្លោះ
            // White rounded bottom of the card bleeds into gray body
            Container(
              height: 16,
              margin: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  final String currency;
  final String amount;
  final Color color;
  const _BalanceRow({
    required this.currency,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              currency,
              style: GoogleFonts.battambang(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          amount,
          style: GoogleFonts.battambang(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _CircleBadge extends StatelessWidget {
  final int count;
  final Color green;
  const _CircleBadge({required this.count, required this.green});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircleArcPainter(color: green),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$count',
              style: GoogleFonts.battambang(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              'គណនី',
              style: GoogleFonts.battambang(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleArcPainter extends CustomPainter {
  final Color color;
  const _CircleArcPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);
    // Draw ~300° arc (leave a small gap at bottom-left)
    canvas.drawArc(rect, math.pi * 0.7, math.pi * 1.6, false, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _TabBar extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final Color green;
  final ValueChanged<int> onTap;
  const _TabBar({
    required this.tabs,
    required this.selected,
    required this.green,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 222, 218, 218),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = i == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    tabs[i],
                    style: GoogleFonts.battambang(
                      fontSize: 18,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                      color: active ? green : const Color(0xFF888888),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final String title;
  final String badge;
  final String accountNumber;
  final String balance;
  final bool hasBadge;
  final Color green;

  const _AccountCard({
    required this.title,
    required this.badge,
    required this.accountNumber,
    required this.balance,
    required this.hasBadge,
    required this.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Green left accent bar
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: green,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),

            // Card content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.battambang(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        if (hasBadge) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: green.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              badge,
                              style: GoogleFonts.battambang(
                                fontSize: 18,
                                color: green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        Icon(
                          Icons.more_horiz,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),
                    Text(
                      accountNumber,
                      style: GoogleFonts.battambang(
                        fontSize: 18,
                        color: Color(0xFF888888),
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 10),

                    // Balance
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        balance,
                        style: GoogleFonts.battambang(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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
    );
  }
}

class _BottomBar extends StatelessWidget {
  final Color green;
  const _BottomBar({required this.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F7),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            'បើកគណនី',
            style: GoogleFonts.battambang(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
