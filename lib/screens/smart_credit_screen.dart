import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SmartCreditScreen extends StatefulWidget {
  const SmartCreditScreen({super.key});

  @override
  State<SmartCreditScreen> createState() => _SmartCreditScreenState();
}

class _SmartCreditScreenState extends State<SmartCreditScreen> {
  double _loanAmount = 2500;
  int _selectedTenure = 12; // months

  double get _monthlyRepayment {
    // Interest rate 1.1% per month
    const monthlyRate = 0.011;
    final totalInterest = _loanAmount * monthlyRate * _selectedTenure;
    return (_loanAmount + totalInterest) / _selectedTenure;
  }

  void _submitApplication() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFDFF5EA),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: Color(0xFF0FA958), size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              'សំណើត្រូវបានបញ្ជូនដោយជោគជ័យ!',
              style: GoogleFonts.battambang(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ពិន្ទុ AI របស់អ្នកបានឆ្លងកាត់ការវាយតម្លៃបឋម (Pre-Approved \$${_loanAmount.toInt()})។ របាយការណ៍ត្រូវបានបញ្ជូនទៅកាន់មន្ត្រីឥណទានធនាគារ ជីប ម៉ុង ដើម្បីពិនិត្យអនុម័តផ្លូវការចុងក្រោយ (Human-in-the-loop Verification) ក្នុងរយៈពេល 15 នាទី។',
              textAlign: TextAlign.center,
              style: GoogleFonts.battambang(
                fontSize: 13,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0FA958),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'យល់ព្រម',
                  style: GoogleFonts.battambang(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
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
                const Icon(Icons.psychology_alt_rounded, color: Color(0xFF34D399), size: 18),
                const SizedBox(width: 8),
                Text(
                  'ប្រព័ន្ធវាយតម្លៃឥណទានឆ្លាតវៃ',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'AI & Smart Credit System',
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
            // AI Credit Score Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF064E3B), Color(0xFF047857)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF047857).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ពិន្ទុឥណទាន AI របស់អ្នក',
                            style: GoogleFonts.battambang(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '785',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '/ 850',
                                style: GoogleFonts.roboto(
                                  color: Colors.white54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF34D399), width: 1.2),
                        ),
                        child: Text(
                          'ល្អប្រសើរណាស់ (Excellent)',
                          style: GoogleFonts.battambang(
                            color: const Color(0xFFD1FAE5),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.bolt, color: Color(0xFFFBBF24), size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'អនុម័តបឋមភ្លាមៗក្នុង 3 នាទី (Pre-Approved Limit: \$5,000)',
                            style: GoogleFonts.battambang(
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
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

            // Cash Flow Analysis Metrics
            Text(
              'ការវិភាគលំហូរសាច់ប្រាក់ (Cash Flow Health)',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    label: 'ស្ថេរភាពចំណូល',
                    value: '96%',
                    subtext: 'ចំណូលទៀងទាត់',
                    color: const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    label: 'លំហូរសាច់ប្រាក់សុទ្ធ',
                    value: '+\$1,250',
                    subtext: 'ប្រចាំខែ',
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    label: 'សមាមាត្របំណុល DTI',
                    value: '18%',
                    subtext: 'កម្រិតសុវត្ថិភាពខ្ពស់',
                    color: const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    label: 'ប្រវត្តិទូទាត់ទាន់ពេល',
                    value: '100%',
                    subtext: 'គ្មានប្រវត្តិយឺតយ៉ាវ',
                    color: const Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Interactive Loan Simulator
            Container(
              padding: const EdgeInsets.all(18),
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
                    'គណនាឥណទានរហ័ស (Quick Loan Simulator)',
                    style: GoogleFonts.battambang(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ទំហំកម្ចីដែលចង់ស្នើសុំ', style: GoogleFonts.battambang(fontSize: 13, color: Colors.grey.shade700)),
                      Text(
                        '\$${_loanAmount.toInt()}',
                        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958)),
                      ),
                    ],
                  ),
                  Slider(
                    value: _loanAmount,
                    min: 500,
                    max: 5000,
                    divisions: 45,
                    activeColor: const Color(0xFF0FA958),
                    onChanged: (val) => setState(() => _loanAmount = val),
                  ),
                  const SizedBox(height: 10),
                  Text('រយៈពេលសង (Tenure)', style: GoogleFonts.battambang(fontSize: 13, color: Colors.grey.shade700)),
                  const SizedBox(height: 8),
                  Row(
                    children: [6, 12, 24].map((tenure) {
                      final isSelected = _selectedTenure == tenure;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTenure = tenure),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF0FA958) : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '$tenure ខែ',
                                style: GoogleFonts.battambang(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Divider(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ប្រាក់ត្រូវសងប្រចាំខែប៉ាន់ស្មាន', style: GoogleFonts.battambang(fontSize: 13, color: Colors.black87)),
                      Text(
                        '\$${_monthlyRepayment.toStringAsFixed(2)} / ខែ',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF065F46),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Human-in-the-loop compliance reassurance card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF93C5FD)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user_rounded, color: Color(0xFF2563EB), size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'ប្រព័ន្ធដំណើរការដោយរក្សាការត្រួតពិនិត្យចុងក្រោយដោយមនុស្ស (Human-in-the-loop) ដើម្បីធានាសុវត្ថិភាព និងការអនុលោមតាមបទប្បញ្ញត្តិរបស់ធនាគារជាតិនៃកម្ពុជា។',
                      style: GoogleFonts.battambang(
                        fontSize: 12,
                        color: const Color(0xFF1E40AF),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0FA958),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                onPressed: _submitApplication,
                child: Text(
                  'ស្នើសុំឥណទានភ្លាមៗ (Instant Apply)',
                  style: GoogleFonts.battambang(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

  Widget _buildMetricTile({
    required String label,
    required String value,
    required String subtext,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.battambang(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(subtext, style: GoogleFonts.battambang(fontSize: 11, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
