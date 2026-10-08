import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'open_account_screen.dart';
import 'smart_credit_screen.dart';

class BorrowScreen extends StatelessWidget {
  const BorrowScreen({super.key});

  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  final List<Map<String, dynamic>> _loans = const [
    {
      'title': 'កម្ចីរហ័ស',
      'description':
          'ប្រើប្រាស់ទឹកប្រាក់របស់អ្នកដោយពុំចាំបាច់បិទគណនីបញ្ញើមានកាលកំណត់ និងមិនបាត់បង់ការប្រាក់ដែ...',
      'imageUrl':
          'https://image.freshnewsasia.com/2020/id-024/fn-2021-02-28-14-59-29-0.jpg',
      'fallbackColor': Color(0xFFB5704D),
      'fallbackIcon': Icons.savings_outlined,
      'isQuickLoan': true,
    },
    {
      'title': 'កម្ចីអាជីវកម្ម',
      'description': 'គាំទ្រកំណើនអាជីវកម្មរបស់អ្នក',
      'imageUrl':
          'https://www.chipmongbank.com.kh/api/images/777fb1a3-cada-433e-801d-d0fa874e869a.jpg',
      'fallbackColor': Color(0xFF5A7E8C),
      'fallbackIcon': Icons.business_center_outlined,
      'isQuickLoan': false,
    },
    {
      'title': 'កម្ចីផ្ទាល់ខ្លួន',
      'description': 'សម្រាប់តម្រូវការសាច់ប្រាក់រយៈពេលខ្លីរបស់អ្នក',
      'imageUrl':
          'https://moi-static.sgp1.cdn.digitaloceanspaces.com/uploads/post/feature_image/15980/feature.jpeg',
      'fallbackColor': Color(0xFF5F9E7D),
      'fallbackIcon': Icons.phone_android_rounded,
      'isQuickLoan': false,
    },
    {
      'title': 'កម្ចីគេហដ្ឋាន',
      'description': 'ទិញផ្ទះក្នុងក្ដីស្រមៃរបស់អ្នកបានយ៉ាងងាយស្រួល',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIzALxlshV4zRUTVKZ2L-NUnzZsBT6Sy9JcA&s',
      'fallbackColor': Color(0xFFC49A45),
      'fallbackIcon': Icons.home_outlined,
      'isQuickLoan': false,
    },
  ];

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
                    'ប្រាក់កម្ចី',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ── Scrollable Body Area ───────────────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  children: [
                    _buildSmartCreditFeatureCard(context),
                    const SizedBox(height: 16),
                    ..._loans.map((loan) => _buildLoanCard(context, loan)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartCreditFeatureCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF063A1D),
            Color(0xFF0F7640),
            Color(0xFF10B981),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF085329).withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBBF24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt_rounded, color: Colors.black, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'AI INNOVATION',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'អនុម័តក្នុង ២ នាទី',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'ប្រព័ន្ធវាយតម្លៃឥណទានឆ្លាតវៃ AI',
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'វាយតម្លៃលំហូរសាច់ប្រាក់ដោយ AI Pre-scoring កាត់បន្ថយពេលវេលាត្រួតពិនិត្យ ជាមួយសុវត្ថិភាពស្តង់ដារខ្ពស់។',
            style: GoogleFonts.battambang(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.speed_rounded, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'ពិន្ទុ AI ខ្ពស់ដល់ 850',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SmartCreditScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'គណនាឥណទាន',
                        style: GoogleFonts.battambang(
                          color: const Color(0xFF085329),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF085329),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoanCard(BuildContext context, Map<String, dynamic> loan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 290,
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
            // Background Image with Fallback Visual
            Image.network(
              loan['imageUrl'] as String,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: loan['fallbackColor'] as Color,
                  child: Center(
                    child: Icon(
                      loan['fallbackIcon'] as IconData,
                      size: 64,
                      color: Colors.white38,
                    ),
                  ),
                );
              },
              errorBuilder: (_, __, ___) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        loan['fallbackColor'] as Color,
                        const Color(0xFF0C6B38),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      loan['fallbackIcon'] as IconData,
                      size: 72,
                      color: Colors.white24,
                    ),
                  ),
                );
              },
            ),

            // Green Gradient Overlay at the bottom
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.35, 0.70, 1.0],
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0FA958).withValues(alpha: 0.75),
                      const Color(0xFF09783D).withValues(alpha: 0.95),
                    ],
                  ),
                ),
              ),
            ),

            // Loan Information & Apply Button
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loan['title'] as String,
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          loan['description'] as String,
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 12.5,
                            height: 1.45,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Apply Button: ស្នើសុំឥឡូវនេះ
                      GestureDetector(
                        onTap: () {
                          _showCollateralDialog(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'ស្នើសុំឥឡូវនេះ',
                            style: GoogleFonts.battambang(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
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
    );
  }

  // ── Collateral Information Modal Dialog ──────────────────────────────────
  void _showCollateralDialog(BuildContext context) {
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
                // Info Circle Icon
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

                // Question Body
                Text(
                  'អ្នកត្រូវមានគណនីបញ្ញើមានកាលកំណត់ ដើម្បីធ្វើជាទ្រព្យធានា។ តើអ្នកត្រូវការបើកគណនីបញ្ញើមានកាលកំណត់ឥឡូវនេះទេ ?',
                  style: GoogleFonts.battambang(
                    fontSize: 13.5,
                    color: const Color(0xFF374151),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),

                // Actions: បោះបង់ & យល់ព្រម
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                        'បោះបង់',
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
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OpenAccountScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'យល់ព្រម',
                        style: GoogleFonts.battambang(
                          fontSize: 14,
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
