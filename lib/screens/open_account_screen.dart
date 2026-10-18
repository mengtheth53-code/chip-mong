import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fill_screen.dart';
import 'daily_auto_savings_screen.dart';
import 'shared_savings_screen.dart';
import 'term_deposit_screen.dart';

class OpenAccountScreen extends StatelessWidget {
  const OpenAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF085329),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Top Header with App Bar & Description ─────────────────────
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
                    'បើកគណនី',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              child: Text(
                'បើកគណនីរបស់អ្នកបានយ៉ាងងាយស្រួលត្រឹមតែ ពីរ ទៅ បី នាទី ប៉ុណ្ណោះ. សូមជ្រើសរើសប្រភេទគណនីណាមួយរបស់យើងខ្ញុំ',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 13.5,
                  height: 1.55,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // ── White / Light-Gray Content Body ─────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1 Header
                      Text(
                        'គណនីចរន្ត និងសន្សំ',
                        style: GoogleFonts.battambang(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Card 1: គណនីសន្សំប្រីមៀរ
                      _buildAccountTypeCard(
                        context: context,
                        gradientColors: const [
                          Color(0xFF19B661),
                          Color(0xFF0C8A45),
                        ],
                        icon: Icons.account_balance_wallet_outlined,
                        rate: '1.25%',
                        title: 'គណនីសន្សំប្រីមៀរ',
                        subtitle:
                            'ផ្តល់ជូនដំណោះស្រាយហិរញ្ញវត្ថុដែលមានភាពបត់បែនបានសម្រាប់តម្រូវការធនាគារប្រចាំ...',
                        buttonTextColor: const Color(0xFF0C8A45),
                      ),
                      const SizedBox(height: 14),

                      // Card 2: គណនីជំនួញ
                      _buildAccountTypeCard(
                        context: context,
                        gradientColors: const [
                          Color(0xFF29B8A7),
                          Color(0xFF198679),
                        ],
                        icon: Icons.lock_outline,
                        title: 'គណនីជំនួញ',
                        subtitle:
                            'ត្រូវបានរចនាឡើងសម្រាប់អតិថិជនដែលមានអាជីវកម្មខ្នាតតូច និងមធ្យម មានភាពងាយ...',
                        buttonTextColor: const Color(0xFF198679),
                      ),
                      const SizedBox(height: 14),

                      // Card 3: គណនីដើម្បីកូន
                      _buildAccountTypeCard(
                        context: context,
                        gradientColors: const [
                          Color(0xFF86CC35),
                          Color(0xFF5CA318),
                        ],
                        icon: Icons.groups_outlined,
                        title: 'គណនីដើម្បីកូន',
                        subtitle: 'គ្រប់គ្រងការចំណាយកូនៗកាន់តែងាយស្រួល',
                        buttonTextColor: const Color(0xFF5CA318),
                      ),
                      const SizedBox(height: 22),

                      // Section 2 Header
                      Text(
                        'បើកគណនីថ្មី',
                        style: GoogleFonts.battambang(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Card 4: បញ្ញើមានកាលកំណត់
                      _buildAccountTypeCard(
                        context: context,
                        gradientColors: const [
                          Color(0xFF4CBD46),
                          Color(0xFF2D9429),
                        ],
                        icon: Icons.work_outline,
                        rate: '6.75%',
                        title: 'បញ្ញើមានកាលកំណត់ (Term Deposit)',
                        subtitle:
                            'ទទួលបានការប្រាក់ខ្ពស់រហូតដល់ 8.25% លើការសន្សំរបស់អ្នក ជាមួយនិងបញ្ញើមានកាលកំណត់',
                        buttonTextColor: const Color(0xFF2D9429),
                        onOpenPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const TermDepositScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // Card 5: គណនីសន្សំគោលដៅ
                      _buildAccountTypeCard(
                        context: context,
                        gradientColors: const [
                          Color(0xFF65BC31),
                          Color(0xFF439218),
                        ],
                        icon: Icons.savings_outlined,
                        rate: '5.1%',
                        title: 'គណនីសន្សំគោលដៅ',
                        subtitle:
                            'គណនីសន្សំគោលដៅ គឺជាប្រភេទគណនីថ្មី មួយដែលផ្តល់អត្រាការប្រាក់ ពិសេសៗ និង...',
                        buttonTextColor: const Color(0xFF439218),
                      ),
                      const SizedBox(height: 22),

                      // Section 3: គំនិតនវានុវត្តន៍គណនីសន្សំឆ្លាតវៃ
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0FA958),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'NEW INNOVATIONS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'គណនីសន្សំឆ្លាតវៃ (Smart Savings)',
                              style: GoogleFonts.battambang(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Card 6: ការសន្សំប្រាក់ខ្នាតតូចប្រចាំថ្ងៃ (Daily Auto-Savings)
                      _buildAccountTypeCard(
                        context: context,
                        gradientColors: const [
                          Color(0xFF0B7E43),
                          Color(0xFF064E28),
                        ],
                        icon: Icons.savings_rounded,
                        rate: '3.5%',
                        title: 'ការសន្សំស្វ័យប្រវត្តប្រចាំថ្ងៃ (Daily Auto-Savings)',
                        subtitle:
                            'បង្កើតទម្លាប់សន្សំខ្នាតតូច \$1, \$2 ឬ \$5 រៀងរាល់ថ្ងៃដោយស្វ័យប្រវត្ត គ្មានសម្ពាធ ដកប្រាក់បានគ្រប់ពេល។',
                        buttonTextColor: const Color(0xFF0B7E43),
                        onOpenPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const DailyAutoSavingsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // Card 7: គណនីសន្សំរួមគ្នាឆ្លាតវៃ (Smart Shared Savings)
                      _buildAccountTypeCard(
                        context: context,
                        gradientColors: const [
                          Color(0xFF0284C7),
                          Color(0xFF0369A1),
                        ],
                        icon: Icons.groups_rounded,
                        rate: '4.0%',
                        title: 'គណនីសន្សំរួមគ្នាឆ្លាតវៃ (Smart Shared Savings)',
                        subtitle:
                            'សន្សំជាក្រុមជាមួយមិត្តភក្តិ គូស្នេហ៍ ឬគ្រួសារតាមគោលដៅជាក់លាក់ តម្លាភាពខ្ពស់ មិនបាច់ទៅបើកគណនីនៅសាខា។',
                        buttonTextColor: const Color(0xFF0369A1),
                        onOpenPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SharedSavingsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTypeCard({
    required BuildContext context,
    required List<Color> gradientColors,
    required IconData icon,
    String? rate,
    required String title,
    required String subtitle,
    required Color buttonTextColor,
    VoidCallback? onOpenPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Icon on left, interest rate badge on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const Spacer(),
              if (rate != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'រហូតដល់',
                        style: GoogleFonts.battambang(
                          fontSize: 9.5,
                          color: Colors.white70,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        rate,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // Title
          Text(
            title,
            style: GoogleFonts.battambang(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            subtitle,
            style: GoogleFonts.battambang(
              fontSize: 12.5,
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),

          // Open Now button on bottom right
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onOpenPressed ??
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const FillScreen(),
                      ),
                    );
                  },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'បើកឥឡូវនេះ',
                  style: GoogleFonts.battambang(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: buttonTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
