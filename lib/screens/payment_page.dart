import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_payment_template_screen.dart';
import 'edc_payment_screen.dart';
import 'phone_topup_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  late final TabController _tabController;
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'បញ្ចូលលុយទូរសព្ទ',
      'subtitle': 'ប្រព័ន្ធទូរសព្ទ៖ Smart, Cellcard, Metfone',
      'icon': Icons.phone_android_rounded,
      'iconColor': Colors.white,
      'iconBg': Color(0xFF0FA958),
      'action': 'phone',
    },
    {
      'title': 'ទឹក ភ្លើង និងសំរាម',
      'subtitle': 'ទូទាត់វិក្កយបត្រទឹក ភ្លើង និងសំរាម',
      'icon': Icons.lightbulb,
      'iconColor': Colors.white,
      'iconBg': Color(0xFF78C838),
      'action': 'edc',
    },
    {
      'title': 'សេវាសាធារណៈ',
      'subtitle': 'បង់ពន្ធ ឬសេវាសាធារណៈរបស់អ្នក',
      'icon': Icons.apartment_rounded,
      'iconColor': Colors.white,
      'iconBg': Color(0xFFC59B27),
      'action': null,
    },
    {
      'title': 'ពាណិជ្ជកម្មរបស់ក្រុមហ៊ុន ជីប ម៉ុង',
      'subtitle': 'ទូទាត់វិក្កយបត្រពាណិជ្ជកម្មក្រុមហ៊ុន ជីប ម៉ុង រប...',
      'icon': Icons.account_balance,
      'iconColor': Colors.white,
      'iconBg': Color(0xFF0C8A45),
      'action': null,
    },
    {
      'title': 'សប្បុរសធម៌ និងការបរិច្ចាគ',
      'subtitle': 'បរិច្ចាគដល់អង្គការសប្បុរសធម៌',
      'icon': Icons.group,
      'iconColor': Colors.white,
      'iconBg': Color(0xFFD81B60),
      'action': null,
    },
    {
      'title': 'ធានារ៉ាប់រង',
      'subtitle': 'ទូទាត់សេវាធានារ៉ាប់រង',
      'icon': Icons.umbrella_rounded,
      'iconColor': Colors.white,
      'iconBg': Color(0xFF1E88E5),
      'action': null,
    },
    {
      'title': 'សេវាហិរញ្ញវត្ថុ',
      'subtitle': 'ការទូទាត់សងប័ណ្ណឥណទាន',
      'icon': Icons.pie_chart,
      'iconColor': Colors.white,
      'iconBg': Color(0xFF0FA958),
      'action': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _selectedTab = _tabController.index);
      }
    });
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredCategories {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _categories;
    return _categories.where((c) {
      final t = (c['title'] as String).toLowerCase();
      final s = (c['subtitle'] as String).toLowerCase();
      return t.contains(query) || s.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Green Header with Title, Tabs, and Banner ───────────────
            _buildHeader(),

            // ── Scrollable Body Area ────────────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: _selectedTab == 0
                    ? _buildPaymentsTab()
                    : _buildScheduleTab(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedTab == 1
          ? Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: _green,
                foregroundColor: Colors.white,
                elevation: 3,
                icon: const Icon(Icons.add_circle, size: 20),
                label: Text(
                  'បង្កើតថ្មី',
                  style: GoogleFonts.battambang(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            )
          : null,
    );
  }

  // ── Green Header ──────────────────────────────────────────────────────────
  Widget _buildHeader() {
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
                'ទូទាត់',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Pill Tabs: ទូទាត់ | កាលវិភាគ
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(0);
                      setState(() => _selectedTab = 0);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color:
                            _selectedTab == 0 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'ទូទាត់',
                        style: GoogleFonts.battambang(
                          fontSize: 13.5,
                          fontWeight: _selectedTab == 0
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: _selectedTab == 0 ? _green : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(1);
                      setState(() => _selectedTab = 1);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color:
                            _selectedTab == 1 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'កាលវិភាគ',
                        style: GoogleFonts.battambang(
                          fontSize: 13.5,
                          fontWeight: _selectedTab == 1
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: _selectedTab == 1 ? _green : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Top Banner (Only visible in Tab 0: ទូទាត់)
        if (_selectedTab == 0) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0FA958).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF55E795).withValues(alpha: 0.4),
                          width: 1.2,
                        ),
                      ),
                      child: const Icon(
                        Icons.bookmark_border_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'បន្ថែមគំរូទូទាត់ថ្មី',
                            style: GoogleFonts.battambang(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'បង្កើតគំរូទូទាត់របស់អ្នកឥឡូវនេះសម្រាប់ការធ្វើប្រតិបត្តិការឆាប់រហ័ស និងងាយស្រួល',
                            style: GoogleFonts.battambang(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.82),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              const CreatePaymentTemplateScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF04371B).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Text(
                        'បង្កើតគំរូទូទាត់ថ្មី',
                        style: GoogleFonts.battambang(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ] else
          const SizedBox(height: 10),
      ],
    );
  }

  // ── Tab 0: Payments List ──────────────────────────────────────────────────
  Widget _buildPaymentsTab() {
    final list = _filteredCategories;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        // Search Bar
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
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
        const SizedBox(height: 14),

        // Categories List
        ...list.map((c) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.025),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  if (c['action'] == 'phone') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PhoneTopupScreen(),
                      ),
                    );
                  } else if (c['action'] == 'edc') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const EdcPaymentScreen(
                          billerTitle: 'អគ្គិសនីកម្ពុជា',
                          billerCode: 'EDC',
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EdcPaymentScreen(
                          billerTitle: c['title'] as String,
                          billerCode: (c['title'] as String).length >= 3
                              ? (c['title'] as String).substring(0, 3)
                              : 'PAY',
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: c['iconBg'] as Color,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          c['icon'] as IconData,
                          color: c['iconColor'] as Color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['title'] as String,
                              style: GoogleFonts.battambang(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              c['subtitle'] as String,
                              style: GoogleFonts.battambang(
                                fontSize: 12,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ── Tab 1: Schedules (Empty State) ────────────────────────────────────────
  Widget _buildScheduleTab() {
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
                height: 48,
                child: CustomPaint(
                  painter: _CalendarIconPainter(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'អ្នកមិនមានកាលវិភាគទេ',
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

// ── Custom Painter for Schedule Calendar Icon ──────────────────────────────
class _CalendarIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bodyPaint = Paint()
      ..color = const Color(0xFF0FA958)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = const Color(0xFFDFF4E9)
      ..style = PaintingStyle.fill;

    // Calendar body with rounded top and corners
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 8, size.width, size.height - 8),
      const Radius.circular(8),
    );
    canvas.drawRRect(rrect, bodyPaint);

    // Top binders
    final binder1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 0, 6, 12),
      const Radius.circular(3),
    );
    canvas.drawRRect(binder1, bodyPaint);

    final binder2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width - 14, 0, 6, 12),
      const Radius.circular(3),
    );
    canvas.drawRRect(binder2, bodyPaint);

    // Grid of dots inside calendar
    const rows = 2;
    const cols = 4;
    const startX = 8.0;
    const startY = 22.0;
    final spacingX = (size.width - 16) / (cols - 1);
    const spacingY = 10.0;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        canvas.drawCircle(
          Offset(startX + c * spacingX, startY + r * spacingY),
          2.5,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
