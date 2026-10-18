import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/transaction_receipt_sheet.dart';

class ChipMongLandPaymentScreen extends StatefulWidget {
  const ChipMongLandPaymentScreen({super.key});

  @override
  State<ChipMongLandPaymentScreen> createState() =>
      _ChipMongLandPaymentScreenState();
}

class _ChipMongLandPaymentScreenState extends State<ChipMongLandPaymentScreen>
    with SingleTickerProviderStateMixin {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);
  static const Color _red = Color(0xFFE52329);

  late final TabController _tabController;
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _contractController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _selectedProject = 'Grand Phnom Penh City';
  String _selectedPaymentType = 'បង់ប្រាក់រំលស់ផ្ទះ (Installment)';
  final String _selectedAccount = 'USD Account (•• 8899) - \$12,450.80';
  bool _billInquirySuccess = false;
  bool _isLoading = false;

  final List<String> _projects = [
    'Grand Phnom Penh City',
    'The Landmark 271 (ចំការដូង)',
    'The Landmark 60M (ផ្លូវ ៦០ ម៉ែត្រ)',
    'The Park Land 598 (ជា សុផារ៉ា)',
    'The Park Land Sen Sok (សែនសុខ)',
    'The Park Land 50M (ផ្លូវ ៥០ ម៉ែត្រ)',
    'The Park Land 6A (ជ្រោយចង្វារ)',
    'Land Riche Chamkar Doung',
  ];

  final List<String> _paymentTypes = [
    'បង់ប្រាក់រំលស់ផ្ទះ (Installment)',
    'ថ្លៃសេវាគ្រប់គ្រងបុរី (Management Fee)',
    'ថ្លៃទឹកប្រើប្រាស់ក្នុងបុរី (Water Supply)',
    'ថ្លៃកក់ផ្ទះ ឬទូទាត់មុន (Advance Deposit)',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _unitController.dispose();
    _contractController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _inquireBill() {
    if (_unitController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'សូមបញ្ចូលលេខផ្ទះ ឬលេខកូដសម្គាល់ផ្ទះ',
            style: GoogleFonts.battambang(),
          ),
          backgroundColor: Colors.orange.shade800,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _billInquirySuccess = true;
        _amountController.text = '1,250.00';
      });
    });
  }

  void _processPayment() {
    showTransactionReceiptSheet(
      context,
      title: 'ទូទាត់ជោគជ័យ!',
      subtitle: 'ការទូទាត់ប្រាក់ជូនក្រុមហ៊ុន Chip Mong Land បានជោគជ័យ',
      amount: '\$${_amountController.text.isEmpty ? "1,250.00" : _amountController.text}',
      date: '18 តុលា 2026, 17:40',
      isIncome: false,
      referenceId: 'CML-TXN-984210',
      fromAccount: _selectedAccount,
      toAccount: '$_selectedProject - ${_unitController.text.isEmpty ? "#A-28" : _unitController.text}',
      remark: _selectedPaymentType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            _buildEcosystemHeader(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildChipMongLandTab(),
                    _buildChipMongRetailTab(),
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
            'ពាណិជ្ជកម្ម ជីប ម៉ុង',
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEcosystemHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.apartment_rounded, color: _darkGreen, size: 28),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chip Mong Group Synergy',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ទូទាត់វិក្កយបត្របុរី ផ្សារទំនើប និងដៃគូពាណិជ្ជកម្ម',
                      style: GoogleFonts.battambang(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: GoogleFonts.battambang(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: 'បុរី ជីប ម៉ុង (Land)'),
            Tab(text: 'ផ្សារទំនើប ជីប ម៉ុង (Retail)'),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget _buildChipMongLandTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Project Dropdown Card
        _buildInputContainer(
          label: 'ជ្រើសរើសគម្រោងបុរី (Project)',
          icon: Icons.location_city_rounded,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedProject,
              icon: const Icon(Icons.keyboard_arrow_down, color: _darkGreen),
              style: GoogleFonts.battambang(
                color: const Color(0xFF1E1E1E),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              items: _projects.map((p) {
                return DropdownMenuItem(value: p, child: Text(p));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedProject = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Payment Type Dropdown Card
        _buildInputContainer(
          label: 'ប្រភេទនៃការទូទាត់ (Payment Type)',
          icon: Icons.payments_outlined,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedPaymentType,
              icon: const Icon(Icons.keyboard_arrow_down, color: _darkGreen),
              style: GoogleFonts.battambang(
                color: const Color(0xFF1E1E1E),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              items: _paymentTypes.map((t) {
                return DropdownMenuItem(value: t, child: Text(t));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedPaymentType = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Unit / House Number Input
        _buildInputContainer(
          label: 'លេខផ្ទះ ឬយូនីត (House / Unit No.)',
          icon: Icons.home_rounded,
          child: TextField(
            controller: _unitController,
            decoration: InputDecoration(
              hintText: 'ឧទាហរណ៍៖ #A-28, ផ្លូវ 10M',
              hintStyle: GoogleFonts.battambang(color: Colors.grey.shade400, fontSize: 13),
              border: InputBorder.none,
              isDense: true,
            ),
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Contract No (Optional)
        _buildInputContainer(
          label: 'លេខកិច្ចសន្យា (Contract ID - ស្រេចចិត្ត)',
          icon: Icons.description_outlined,
          child: TextField(
            controller: _contractController,
            decoration: InputDecoration(
              hintText: 'ឧទាហរណ៍៖ CML-2024-8890',
              hintStyle: GoogleFonts.battambang(color: Colors.grey.shade400, fontSize: 13),
              border: InputBorder.none,
              isDense: true,
            ),
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Inquire Bill Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _inquireBill,
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                  )
                : Text(
                    'ត្រួតពិនិត្យវិក្កយបត្រ (Inquire Bill)',
                    style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
        const SizedBox(height: 20),

        // Bill Summary Card if queried
        if (_billInquirySuccess) ...[
          Container(
            padding: const EdgeInsets.all(16),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _green.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'វិក្កយបត្រត្រូវបង់',
                        style: GoogleFonts.battambang(
                          color: _green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'កាលកំណត់: 25 តុលា 2026',
                      style: GoogleFonts.battambang(fontSize: 11.5, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildBillRow('ម្ចាស់អចលនទ្រព្យ:', 'ម៉េង ថេត (MENG THETH)'),
                _buildBillRow('គម្រោង:', _selectedProject),
                _buildBillRow('លេខផ្ទះ/យូនីត:', _unitController.text.isEmpty ? '#A-28' : _unitController.text),
                _buildBillRow('ប្រភេទសេវា:', _selectedPaymentType),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ទឹកប្រាក់ត្រូវបង់:',
                      style: GoogleFonts.battambang(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    Text(
                      '\$1,250.00',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Account Pay Source
                Text(
                  'គណនីទូទាត់ (Source Account)',
                  style: GoogleFonts.battambang(fontSize: 12, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: _bgGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance_wallet, color: _darkGreen, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedAccount,
                          style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Pay Now button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _darkGreen,
                      foregroundColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'បញ្ជាក់ការទូទាត់ (\$1,250.00)',
                          style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _buildChipMongRetailTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C8A45).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.storefront_rounded, color: Color(0xFF0C8A45)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chip Mong Supermarket & Mall',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                        Text(
                          'ទូទាត់វិក្កយបត្រផ្សារទំនើប និងសន្សំពិន្ទុ',
                          style: GoogleFonts.battambang(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Text(
                'លេខកូដសមាជិក ឬលេខវិក្កយបត្រ (Invoice / Member ID)',
                style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'បញ្ចូលលេខវិក្កយបត្រផ្សារទំនើប ឬស្កេន',
                  hintStyle: GoogleFonts.battambang(fontSize: 13, color: Colors.grey.shade400),
                  suffixIcon: const Icon(Icons.qr_code_scanner, color: _green),
                  filled: true,
                  fillColor: _bgGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'បានភ្ជាប់ជាមួយគណនី Chip Mong Mall Member: ម៉េង ថេត (ពិន្ទុ: 2,450 pts)',
                          style: GoogleFonts.battambang(),
                        ),
                        backgroundColor: _darkGreen,
                      ),
                    );
                  },
                  icon: const Icon(Icons.search, size: 20),
                  label: Text(
                    'ស្វែងរកវិក្កយបត្រ',
                    style: GoogleFonts.battambang(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _darkGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputContainer({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
          Row(
            children: [
              Icon(icon, color: _green, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.battambang(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700),
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
