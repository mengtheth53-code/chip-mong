import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SmartCreditScreen extends StatefulWidget {
  const SmartCreditScreen({super.key});

  @override
  State<SmartCreditScreen> createState() => _SmartCreditScreenState();
}

class _SmartCreditScreenState extends State<SmartCreditScreen> {
  // Mode: 0 for Digital Nano-Loans, 1 for Buy Now Pay Later (BNPL)
  int _selectedMode = 0;

  // Digital Nano-Loan State ($50 - $1,000 per Proposal 4.2)
  double _loanAmount = 300;
  int _selectedTenure = 6; // months

  // BNPL State
  final String _selectedBnplMerchant = 'Chip Mong Supermarket (ផ្សារទំនើប ជីប ម៉ុង)';
  double _bnplAmount = 120.00;
  int _bnplMonths = 3; // 3 months 0% interest

  double get _monthlyRepayment {
    if (_selectedMode == 0) {
      // Micro-credit monthly rate 1.1%
      const monthlyRate = 0.011;
      final totalInterest = _loanAmount * monthlyRate * _selectedTenure;
      return (_loanAmount + totalInterest) / _selectedTenure;
    } else {
      // 0% interest campaign per Proposal 4.2
      return _bnplAmount / _bnplMonths;
    }
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
              _selectedMode == 0
                  ? 'សំណើកម្ចីខ្នាតតូចត្រូវបានបញ្ជូន!'
                  : 'សំណើបង់រំលស់ BNPL 0% ត្រូវបានអនុម័ត!',
              textAlign: TextAlign.center,
              style: GoogleFonts.battambang(
                fontSize: 17.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedMode == 0
                  ? 'ពិន្ទុ Alternative Credit របស់អ្នកបានឆ្លងកាត់ការវាយតម្លៃបឋម (Pre-Approved \$${_loanAmount.toInt()}) ដោយមិនបាច់មានទ្រព្យបញ្ចាំ។ ទិន្នន័យត្រូវបានបញ្ជូនទៅកាន់មន្ត្រីឥណទានដើម្បីត្រួតពិនិត្យអនុម័តផ្លូវការ (Human-in-the-loop) តាមបទប្បញ្ញត្តិ NBC។'
                  : 'ការបង់រំលស់ BNPL \$${_bnplAmount.toStringAsFixed(0)} ជាមួយការប្រាក់ 0% ត្រូវបានភ្ជាប់ជាមួយ $_selectedBnplMerchant ដោយជោគជ័យ។',
              textAlign: TextAlign.center,
              style: GoogleFonts.battambang(
                fontSize: 12.5,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 22),
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
                const Icon(Icons.bolt_rounded, color: Color(0xFFFBBF24), size: 20),
                const SizedBox(width: 8),
                Text(
                  'AI & Smart Credit System',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Alternative Credit Scoring • Proposal 4.2',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 10.5,
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
            // AI Alternative Credit Score Card
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'ពិន្ទុ Alternative Credit',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.battambang(
                                      color: Colors.white70,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBBF24).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Thin-File CBC',
                                    style: GoogleFonts.roboto(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFDE68A),
                                    ),
                                  ),
                                ),
                              ],
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
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '/ 850',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF34D399), width: 1.2),
                        ),
                        child: Text(
                          'គុណភាពខ្ពស់ (Eligible)',
                          style: GoogleFonts.battambang(
                            color: const Color(0xFFD1FAE5),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
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
                            'ដំណោះស្រាយសម្រាប់ Thin-file Customers (និស្សិត និងអាជីវករខ្នាតតូច)',
                            style: GoogleFonts.battambang(
                              color: Colors.white,
                              fontSize: 12,
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
            const SizedBox(height: 16),

            // Mode Selector: Nano-Loans vs BNPL (Proposal 4.2)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMode = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedMode == 0 ? AppColors.primaryGreen : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedMode == 0 ? AppColors.primaryGreen : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Digital Nano-Loans (\$50-\$1k)',
                          style: GoogleFonts.battambang(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: _selectedMode == 0 ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMode = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedMode == 1 ? AppColors.primaryGreen : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedMode == 1 ? AppColors.primaryGreen : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Buy Now Pay Later (BNPL 0%)',
                          style: GoogleFonts.battambang(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: _selectedMode == 1 ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Cash Flow Analysis Metrics
            Text(
              'ទិន្នន័យវាយតម្លៃលំហូរសាច់ប្រាក់ (Consented Cash Flow)',
              style: GoogleFonts.battambang(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    label: 'ចំណូល KHQR ចូល',
                    value: '+\$980',
                    subtext: 'មធ្យមប្រចាំខែ',
                    color: const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    label: 'ស្ថេរភាពសាច់ប្រាក់',
                    value: '94%',
                    subtext: 'មានស្ថេរភាពល្អ',
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
                    label: 'ប្រវត្តិបង់វិក្កយបត្រ',
                    value: '100%',
                    subtext: 'ទាន់ពេល 12 ខែ',
                    color: const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    label: 'កម្រិតសមាមាត្រ DTI',
                    value: '15%',
                    subtext: 'ហានិភ័យទាបបំផុត',
                    color: const Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Interactive Simulator
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
              child: _selectedMode == 0 ? _buildNanoLoanSimulator() : _buildBnplSimulator(),
            ),
            const SizedBox(height: 16),

            // Governance & Responsible Lending Reassurance Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF93C5FD)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.gavel_rounded, color: Color(0xFF2563EB), size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'អភិបាលកិច្ច & Responsible Lending៖ ការផ្តល់កម្ចីស្ថិតក្រោមការត្រួតពិនិត្យដោយមនុស្ស (Human-in-the-loop), AI Explainability, និងអនុលោមតាមបទប្បញ្ញត្តិធនាគារជាតិនៃកម្ពុជា (NBC)។',
                      style: GoogleFonts.battambang(
                        fontSize: 11.5,
                        color: const Color(0xFF1E40AF),
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0FA958),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 2,
                ),
                onPressed: _submitApplication,
                child: Text(
                  _selectedMode == 0
                      ? 'ស្នើសុំ Digital Nano-Loan ភ្លាមៗ (គ្មានទ្រព្យបញ្ចាំ)'
                      : 'ស្នើសុំបង់រំលស់ BNPL 0% ភ្លាមៗ',
                  style: GoogleFonts.battambang(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildNanoLoanSimulator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Digital Nano-Loan (សំណើ ៤.២)', style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD1FAE5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('គ្មានទ្រព្យបញ្ចាំ', style: GoogleFonts.battambang(fontSize: 11, color: const Color(0xFF065F46), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ទំហំកម្ចីស្នើសុំ (\$50 - \$1,000)', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
            Text(
              '\$${_loanAmount.toInt()}',
              style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958)),
            ),
          ],
        ),
        Slider(
          value: _loanAmount,
          min: 50,
          max: 1000,
          divisions: 19,
          activeColor: const Color(0xFF0FA958),
          onChanged: (val) => setState(() => _loanAmount = val),
        ),
        const SizedBox(height: 8),
        Text('រយៈពេលសង (Tenure)', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        Row(
          children: [3, 6, 12].map((tenure) {
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
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ប្រាក់ត្រូវសងប្រចាំខែប៉ាន់ស្មាន', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.black87)),
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
    );
  }

  Widget _buildBnplSimulator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Buy Now Pay Later (BNPL 0%)', style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('ការប្រាក់ 0%', style: GoogleFonts.battambang(fontSize: 11, color: const Color(0xFFB45309), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('ដៃគូពាណិជ្ជករក្នុងបណ្តាញ Chip Mong:', style: GoogleFonts.battambang(fontSize: 12, color: Colors.grey.shade700)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.storefront_rounded, size: 18, color: Color(0xFF0F172A)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _selectedBnplMerchant,
                  style: GoogleFonts.battambang(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('តម្លៃទំនិញបង់រំលស់', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
            Text(
              '\$${_bnplAmount.toStringAsFixed(0)}',
              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958)),
            ),
          ],
        ),
        Slider(
          value: _bnplAmount,
          min: 30,
          max: 300,
          divisions: 9,
          activeColor: const Color(0xFF0FA958),
          onChanged: (val) => setState(() => _bnplAmount = val),
        ),
        const SizedBox(height: 8),
        Text('ដំណាក់កាលបង់រំលស់ (0% Interest)', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        Row(
          children: [3, 6].map((months) {
            final isSelected = _bnplMonths == months;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _bnplMonths = months),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF0FA958) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '$months ខែ (0% APR)',
                      style: GoogleFonts.battambang(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('បង់ប្រចាំខែ (គ្មានការប្រាក់)', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.black87)),
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
          Text(label, style: GoogleFonts.battambang(fontSize: 11.5, color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(subtext, style: GoogleFonts.battambang(fontSize: 10.5, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
