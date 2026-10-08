import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'success_screen.dart';

class InternationalTransferScreen extends StatefulWidget {
  const InternationalTransferScreen({super.key});

  @override
  State<InternationalTransferScreen> createState() => _InternationalTransferScreenState();
}

class _InternationalTransferScreenState extends State<InternationalTransferScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  final TextEditingController _countryController = TextEditingController(text: 'សហរដ្ឋអាមេរិក (USA)');
  final TextEditingController _beneficiaryNameController = TextEditingController();
  final TextEditingController _swiftController = TextEditingController();
  final TextEditingController _accountIbanController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  bool get _canProceed =>
      _beneficiaryNameController.text.trim().isNotEmpty &&
      _swiftController.text.trim().isNotEmpty &&
      _accountIbanController.text.trim().isNotEmpty &&
      _amountController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _beneficiaryNameController.addListener(() => setState(() {}));
    _swiftController.addListener(() => setState(() {}));
    _accountIbanController.addListener(() => setState(() {}));
    _amountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _countryController.dispose();
    _beneficiaryNameController.dispose();
    _swiftController.dispose();
    _accountIbanController.dispose();
    _amountController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final amountText = '${_amountController.text.trim()} USD';
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SuccessScreen(
          userName: _beneficiaryNameController.text.trim(),
          accountLabel: 'SWIFT (${_swiftController.text.trim()})',
          accountNumber: _accountIbanController.text.trim(),
          buttonLabel: 'ត្រឡប់ទៅទំព័រដើម',
          successLabel: 'ផ្ទេរប្រាក់ $amountText បានជោគជ័យ!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      appBar: AppBar(
        backgroundColor: _darkGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ផ្ទេរប្រាក់ទៅក្រៅប្រទេស (SWIFT)',
          style: GoogleFonts.battambang(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notice card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _green.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: _green, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'ការផ្ទេរប្រាក់អន្តរជាតិអាចចំណាយពេលពី ១ ទៅ ៣ ថ្ងៃនៃថ្ងៃធ្វើការ។ ថ្លៃសេវាចាប់ពី ១៥ ដុល្លារ។',
                      style: GoogleFonts.battambang(
                        fontSize: 12.5,
                        color: _darkGreen,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            _buildInputSection('ប្រទេសទទួល', _countryController, 'ជ្រើសរើសប្រទេស', icon: Icons.public),
            const SizedBox(height: 12),
            _buildInputSection('ឈ្មោះអ្នកទទួល (អក្សរឡាតាំង)', _beneficiaryNameController, 'ឈ្មោះពេញដូចក្នុងលិខិតឆ្លងដែន', icon: Icons.person_outline),
            const SizedBox(height: 12),
            _buildInputSection('SWIFT / BIC Code', _swiftController, 'ឧទាហរណ៍៖ CHASUS33', icon: Icons.account_balance),
            const SizedBox(height: 12),
            _buildInputSection('លេខគណនី ឬ IBAN', _accountIbanController, 'បញ្ចូលលេខ IBAN / គណនី', icon: Icons.credit_card),
            const SizedBox(height: 12),
            _buildInputSection('ចំនួនទឹកប្រាក់ (USD)', _amountController, '0.00', icon: Icons.attach_money, isNumber: true),
            const SizedBox(height: 12),
            _buildInputSection('គោលបំណងផ្ទេរប្រាក់', _purposeController, 'ឧទាហរណ៍៖ ការចំណាយលើការសិក្សា, ការផ្គត់ផ្គង់គ្រួសារ', icon: Icons.description_outlined),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _canProceed ? _onSubmit : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: Text(
              'បញ្ជាក់ការផ្ទេរប្រាក់',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _canProceed ? Colors.white : Colors.black38,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(
    String label,
    TextEditingController controller,
    String hint, {
    IconData? icon,
    bool isNumber = false,
  }) {
    return Container(
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
              if (icon != null) ...[
                Icon(icon, size: 18, color: _green),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: GoogleFonts.battambang(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType: isNumber
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.battambang(
                fontSize: 13.5,
                color: Colors.black38,
              ),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}
