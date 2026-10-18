import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class DailyAutoSavingsScreen extends StatefulWidget {
  const DailyAutoSavingsScreen({super.key});

  @override
  State<DailyAutoSavingsScreen> createState() => _DailyAutoSavingsScreenState();
}

class _DailyAutoSavingsScreenState extends State<DailyAutoSavingsScreen> {
  double _currentPocketBalance = 185.00;
  double _selectedDailyAmount = 2.0; // $2 / day -> $60 / month
  bool _isAutoSaveActive = true;
  bool _smartBalanceGuardEnabled = true;
  final double _safetyBufferThreshold = 5.0; // $5 min balance guard
  final int _streakDays = 14;
  final String _debitTime = '08:00 AM';

  void _withdrawToMainAccount() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ដកប្រាក់សន្សំទៅគណនីដើម',
              style: GoogleFonts.battambang(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'អ្នកអាចដកប្រាក់សន្សំខ្នាតតូចបានគ្រប់ពេលវេលា ដោយគ្មានការផាកពិន័យ និងមិនបាត់បង់ការប្រាក់ដែលបានគិតរួច។',
              style: GoogleFonts.battambang(fontSize: 13, color: Colors.grey.shade600, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ទឹកប្រាក់ដែលអាចដកបាន', style: GoogleFonts.battambang(fontSize: 13)),
                  Text(
                    '\$${_currentPocketBalance.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0FA958),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  setState(() {
                    _currentPocketBalance = 0.0;
                  });
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF0FA958),
                      content: Text('ប្រាក់សន្សំត្រូវបានផ្ទេរចូលគណនីចម្បងដោយជោគជ័យ!', style: GoogleFonts.battambang()),
                    ),
                  );
                },
                child: Text(
                  'ដកប្រាក់ទាំងអស់',
                  style: GoogleFonts.battambang(fontSize: 14.5, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthlyAccumulated = (_selectedDailyAmount * 30).toInt();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.savings_rounded, color: Color(0xFF6EE7B7), size: 20),
                const SizedBox(width: 8),
                Text(
                  'ការសន្សំប្រាក់ប្រចាំថ្ងៃស្វ័យប្រវត្ត',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Daily Auto-Savings (Micro-Savings)',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vault Balance Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF065F46), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withValues(alpha: 0.3),
                    blurRadius: 12,
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
                      Flexible(
                        child: Text(
                          'កាតាបសន្សំប្រចាំថ្ងៃ (Savings Pocket)',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.battambang(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF34D399).withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF6EE7B7), width: 1),
                        ),
                        child: Text(
                          'ការប្រាក់ 3.5% p.a.',
                          style: GoogleFonts.battambang(
                            color: const Color(0xFFD1FAE5),
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_currentPocketBalance.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isAutoSaveActive ? Icons.check_circle_rounded : Icons.pause_circle_rounded,
                            color: _isAutoSaveActive ? const Color(0xFF34D399) : Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _isAutoSaveActive ? 'កំពុងដំណើរការ (\$${_selectedDailyAmount.toInt()}/ថ្ងៃ)' : 'បានផ្អាកជាបណ្តោះអាសន្ន',
                            style: GoogleFonts.battambang(color: Colors.white, fontSize: 12.5),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: _withdrawToMainAccount,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'ដកប្រាក់',
                            style: GoogleFonts.battambang(
                              color: const Color(0xFF065F46),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Select Daily Savings Plan
            Text(
              'ជ្រើសរើសកញ្ចប់សន្សំប្រចាំថ្ងៃ',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildPlanCard(
                  amount: 1.0,
                  khrAmount: '4,000៛',
                  monthly: '~\$30/ខែ',
                  label: 'កម្រិតដំបូង',
                ),
                const SizedBox(width: 8),
                _buildPlanCard(
                  amount: 2.0,
                  khrAmount: '8,000៛',
                  monthly: '~\$60/ខែ',
                  label: 'ពេញនិយមបំផុត',
                  isPopular: true,
                ),
                const SizedBox(width: 8),
                _buildPlanCard(
                  amount: 5.0,
                  khrAmount: '20,000៛',
                  monthly: '~\$150/ខែ',
                  label: 'សន្សំខ្ពស់',
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Smart Balance Guard Card (Proposal 4.5 Feature)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _smartBalanceGuardEnabled ? const Color(0xFF6EE7B7) : Colors.grey.shade300,
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0FA958).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.security_rounded, color: Color(0xFF0FA958), size: 20),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Smart Balance Guard',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'ប្រព័ន្ធការពារសមតុល្យឆ្លាតវៃ',
                                style: GoogleFonts.battambang(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: _smartBalanceGuardEnabled,
                        activeThumbColor: const Color(0xFF0FA958),
                        onChanged: (val) => setState(() => _smartBalanceGuardEnabled = val),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFF16A34A), size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'ប្រសិនបើសមតុល្យក្នុងគណនីធ្លាក់ក្រោម \$${_safetyBufferThreshold.toStringAsFixed(2)} ប្រព័ន្ធនឹងផ្អាកការកាត់ប្រាក់ស្វ័យប្រវត្ត ដើម្បីកុំឱ្យប៉ះពាល់ការចាយវាយប្រចាំថ្ងៃ ឬជួបបញ្ហា Overdraft។',
                            style: GoogleFonts.battambang(
                              fontSize: 11,
                              color: const Color(0xFF166534),
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
            const SizedBox(height: 18),

            // Automation Settings Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ការកំណត់ការកាត់ប្រាក់ស្វ័យប្រវត្ត',
                    style: GoogleFonts.battambang(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('បើកដំណើរការសន្សំប្រចាំថ្ងៃ', style: GoogleFonts.battambang(fontSize: 13.5, fontWeight: FontWeight.w600)),
                          Text('កាត់ប្រាក់ស្វ័យប្រវត្តជារៀងរាល់ថ្ងៃ', style: GoogleFonts.battambang(fontSize: 11.5, color: Colors.grey)),
                        ],
                      ),
                      Switch(
                        value: _isAutoSaveActive,
                        activeThumbColor: const Color(0xFF0FA958),
                        onChanged: (val) => setState(() => _isAutoSaveActive = val),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ម៉ោងកាត់ប្រាក់ប្រចាំថ្ងៃ', style: GoogleFonts.battambang(fontSize: 13)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(_debitTime, style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('កាត់ចេញពីគណនី', style: GoogleFonts.battambang(fontSize: 13)),
                      Text('Premier Account ...3840', style: GoogleFonts.roboto(fontSize: 12.5, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Gamification: Streaks & Badges (Proposal 4.5 Feature)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ប្រវត្តិសន្សំ ៧ ថ្ងៃចុងក្រោយ',
                        style: GoogleFonts.battambang(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '$_streakDays ថ្ងៃជាប់គ្នា 🔥',
                        style: GoogleFonts.battambang(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFEA580C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['ច័ន្ទ', 'អង្គារ', 'ពុធ', 'ព្រហ', 'សុក្រ', 'សៅរ៍', 'អាទិត្យ'].map((day) {
                      return Column(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(
                              color: Color(0xFFDFF5EA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Color(0xFF0FA958), size: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(day, style: GoogleFonts.battambang(fontSize: 11, color: Colors.grey.shade600)),
                        ],
                      );
                    }).toList(),
                  ),
                  const Divider(height: 24),

                  // Milestone Gamification Badges
                  Text(
                    'ផ្លាកសញ្ញាលើកទឹកចិត្ត (Gamification Badges)៖',
                    style: GoogleFonts.battambang(fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildBadgeItem(
                          icon: '🥉',
                          title: 'Bronze Saver',
                          target: '30 ថ្ងៃ',
                          reward: '+100 pts',
                          isAchieved: false,
                          progress: '14/30',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildBadgeItem(
                          icon: '🥈',
                          title: 'Silver Saver',
                          target: '60 ថ្ងៃ',
                          reward: 'Voucher 10%',
                          isAchieved: false,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildBadgeItem(
                          icon: '🥇',
                          title: 'Gold Saver',
                          target: '90 ថ្ងៃ',
                          reward: 'Legend Cinema',
                          isAchieved: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Financial Math & CASA Projections Card (Proposal 4.5 Core Value)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calculate_rounded, color: Color(0xFF34D399), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'គណិតវិទ្យាហិរញ្ញវត្ថុ & តម្លៃយុទ្ធសាស្ត្រ',
                        style: GoogleFonts.battambang(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Customer Perspective
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '👤 សម្រាប់អតិថិជន (Customer Value):',
                          style: GoogleFonts.battambang(
                            color: const Color(0xFF6EE7B7),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$2 / ថ្ងៃ  x  365 ថ្ងៃ  =  \$730 / ឆ្នាំ',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'សន្សំបានយ៉ាងងាយស្រួលដោយមិនមានអារម្មណ៍ថាជាបន្ទុកថវិកាប្រចាំខែ។',
                          style: GoogleFonts.battambang(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Bank CASA Liquidity Perspective
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🏛️ សម្រាប់ធនាគារ ជីប ម៉ុង (Bank CASA Impact):',
                          style: GoogleFonts.battambang(
                            color: const Color(0xFFFBBF24),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '100,000 នាក់  x  \$1/ថ្ងៃ  =  \$36,500,000 / ឆ្នាំ',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'បង្កើតលំហូរប្រាក់បញ្ញើចរន្ត (CASA) ថ្មី \$36.5M ដែលជាទុនថ្លៃដើមទាប និងមានស្ថេរភាពខ្ពស់បំផុត (Sticky Liquidity)។',
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
            const SizedBox(height: 24),

            // Save settings action
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0FA958),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF0FA958),
                      content: Text('ការកំណត់សន្សំ \$${_selectedDailyAmount.toInt()}/ថ្ងៃ ត្រូវបានរក្សាទុក!', style: GoogleFonts.battambang()),
                    ),
                  );
                },
                child: Text(
                  'រក្សាទុកការកំណត់ (សន្សំបាន ~\$' '$monthlyAccumulated/ខែ)',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required double amount,
    required String khrAmount,
    required String monthly,
    required String label,
    bool isPopular = false,
  }) {
    final isSelected = _selectedDailyAmount == amount;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedDailyAmount = amount),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFDFF5EA) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? const Color(0xFF0FA958) : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              if (isPopular)
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0FA958),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'ពេញនិយម',
                    style: GoogleFonts.battambang(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                  ),
                )
              else
                SizedBox(
                  height: 16,
                  child: Text(
                    label,
                    style: GoogleFonts.battambang(color: Colors.grey.shade600, fontSize: 10),
                  ),
                ),
              Text(
                '\$${amount.toInt()}',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? const Color(0xFF065F46) : Colors.black87,
                ),
              ),
              Text(
                khrAmount,
                style: GoogleFonts.battambang(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                monthly,
                style: GoogleFonts.battambang(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0FA958),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeItem({
    required String icon,
    required String title,
    required String target,
    required String reward,
    required bool isAchieved,
    String? progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.roboto(fontSize: 10.5, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            target,
            style: GoogleFonts.battambang(fontSize: 10, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF0FA958).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              reward,
              style: GoogleFonts.battambang(
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0FA958),
              ),
            ),
          ),
          if (progress != null) ...[
            const SizedBox(height: 4),
            Text(
              progress,
              style: GoogleFonts.roboto(fontSize: 9, fontWeight: FontWeight.bold, color: const Color(0xFFEA580C)),
            ),
          ],
        ],
      ),
    );
  }
}
