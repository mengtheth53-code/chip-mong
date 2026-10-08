import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Green Header with Title, Icon, and Label ─────────────────
            _buildHeader(context),

            // ── Body Content ─────────────────────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildDebitCardTile(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                'ប័ណ្ណ',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Wallet with Plus Icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF2E9E5B),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Label: ប័ណ្ណថ្មី
        Text(
          'ប័ណ្ណថ្មី',
          style: GoogleFonts.battambang(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDebitCardTile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showCardSelectionSheet(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Green Card Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.credit_card_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),

                // Card Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ប័ណ្ណឥណពន្ធ',
                              style: GoogleFonts.battambang(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF1A1F71),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'VISA',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1F71),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'ប័ណ្ណឥណពន្ធ Visa ធ្វើឱ្យការទិញទំនិញប្រចាំថ្ងៃរបស់អ្នកកាន់តែមានភាពងាយស្រួល និងមានសុវត្ថិភាពជាមួយនឹងការផ្តល់ជូនពិសេសគ្មានដែនកំណត់។',
                        style: GoogleFonts.battambang(
                          fontSize: 12.5,
                          color: const Color(0xFF6B7280),
                          height: 1.45,
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
  }

  // ── Modal Bottom Sheet for Card Selection ────────────────────────────────
  void _showCardSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const _CardModalSheetContent(),
    );
  }
}

// ── Card Modal Content with Carousel & Benefits ─────────────────────────────
class _CardModalSheetContent extends StatefulWidget {
  const _CardModalSheetContent();

  @override
  State<_CardModalSheetContent> createState() => _CardModalSheetContentState();
}

class _CardModalSheetContentState extends State<_CardModalSheetContent> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentIndex = 0;
  bool _isExpanded = false;

  final List<Map<String, dynamic>> _cardTypes = [
    {
      'title': 'ប័ណ្ណឥណពន្ធ Visa Classic',
      'fee': 'ថ្លៃសេវាធ្វើប័ណ្ណ៖ ឥតគិតថ្លៃ | ថ្លៃសេវាប្រចាំឆ្នាំ៖ 5 USD',
      'isPlatinum': false,
      'benefits': [
        'ទឹកប្រាក់នៃការទិញទំនិញ: 5,000 ដុល្លារ',
        'ទឹកប្រាក់ដែលអាចដក: 2,500 ដុល្លារ',
        'ឥតគិតថ្លៃសម្រាប់ទូទាត់ប្រាក់អនឡាញ និងតាមរយៈម៉ាស៊ីន POS',
        'សុវត្ថិភាពខ្ពស់ជាមួយនឹងបច្ចេកវិទ្យា EMV Chip និង 3D Secure',
      ],
    },
    {
      'title': 'ប័ណ្ណឥណពន្ធ Visa Platinum',
      'fee': 'ថ្លៃសេវាធ្វើប័ណ្ណ៖ ឥតគិតថ្លៃ | ថ្លៃសេវាប្រចាំឆ្នាំ៖ 99 USD',
      'isPlatinum': true,
      'benefits': [
        'ទឹកប្រាក់នៃការទិញទំនិញ: 20,000 ដុល្លារ',
        'ទឹកប្រាក់ដែលអាចដក: 10,000 ដុល្លារ',
        'ឥតគិតថ្លៃសម្រាប់ទូទាត់ប្រាក់អនឡាញ និងតាមរយៈម៉ាស៊ីន POS',
        'ការចូលប្រើប្រាស់កន្លែងរង់ចាំនៅព្រលានយន្តហោះបាន 5 ដងក្នុងមួយឆ្នាំ',
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = _cardTypes[_currentIndex];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row: Title & Close Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      currentCard['title'] as String,
                      style: GoogleFonts.battambang(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal Carousel of Cards
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _cardTypes.length,
                onPageChanged: (idx) {
                  setState(() => _currentIndex = idx);
                },
                itemBuilder: (context, index) {
                  final card = _cardTypes[index];
                  final isPlat = card['isPlatinum'] as bool;
                  return _buildCreditCardArt(isPlatinum: isPlat);
                },
              ),
            ),
            const SizedBox(height: 12),

            // Fee Summary
            Text(
              currentCard['fee'] as String,
              style: GoogleFonts.battambang(
                fontSize: 12.5,
                color: const Color(0xFF4B5563),
              ),
            ),
            const SizedBox(height: 12),

            // Benefits Section (Collapsed / Expanded)
            if (_isExpanded) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'អត្ថប្រយោជន៍សំខាន់ៗ',
                      style: GoogleFonts.battambang(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        children: [
                          for (final b in currentCard['benefits'] as List<String>)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF0FA958),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      b,
                                      style: GoogleFonts.battambang(
                                        fontSize: 12.5,
                                        color: const Color(0xFF374151),
                                        height: 1.35,
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
              ),
              const SizedBox(height: 10),
            ],

            // Expand / Collapse Toggle
            GestureDetector(
              onTap: () {
                setState(() => _isExpanded = !_isExpanded);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isExpanded ? 'បង្រួម' : 'មើលបន្ថែម',
                    style: GoogleFonts.battambang(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 18,
                    color: const Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Continue Button (បន្ត)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0FA958),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    _showLocationDialog(context);
                  },
                  child: Text(
                    'បន្ត',
                    style: GoogleFonts.battambang(
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
  }

  // ── Card Art Graphic ──────────────────────────────────────────────────────
  Widget _buildCreditCardArt({required bool isPlatinum}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPlatinum
              ? const [Color(0xFF1E1E1E), Color(0xFF0A0A0A)]
              : const [Color(0xFF2C3E35), Color(0xFF1A2E24)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Tower Outline in the Center
          Positioned(
            left: 70,
            bottom: 0,
            top: 20,
            child: CustomPaint(
              size: const Size(80, 160),
              painter: _TowerArtPainter(isGold: isPlatinum),
            ),
          ),

          // Top Left EMV Chip
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              width: 38,
              height: 28,
              decoration: BoxDecoration(
                color: isPlatinum
                    ? const Color(0xFFE5C158)
                    : const Color(0xFFC7CDD2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 0.8,
                ),
              ),
            ),
          ),

          // Top Right: Chip Mong Bank Logo
          Positioned(
            top: 14,
            right: 18,
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
                Text(
                  'CHIP MONG\nBANK',
                  style: TextStyle(
                    color: isPlatinum
                        ? const Color(0xFFE5C158)
                        : Colors.white,
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Right: Visa Logo
          Positioned(
            bottom: 14,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'VISA',
                  style: TextStyle(
                    color: isPlatinum
                        ? const Color(0xFFE5C158)
                        : Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (isPlatinum)
                  const Text(
                    'Platinum',
                    style: TextStyle(
                      color: Color(0xFFE5C158),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Location Permission Alert Dialog ──────────────────────────────────────
  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Circle
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'i',
                    style: TextStyle(
                      color: Color(0xFF1976D2),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Message Text
                const Text(
                  'Require access to your current location to proceed. Would you like to open settings and grant permission ?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),

                // Buttons: ទេ & GO TO SETTINGS
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                        'ទេ',
                        style: GoogleFonts.battambang(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0FA958),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 9,
                        ),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text(
                        'GO TO SETTINGS',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Custom Tower Outline Painter ────────────────────────────────────────────
class _TowerArtPainter extends CustomPainter {
  final bool isGold;
  const _TowerArtPainter({required this.isGold});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isGold
          ? const Color(0xFFE5C158).withValues(alpha: 0.7)
          : const Color(0xFF8FA89B).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw stylized tower lines
    const int lines = 18;
    for (int i = 0; i < lines; i++) {
      final y = size.height * (i / lines);
      final w = size.width * (0.35 + (i / lines) * 0.45);
      canvas.drawLine(
        Offset((size.width - w) / 2, y),
        Offset((size.width + w) / 2, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
