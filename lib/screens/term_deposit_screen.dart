import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/transaction_receipt_sheet.dart';

class TermDepositScreen extends StatefulWidget {
  const TermDepositScreen({super.key});

  @override
  State<TermDepositScreen> createState() => _TermDepositScreenState();
}

class _TermDepositScreenState extends State<TermDepositScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  bool _isUsd = true;
  double _depositAmount = 5000.0;
  int _selectedTenureMonths = 12;
  String _rolloverOption = 'principal_interest'; // 'principal_interest', 'principal_only', 'close'

  final TextEditingController _amountController =
      TextEditingController(text: '5,000');

  // Rates for USD and KHR
  final Map<int, Map<String, double>> _tenureRates = {
    1: {'usd': 3.00, 'khr': 4.00},
    3: {'usd': 4.25, 'khr': 5.25},
    6: {'usd': 5.50, 'khr': 6.50},
    12: {'usd': 6.75, 'khr': 7.75},
    24: {'usd': 7.25, 'khr': 8.00},
    36: {'usd': 7.50, 'khr': 8.25},
  };

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double get _currentRate {
    final currencyKey = _isUsd ? 'usd' : 'khr';
    return _tenureRates[_selectedTenureMonths]?[currencyKey] ?? 6.75;
  }

  double get _totalInterest {
    // Interest = Principal * (Rate / 100) * (Months / 12)
    return _depositAmount * (_currentRate / 100) * (_selectedTenureMonths / 12);
  }

  double get _monthlyInterest {
    return _totalInterest / _selectedTenureMonths;
  }

  double get _maturityTotal {
    return _depositAmount + _totalInterest;
  }

  DateTime get _maturityDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month + _selectedTenureMonths, now.day);
  }

  void _onAmountChanged(String val) {
    final clean = val.replaceAll(',', '').replaceAll('\$', '').replaceAll('៛', '');
    final num = double.tryParse(clean) ?? 0.0;
    setState(() => _depositAmount = num);
  }

  void _addQuickAmount(double amount) {
    setState(() {
      _depositAmount += amount;
      _amountController.text = _formatNumber(_depositAmount);
    });
  }

  String _formatNumber(double num) {
    if (num >= 1000) {
      final parts = num.toStringAsFixed(0);
      final buffer = StringBuffer();
      for (int i = 0; i < parts.length; i++) {
        if (i > 0 && (parts.length - i) % 3 == 0) {
          buffer.write(',');
        }
        buffer.write(parts[i]);
      }
      return buffer.toString();
    }
    return num.toStringAsFixed(0);
  }

  void _confirmOpenAccount() {
    final currencySymbol = _isUsd ? '\$' : '៛ ';
    showTransactionReceiptSheet(
      context,
      title: 'បើកគណនីបញ្ញើជោគជ័យ!',
      subtitle: 'គណនីបញ្ញើមានកាលកំណត់ Chip Mong Bank ត្រូវបានបង្កើតដោយជោគជ័យ',
      amount: '$currencySymbol${_formatNumber(_depositAmount)}',
      date: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
      isIncome: true,
      referenceId: 'CMB-TD-2026-99081',
      fromAccount: 'Chip Mong CASA (•• 8899)',
      toAccount: 'គណនីបញ្ញើមានកាលកំណត់ ($_selectedTenureMonths ខែ)',
      remark: 'អត្រាការប្រាក់: ${_currentRate.toStringAsFixed(2)}% | ទទួលការប្រាក់: $currencySymbol${_totalInterest.toStringAsFixed(2)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencySymbol = _isUsd ? '\$' : '៛';

    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
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
                    // Header Banner with high interest badge
                    _buildHeroBanner(),
                    const SizedBox(height: 16),

                    // Amount & Currency Input
                    _buildAmountInput(currencySymbol),
                    const SizedBox(height: 16),

                    // Tenure Selection Pills
                    _buildTenureSelector(),
                    const SizedBox(height: 16),

                    // Live Calculator Result Card
                    _buildCalculatorSummaryCard(currencySymbol),
                    const SizedBox(height: 16),

                    // Payout & Rollover Preferences
                    _buildPayoutAndRolloverSection(),
                    const SizedBox(height: 20),

                    // Open Now Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _confirmOpenAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _darkGreen,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'បើកគណនីបញ្ញើឥឡូវនេះ (Open Term Deposit)',
                          style: GoogleFonts.battambang(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
          ),
          Text(
            'បញ្ញើមានកាលកំណត់ (Term Deposit)',
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0C8A45), Color(0xFF085329)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.savings_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ការប្រាក់ខ្ពស់រហូតដល់ 8.25% p.a.',
                  style: GoogleFonts.battambang(
                    color: const Color(0xFFFDE047),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'បើកគណនីបញ្ញើមានកាលកំណត់ភ្លាមៗ គ្មានកម្រៃសេវា និងមានសុវត្ថិភាព 100%',
                  style: GoogleFonts.battambang(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput(String currencySymbol) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ចំនួនទឹកប្រាក់បញ្ញើ (Principal Amount)',
                style: GoogleFonts.battambang(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              // Currency Toggle USD / KHR
              Container(
                height: 30,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isUsd = true;
                          _depositAmount = 5000.0;
                          _amountController.text = '5,000';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: _isUsd ? _darkGreen : Colors.transparent,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Text(
                          'USD',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _isUsd ? Colors.white : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isUsd = false;
                          _depositAmount = 20000000.0;
                          _amountController.text = '20,000,000';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: !_isUsd ? _darkGreen : Colors.transparent,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Text(
                          'KHR',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: !_isUsd ? Colors.white : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Main input field
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            onChanged: _onAmountChanged,
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E1E1E),
            ),
            decoration: InputDecoration(
              prefixText: '$currencySymbol ',
              prefixStyle: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _green,
              ),
              filled: true,
              fillColor: _bgGray,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 10),

          // Quick Chips
          Wrap(
            spacing: 8,
            children: [
              _buildQuickChip('+ 500', 500),
              _buildQuickChip('+ 1,000', 1000),
              _buildQuickChip('+ 5,000', 5000),
              _buildQuickChip('+ 10,000', 10000),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip(String label, double add) {
    return ActionChip(
      label: Text(label, style: GoogleFonts.roboto(fontSize: 11.5, fontWeight: FontWeight.bold)),
      backgroundColor: _bgGray,
      side: BorderSide.none,
      onPressed: () => _addQuickAmount(add),
    );
  }

  Widget _buildTenureSelector() {
    final currencyKey = _isUsd ? 'usd' : 'khr';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Text(
            'ជ្រើសរើសរយៈពេលបញ្ញើ (Tenure Period)',
            style: GoogleFonts.battambang(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: _tenureRates.keys.map((months) {
              final isSelected = _selectedTenureMonths == months;
              final rate = _tenureRates[months]?[currencyKey] ?? 0.0;

              return GestureDetector(
                onTap: () => setState(() => _selectedTenureMonths = months),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? _darkGreen : _bgGray,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? _darkGreen : Colors.transparent,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$months ខែ',
                        style: GoogleFonts.battambang(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : const Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: isSelected ? _green : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${rate.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : const Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorSummaryCard(String currencySymbol) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _green.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calculate_outlined, color: _green, size: 20),
              const SizedBox(width: 8),
              Text(
                'លទ្ធផលគណនាការប្រាក់ (Interest Calculation)',
                style: GoogleFonts.battambang(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          _buildSummaryRow('ប្រាក់ដើមបញ្ញើ:', '$currencySymbol ${_formatNumber(_depositAmount)}'),
          _buildSummaryRow('រយៈពេលបញ្ញើ:', '$_selectedTenureMonths ខែ'),
          _buildSummaryRow('អត្រាការប្រាក់ប្រចាំឆ្នាំ:', '${_currentRate.toStringAsFixed(2)}% p.a.'),
          _buildSummaryRow('ការប្រាក់ប្រចាំខែ (ជាមធ្យម):', '$currencySymbol ${_monthlyInterest.toStringAsFixed(2)} /ខែ'),
          _buildSummaryRow(
            'កាលបរិច្ឆេទដល់កំណត់:',
            '${_maturityDate.day}/${_maturityDate.month}/${_maturityDate.year}',
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ការប្រាក់ដែលនឹងទទួលបាន:',
                    style: GoogleFonts.battambang(
                      fontSize: 12.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    '+ $currencySymbol ${_totalInterest.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _green,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'ទឹកប្រាក់សរុបពេលដល់កំណត់:',
                    style: GoogleFonts.battambang(
                      fontSize: 12.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    '$currencySymbol ${_maturityTotal.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _darkGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutAndRolloverSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Text(
            'ជម្រើសបន្តកិច្ចសន្យា (Rollover Instruction)',
            style: GoogleFonts.battambang(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),

          // Option 1
          RadioListTile<String>(
            dense: true,
            contentPadding: EdgeInsets.zero,
            activeColor: _darkGreen,
            value: 'principal_interest',
            groupValue: _rolloverOption,
            title: Text(
              'បន្តប្រាក់ដើម + ការប្រាក់ (Renew Principal + Interest)',
              style: GoogleFonts.battambang(fontSize: 12.5),
            ),
            onChanged: (val) => setState(() => _rolloverOption = val!),
          ),

          // Option 2
          RadioListTile<String>(
            dense: true,
            contentPadding: EdgeInsets.zero,
            activeColor: _darkGreen,
            value: 'principal_only',
            groupValue: _rolloverOption,
            title: Text(
              'បន្តតែប្រាក់ដើម (ផ្ទេរការប្រាក់ចូលគណនីសន្សំ)',
              style: GoogleFonts.battambang(fontSize: 12.5),
            ),
            onChanged: (val) => setState(() => _rolloverOption = val!),
          ),

          // Option 3
          RadioListTile<String>(
            dense: true,
            contentPadding: EdgeInsets.zero,
            activeColor: _darkGreen,
            value: 'close',
            groupValue: _rolloverOption,
            title: Text(
              'ផ្ទេរប្រាក់ដើមនិងការប្រាក់ចូលគណនីសន្សំពេលដល់កំណត់',
              style: GoogleFonts.battambang(fontSize: 12.5),
            ),
            onChanged: (val) => setState(() => _rolloverOption = val!),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }
}
