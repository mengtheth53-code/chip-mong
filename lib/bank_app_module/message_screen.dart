import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  final List<String> _tabs = [
    'ដំណឹងសំខាន់', // Important Notices
    'ប្រតិបត្តិការ', // Transactions
    'សេចក្តីជូនដំណឹង', // Announcements
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        title: Text(
          'សារផ្នែកដំណឹង',
          style: GoogleFonts.battambang(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _buildTabBar(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildEmptyState(), _buildEmptyState(), _buildEmptyState()],
      ),
    );
  }

  Widget _buildTabBar() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final isSelected = _selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  _tabController.animateTo(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
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
                      fontSize: 20,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? Colors.green : Colors.black,
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
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(child: _buildDocumentIcon(colorScheme)),
          ),
          const SizedBox(height: 20),
          Text(
            'គ្មានដំណឹងសំខាន់',
            style: GoogleFonts.battambang(
              fontSize: 20,
              color: const Color.fromARGB(255, 119, 117, 117),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentIcon(ColorScheme colorScheme) {
    return SizedBox(
      width: 54,
      height: 66,
      child: CustomPaint(
        painter: _DocumentIconPainter(colorScheme: colorScheme),
      ),
    );
  }
}

class _DocumentIconPainter extends CustomPainter {
  const _DocumentIconPainter({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final bodyPaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.fill;

    final foldPaint = Paint()
      ..color = colorScheme.primary.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = colorScheme.onPrimary.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.5;

    const foldSize = 14.0;

    // Main body path with folded top-right corner
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

    // Folded corner triangle
    final foldPath = Path()
      ..moveTo(size.width - foldSize, 0)
      ..lineTo(size.width, foldSize)
      ..lineTo(size.width - foldSize, foldSize)
      ..close();

    canvas.drawPath(foldPath, foldPaint);

    // Horizontal lines representing text
    final lineRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 26, size.width - 22, 5),
      const Radius.circular(3),
    );
    canvas.drawRRect(lineRRect, linePaint);

    final lineRRect2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 37, size.width - 16, 5),
      const Radius.circular(3),
    );
    canvas.drawRRect(lineRRect2, linePaint);

    final lineRRect3 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 48, size.width - 26, 5),
      const Radius.circular(3),
    );
    canvas.drawRRect(lineRRect3, linePaint);
  }

  @override
  bool shouldRepaint(covariant _DocumentIconPainter oldDelegate) {
    return oldDelegate.colorScheme != colorScheme;
  }
}
