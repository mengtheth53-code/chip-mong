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
                      Text(
                        'កាតាបសន្សំប្រចាំថ្ងៃ (Savings Pocket)',
                        style: GoogleFonts.battambang(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
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
                  monthly: '~\$30/ខែ',
                  label: 'កម្រិតដំបូង',
                ),
                const SizedBox(width: 8),
                _buildPlanCard(
                  amount: 2.0,
                  monthly: '~\$60/ខែ',
                  label: 'ពេញនិយម',
                  isPopular: true,
                ),
                const SizedBox(width: 8),
                _buildPlanCard(
                  amount: 5.0,
                  monthly: '~\$150/ខែ',
                  label: 'សន្សំខ្ពស់',
                ),
              ],
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

            // 7-Day Savings Streak Record
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
                        'ប្រវត្តិសន្សំ ៧ ថ្ងៃចុងក្រោយ (Streak)',
                        style: GoogleFonts.battambang(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '៧ ថ្ងៃជាប់គ្នា 🔥',
                        style: GoogleFonts.battambang(
                          fontSize: 12,
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
    required String monthly,
    required String label,
    bool isPopular = false,
  }) {
    final isSelected = _selectedDailyAmount == amount;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedDailyAmount = amount),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
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
                '\$${amount.toInt()} / ថ្ងៃ',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? const Color(0xFF065F46) : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                monthly,
                style: GoogleFonts.battambang(
                  fontSize: 11.5,
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
}
