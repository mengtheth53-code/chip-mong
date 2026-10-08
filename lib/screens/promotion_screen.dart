import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  int _selectedFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'ការផ្តល់ជូនពិសេសៗ',
    'ប័ណ្ណឥណទាន Visa Platinum',
    'ប័ណ្ណឥណពន្ធ Visa Classic',
  ];

  final List<Map<String, dynamic>> _merchantOffers = [
    {
      'name': 'Tiara In Rose',
      'expiry': 'រហូតដល់: 18 សីហា 2027',
      'badge': 'បញ្ចុះតម្លៃ 15%',
      'redLabel': 'បញ្ចុះតម្លៃ 15%',
      'desc':
          'ដោយធ្វើការទូទាត់តាមរយៈកាត Visa របស់ ធនាគារ ជីប ម៉ុង ។',
      'logoBg': Colors.black,
      'logoText': 'TIARA\nIN\nROSE',
      'logoSub': 'Flower & Cafe',
      'isCircleLogo': false,
    },
    {
      'name': 'Ringer Hut',
      'expiry': 'រហូតដល់: 18 កញ្ញា 2027',
      'badge': '10% OFF',
      'redLabel': 'Get 10% OFF',
      'desc':
          'ដោយធ្វើការទូទាត់តាមរយៈកាតVisa របស់ ធនាគារ ជីប ម៉ុង។',
      'logoBg': const Color(0xFFFFF7D6),
      'logoText': 'R',
      'logoSub': 'Ringer Hut',
      'isCircleLogo': false,
    },
    {
      'name': 'NIQUE COFFEE',
      'expiry': 'រហូតដល់: 20 មីនា 2027',
      'badge': 'បញ្ចុះតម្លៃ 5%',
      'redLabel': 'បញ្ចុះតម្លៃ 5%',
      'desc':
          'ដោយធ្វើការទូទាត់តាមរយៈកាតVisa របស់ ធនាគារ ជីប ម៉ុង។',
      'logoBg': Colors.white,
      'logoText': 'NIQUE',
      'logoSub': 'COFFEE',
      'isCircleLogo': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Green Header ──────────────────────────────────────────────
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
                    'អត្ថប្រយោជន៍ និងការផ្តល់ជូនពិសេស',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ── Main Body ──────────────────────────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16, 14, 16, 8),
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
                                  fontSize: 14,
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

                    // Filter Chips Bar
                    SizedBox(
                      height: 42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filters.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedFilterIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedFilterIndex = index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 8, top: 2, bottom: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? _green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _filters[index],
                                style: GoogleFonts.battambang(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF555555),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Content View
                    Expanded(
                      child: _selectedFilterIndex == 0
                          ? _buildSpecialOffersView()
                          : _buildMerchantOffersView(),
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

  // ── Tab 1: ការផ្តល់ជូនពិសេសៗ (Promotional Banner Cards) ──────────────────────
  Widget _buildSpecialOffersView() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        // Card 1: Landmarks Promo Banner
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 185,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background visual
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF388E68), Color(0xFF164831)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Famous monuments silhouettes / representation
                      Positioned(
                        left: 10,
                        bottom: 45,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Icon(Icons.location_city, color: Colors.white24, size: 55),
                            SizedBox(width: 8),
                            Icon(Icons.account_balance, color: Colors.white24, size: 65),
                            SizedBox(width: 8),
                            Icon(Icons.apartment, color: Colors.white24, size: 75),
                          ],
                        ),
                      ),
                      // Floating Cards Illustration
                      Positioned(
                        right: 20,
                        bottom: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE88A1A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'ទទួលបានប្រាក់ត្រឡប់មកវិញរហូតដល់',
                                style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              '\$100',
                              style: TextStyle(
                                color: Color(0xFFFDD835),
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Top Left Chip Mong Bank Logo
                Positioned(
                  top: 12,
                  left: 14,
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

                // Top Right Badge
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0FA958),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'ប្រាក់ត្រឡប់រហូតដល់ \$100',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Bottom Gradient Banner with Title and Date
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(14, 20, 14, 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ទូទាត់តាមប័ណ្ណឥណទានរបស់ ធនាគារ ជីប ម៉ុង បានប្រាក់ត្រឡប់មកវិញរហូតដល់1%',
                                style: GoogleFonts.battambang(
                                  color: Colors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'រហូតដល់: 31 ធ្នូ 2026',
                                style: GoogleFonts.battambang(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'VISA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
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

        // Card 2: KHQR Rewards
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 185,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0F7A44), Color(0xFF074825)],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 70,
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  bottom: 12,
                  right: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'កម្មវិធីផ្ដល់ប្រាក់រង្វាន់លើកទឹកចិត្តសម្រាប់អាជីវករដែលប្រើប្រាស់ KHQR ធនាគារ ជីប ម៉ុង',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'រហូតដល់: 30 មិថុនា 2026',
                        style: GoogleFonts.battambang(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Tab 2: ប័ណ្ណឥណទាន Visa Platinum (Merchant Discount Cards) ──────────────
  Widget _buildMerchantOffersView() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: _merchantOffers.length,
      itemBuilder: (context, index) {
        final offer = _merchantOffers[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Logo, Name, Expiry, and Discount Badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Merchant Logo
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: offer['logoBg'] as Color,
                      shape: (offer['isCircleLogo'] as bool)
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      borderRadius: (offer['isCircleLogo'] as bool)
                          ? null
                          : BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      offer['logoText'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: (offer['logoBg'] == Colors.white ||
                                offer['logoBg'] == const Color(0xFFFFF7D6))
                            ? Colors.black87
                            : Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Name & Expiry
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer['name'] as String,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          offer['expiry'] as String,
                          style: GoogleFonts.battambang(
                            fontSize: 12,
                            color: const Color(0xFF0FA958),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Green Speech-Bubble Discount Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      offer['badge'] as String,
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Red Highlight Label
              Text(
                offer['redLabel'] as String,
                style: GoogleFonts.battambang(
                  color: const Color(0xFFE53935),
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),

              // Description
              Text(
                offer['desc'] as String,
                style: GoogleFonts.battambang(
                  fontSize: 12.5,
                  color: const Color(0xFF4B5563),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),

              // View More Button
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'មើលបន្ថែម',
                      style: GoogleFonts.battambang(
                        fontSize: 12.5,
                        color: const Color(0xFF0FA958),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: Color(0xFF0FA958),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
