import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'success_screen.dart';

class MySelfTransferScreen extends StatefulWidget {
  final String currentAccount;
  final String accountType;

  const MySelfTransferScreen({
    super.key,
    this.currentAccount = 'PREMIER ACCOUNT ••• 3840',
    this.accountType = 'គណនីគោល',
  });

  @override
  State<MySelfTransferScreen> createState() => _MySelfTransferScreenState();
}

class _MySelfTransferScreenState extends State<MySelfTransferScreen> {
  static const Color _green = Color(0xFF0C6B38);
  static const Color _bgGray = Color(0xFFF2F4F7);

  String? _selectedFromAccount;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<String> _myAccounts = [
    'SAVINGS ACCOUNT ••• 1016',
    'CURRENT ACCOUNT ••• 5272',
    'PAYROLL ACCOUNT ••• 9988',
  ];

  bool get _canProceed =>
      _selectedFromAccount != null && _amountController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: Column(
        children: [
          _buildGreenHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                children: [
                  _buildFromAccountCard(),
                  const SizedBox(height: 12),
                  _buildToAccountCard(),
                  const SizedBox(height: 12),
                  _buildAmountCard(),
                  const SizedBox(height: 12),
                  _buildNoteCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  Widget _buildGreenHeader(BuildContext context) {
    return Container(
      color: _green,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1EA75B),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'ផ្ទេរប្រាក់ទៅគណនីខ្លួនឯង',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFromAccountCard() {
    return GestureDetector(
      onTap: _showSelectFromAccountModal,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedFromAccount ?? 'ពីគណនី',
              style: GoogleFonts.battambang(
                fontSize: 15,
                color: _selectedFromAccount != null
                    ? Colors.black87
                    : const Color(0xFF94A3B8),
                fontWeight: _selectedFromAccount != null
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF64748B),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectFromAccountModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ជ្រើសរើសពីគណនី',
                style: GoogleFonts.battambang(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ..._myAccounts.map(
                (acc) => ListTile(
                  title: Text(acc),
                  trailing: _selectedFromAccount == acc
                      ? const Icon(Icons.check, color: Color(0xFF0FA958))
                      : null,
                  onTap: () {
                    setState(() => _selectedFromAccount = acc);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToAccountCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ទៅគណនី',
            style: GoogleFonts.battambang(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.currentAccount,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6F0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.accountType,
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    color: const Color(0xFF0C6B38),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF64748B),
                size: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'ទឹកប្រាក់',
          hintStyle: GoogleFonts.battambang(
            color: const Color(0xFF94A3B8),
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _noteController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'ចំណាំ ( មិនដាក់ក៏បាន )',
          hintStyle: GoogleFonts.battambang(
            color: const Color(0xFF94A3B8),
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      color: _bgGray,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _canProceed
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SuccessScreen(
                          userName: 'MENG THETH',
                          accountLabel: 'PREMIER ACCOUNT',
                          accountNumber: widget.currentAccount,
                          buttonLabel: 'ត្រឡប់ទៅទំព័រដើម',
                          successLabel: 'ផ្ទេរប្រាក់បានជោគជ័យ!',
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0FA958),
              disabledBackgroundColor: const Color(0xFFD1D5DB),
              disabledForegroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              'ផ្ទេរប្រាក់',
              style: GoogleFonts.battambang(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
