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
    'ដំណឹងសំខាន់',
    'ប្រតិបត្តិការ',
    'សេចក្តីជូនដំណឹង',
  ];

  final List<Map<String, String>> _transactions = [
    {
      'title': 'Paid to THETH MENG',
      'date': 'Aug 05, 2026 | 02:55 PM',
      'desc': '1,200.00 KHR is paid from account 10163840',
    },
    {
      'title': 'Paid to THETH MENG',
      'date': 'Aug 05, 2026 | 02:55 PM',
      'desc': '0.95 USD is paid from account 10165272',
    },
    {
      'title': 'Paid to THETH MENG',
      'date': 'Aug 05, 2026 | 01:48 PM',
      'desc': '5.00 USD is paid from account 10165272',
    },
    {
      'title': 'Paid to OUN SREYYOU',
      'date': 'Aug 05, 2026 | 10:39 AM',
      'desc': '0.75 USD is paid from account 10165272',
    },
    {
      'title': 'Paid to Meng Theth',
      'date': 'Aug 05, 2026 | 09:01 AM',
      'desc': '1,000.00 KHR is paid from account 10163840',
    },
  ];

  final List<Map<String, dynamic>> _announcements = [
    {
      'title': 'សេចក្តីជូនដំណឹង',
      'date': 'Sep 03, 2026 | 09:35 AM',
      'snippet': 'ធនាគារ ជីប ម៉ុង ខមមើសលប៊ែង ម.ក មានកិត្តិយសសូមគោរ...',
      'full':
          'ធនាគារ ជីប ម៉ុង ខមមើសលប៊ែង ម.ក មានកិត្តិយសសូមគោរពជូនដំណឹងដល់អតិថិជន និងសាធារណៈជនទាំងអស់មេត្តាជ្រាបថា ធនាគារ ជីប ម៉ុង នឹងរៀបចំធ្វើបច្ចុប្បន្នភាព ប្រព័ន្ធ ដើម្បីបង្កើនស្ថិរភាព សុវត្ថិភាព និងប្រសិទ្ធភាពនៃប្រព័ន្ធសេវា ធនាគារ។',
      'iconType': 'bell',
    },
    {
      'title': 'សេចក្តីជូនដំណឹងអំពីការធ្វើកែលម្អប្រព័ន្ធបាតគង',
      'date': 'Jun 16, 2026 | 06:30 PM',
      'snippet': 'អតិថិជនជាទីគោរព! ...',
      'full':
          'អតិថិជនជាទីគោរព! ធនាគារ ជីប ម៉ុង សូមជូនដំណឹងអំពីការធ្វើកែលម្អ និងថែទាំប្រព័ន្ធបច្ចេកវិទ្យា (Bakong) ដើម្បីបង្កើនប្រសិទ្ធភាពសេវាកម្ម។ ក្នុងអំឡុងពេលនេះ ប្រតិបត្តិការផ្ទេរប្រាក់ឆ្លងធនាគារតាមប្រព័ន្ធបាគងអាចមានការរអាក់រអួលជាបណ្តោះអាសន្ន។ សូមអភ័យទោសចំពោះការរំខាននេះ។',
      'iconType': 'gear',
    },
    {
      'title': 'បច្ចុប្បន្នភាពសេវាអតិថិជន',
      'date': 'Dec 02, 2025 | 09:23 AM',
      'snippet': 'អតិថិជនជាទីគោរព!...',
      'full':
          'អតិថិជនជាទីគោរព! ធនាគារ ជីប ម៉ុង សូមជម្រាបជូនអំពីការធ្វើបច្ចុប្បន្នភាពលើប្រព័ន្ធសេវាបម្រើអតិថិជន ២៤/៧។ លោកអ្នកអាចទាក់ទងមកកាន់យើងខ្ញុំគ្រប់ពេលវេលាតាមរយៈលេខទូរសព្ទ 081 / 066 811 911 ឬតាមរយៈសារអេឡិចត្រូនិច។',
      'iconType': 'bell',
    },
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F9),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'សារជូនដំណឹង',
          style: GoogleFonts.battambang(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _buildTabBar(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildImportantEmptyState(),
          _buildTransactionsTab(),
          _buildAnnouncementsTab(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFFF6F8F9),
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
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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
    );
  }

  // ── Tab 1: Important Notices (Empty State) ─────────────────────────────────
  Widget _buildImportantEmptyState() {
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
            'គ្មានដំណឹងសំខាន់',
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

  // ── Tab 2: Transactions ───────────────────────────────────────────────────
  Widget _buildTransactionsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final item = _transactions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEFF1F3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0FA958),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '\$',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['date']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                item['desc']!,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Tab 3: Announcements ──────────────────────────────────────────────────
  Widget _buildAnnouncementsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _announcements.length,
      itemBuilder: (context, index) {
        final item = _announcements[index];
        final isGear = item['iconType'] == 'gear';

        return GestureDetector(
          onTap: () => _showAnnouncementDetail(context, item),
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEFF1F3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Graphic Banner
                Container(
                  height: 105,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0D5733), Color(0xFF063B20)],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Chip Mong Bank logo
                      Positioned(
                        top: 12,
                        left: isGear ? null : 14,
                        right: isGear ? 14 : null,
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Image.asset(
                                'assets/images/chip_mong_logo.png',
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.account_balance,
                                  color: Color(0xFF0D5733),
                                  size: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'CHIP MONG\nBANK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Center 3D Icon
                      isGear
                          ? const Icon(
                              Icons.build_circle,
                              color: Color(0xFFC7D3CD),
                              size: 46,
                            )
                          : Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E824C),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: Color(0xFF55E795),
                                size: 28,
                              ),
                            ),
                      // Bottom faint watermark
                      Positioned(
                        bottom: 4,
                        child: Text(
                          'សេចក្តីជូនដំណឹង',
                          style: GoogleFonts.battambang(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card Body
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: GoogleFonts.battambang(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['date']!,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['snippet']!,
                        style: GoogleFonts.battambang(
                          fontSize: 13,
                          color: const Color(0xFF4A4A4A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Announcement Details Modal Bottom Sheet ───────────────────────────────
  void _showAnnouncementDetail(
      BuildContext context, Map<String, dynamic> item) {
    final isGear = item['iconType'] == 'gear';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 8),
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1D5DB),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Banner Poster
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0D5733), Color(0xFF05321B)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Top Left Logo
                      Positioned(
                        top: 14,
                        left: 14,
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Image.asset(
                                'assets/images/chip_mong_logo.png',
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.account_balance,
                                  color: Color(0xFF0D5733),
                                  size: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'CHIP MONG\nBANK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Center Icon and Labels
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isGear
                                ? const Icon(
                                    Icons.build_circle,
                                    color: Color(0xFFC7D3CD),
                                    size: 48,
                                  )
                                : Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E824C),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.25),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.notifications,
                                      color: Color(0xFF55E795),
                                      size: 28,
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            Text(
                              'សេចក្តីជូនដំណឹង',
                              style: GoogleFonts.battambang(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'ANNOUNCEMENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bottom Right Hotline
                      Positioned(
                        bottom: 8,
                        right: 12,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.headset_mic,
                              color: Colors.white70,
                              size: 11,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'សេវាអតិថិជន 24/7 តាមរយៈលេខ 081/066 811 911',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 8.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Title and Body
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: GoogleFonts.battambang(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['full']!,
                        style: GoogleFonts.battambang(
                          fontSize: 13.5,
                          height: 1.6,
                          color: const Color(0xFF2C2C2E),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Close Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2F5EC),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                        'បិទ',
                        style: GoogleFonts.battambang(
                          color: const Color(0xFF0FA958),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Custom Painter for Empty State Document Icon
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

    // Body with folded top-right
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

    // Fold triangle
    final foldPath = Path()
      ..moveTo(size.width - foldSize, 0)
      ..lineTo(size.width, foldSize)
      ..lineTo(size.width - foldSize, foldSize)
      ..close();

    canvas.drawPath(foldPath, foldPaint);

    // Lines representing text
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
