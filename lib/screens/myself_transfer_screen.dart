import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class MySelfTransferScreen extends StatefulWidget {
  const MySelfTransferScreen({super.key});

  @override
  State<MySelfTransferScreen> createState() => _MySelfTransferScreenState();
}

class _MySelfTransferScreenState extends State<MySelfTransferScreen> {
  static const Color primaryGreen = Color(0xFF1A6B3C);
  static const Color darkGreen = Color(0xFF145430);

  String? selectedToAccount;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<String> toAccountOptions = [
    'PREMIER ACCOUNT ••• 1234',
    'SAVINGS ACCOUNT ••• 5678',
    'CURRENT ACCOUNT ••• 9012',
  ];

  bool get _isFormValid =>
      selectedToAccount != null &&
      _amountController.text.isNotEmpty;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              child: Column(
                children: [
                  // From Account
                  _buildFromAccountCard(),
                  const SizedBox(height: 12),
                  // To Account dropdown
                  _buildDropdownCard(),
                  const SizedBox(height: 12),
                  // Amount field
                  _buildInputCard(
                    controller: _amountController,
                    hint: 'ទឹកប្រាក់',
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  // Note field
                  _buildInputCard(
                    controller: _noteController,
                    hint: 'ចំណាំ (មិនដាក់ក៏បាន)',
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: primaryGreen,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button row
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ],
              ),
              // Title + icon row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Expanded(
                      child: Text(
                        'ផ្ទេរប្រាក់ទៅគណនីខ្លួនឯង',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.manage_accounts_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFromAccountCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'ពីគណនី',
            style: GoogleFonts.battambang(
              fontSize: 18,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
               Expanded(
                child: Text(
                  'PREMIER ACCOUNT ••• 3840',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF2E8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  Text(
                  'គណនីគោល',
                  style: GoogleFonts.battambang(
                    color: Color(0xFF1A6B3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF1A6B3C), size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedToAccount,
          hint:  Text(
            'ទៅគណនី',
            style:GoogleFonts.battambang(
              fontSize: 18,
              color: Color(0xFFAAAAAA),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF1A6B3C)),
          items: toAccountOptions
              .map((account) => DropdownMenuItem(
                    value: account,
                    child: Text(
                      account,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (value) => setState(() => selectedToAccount = value),
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style:  GoogleFonts.battambang(
          fontSize: 18,
          color: Color(0xFF1A1A1A),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle:  GoogleFonts.battambang(
            color: Color(0xFFAAAAAA),
            fontSize: 18,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  
}
