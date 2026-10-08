import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/create_payment_template_screen.dart';

class PaymentModel extends StatefulWidget {
  const PaymentModel({super.key});

  @override
  State<PaymentModel> createState() => _PaymentModelState();
}

class _PaymentModelState extends State<PaymentModel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _tabs = [
    'ទាំងអស់',
    'ផ្ទេរ',
    'ការទូទាត់',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _selectedTab = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F4F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'គំរូទូទាត់',
          style: GoogleFonts.battambang(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── Search Input ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE5E7EB)),
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
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.battambang(
                        fontSize: 14.5,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'ស្វែងរក',
                        hintStyle: GoogleFonts.battambang(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Pill Tab Bar ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
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
                      onTap: () {
                        _tabController.animateTo(index);
                        setState(() => _selectedTab = index);
                      },
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
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF0FA958)
                                : const Color(0xFF555555),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // ── Tab Bar View (Empty States) ────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEmptyState(),
                _buildEmptyState(),
                _buildEmptyState(),
              ],
            ),
          ),
        ],
      ),

      // ── Green Plus Floating Action Button ──────────────────────────────
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 4),
        child: SizedBox(
          width: 52,
          height: 52,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CreatePaymentTemplateScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xFF0FA958),
            foregroundColor: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.add, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
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
            'អ្នកមិនទាន់មានគំរូទូទាត់ទេ',
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
