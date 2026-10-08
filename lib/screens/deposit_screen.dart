import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'success_screen.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  bool _isKHR = true;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  int _selectedAccountIndex = 0;
  final List<Map<String, dynamic>> _accounts = [
    {
      'title': 'PREMIER ACCOUNT',
      'number': '10163840',
      'short': '••• 3840',
      'balance': '94.24 KHR',
      'hasBadge': true,
      'isKHR': true,
    },
    {
      'title': 'PREMIER ACCOUNT',
      'number': '10165272',
      'short': '••• 5272',
      'balance': '0.00 USD',
      'hasBadge': false,
      'isKHR': false,
    },
  ];

  bool get _canProceed => _amountController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedAcc = _accounts[_selectedAccountIndex];

    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Green Header with Title and Cardless Icon ────────────────
            _buildGreenHeader(context),

            // ── Scrollable Body Area ─────────────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // From Account Selector
                      _buildAccountSelector(selectedAcc),
                      const SizedBox(height: 12),

                      // Amount Input Card with USD / KHR toggle
                      _buildAmountInputCard(),
                      const SizedBox(height: 8),

                      // Range Helper Hint
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          _isKHR
                              ? 'ចំនួនទឹកប្រាក់ត្រូវតែចាប់ពី20,000 KHR ទៅ 8,000,000 KHR'
                              : 'ចំនួនទឹកប្រាក់ត្រូវតែចាប់ពី5.00 USD ទៅ 2,000.00 USD',
                          style: GoogleFonts.battambang(
                            fontSize: 13,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // ATM Banknote Info Banner
                      _buildInfoBanner(),
                      const SizedBox(height: 14),

                      // Remark / Note Input
                      _buildNoteInput(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Fixed Bottom Button: ដកប្រាក់ ───────────────────────────────────
      bottomNavigationBar: Container(
        color: _bgGray,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _canProceed
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SuccessScreen(
                          userName: 'MENG THETH',
                          accountLabel: 'លេខគណនី',
                          accountNumber: selectedAcc['number'] as String,
                          buttonLabel: 'ត្រឡប់ទៅទំព័រដើម',
                          successLabel: 'បង្កើតលេខកូដដកប្រាក់ជោគជ័យ!',
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              disabledBackgroundColor: const Color(0xFFD1D5DB),
              disabledForegroundColor: const Color(0xFF9CA3AF),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'ដកប្រាក់',
              style: GoogleFonts.battambang(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────
  Widget _buildGreenHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'ដកប្រាក់ដោយគ្មានប័ណ្ណ',
                  style: GoogleFonts.battambang(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF26A9D0),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.upload_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Account Selector Card ─────────────────────────────────────────────────
  Widget _buildAccountSelector(Map<String, dynamic> acc) {
    return GestureDetector(
      onTap: _showAccountPicker,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
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
            Text(
              'ពីគណនី',
              style: GoogleFonts.battambang(
                fontSize: 12.5,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${acc['title']} ••• ${acc['short'].toString().replaceAll('••• ', '')}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (acc['hasBadge'] as bool) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFF4E9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'គណនីគោល',
                            style: GoogleFonts.battambang(
                              fontSize: 11,
                              color: _green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF6B7280),
                  size: 22,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Account Picker Modal Bottom Sheet ────────────────────────────────────
  void _showAccountPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ពីគណនី',
                  style: GoogleFonts.battambang(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                for (int i = 0; i < _accounts.length; i++) ...[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAccountIndex = i;
                        _isKHR = _accounts[i]['isKHR'] as bool;
                      });
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 64,
                              color: _selectedAccountIndex == i
                                  ? _green
                                  : Colors.transparent,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          _accounts[i]['title'] as String,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        if (_accounts[i]['hasBadge'] as bool) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDFF4E9),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              'គណនីគោល',
                                              style: GoogleFonts.battambang(
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.bold,
                                                color: _green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${_accounts[i]['number']} | ${_accounts[i]['balance']}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Icon(
                                _selectedAccountIndex == i
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: _selectedAccountIndex == i
                                    ? _green
                                    : const Color(0xFF9CA3AF),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Amount Input Card with Currency Toggle ────────────────────────────────
  Widget _buildAmountInputCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
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
              Expanded(
                child: Text(
                  'ទឹកប្រាក់',
                  style: GoogleFonts.battambang(
                    fontSize: 14,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCurrencyChip(label: 'USD', active: !_isKHR),
                    _buildCurrencyChip(label: 'KHR', active: _isKHR),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyChip({required String label, required bool active}) {
    return GestureDetector(
      onTap: () {
        setState(() => _isKHR = label == 'KHR');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: active ? _green : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: active ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  // ── Info Banner: ATM Note ────────────────────────────────────────────────
  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6EC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF3E7C9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFFD97706),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'ATM ផ្តល់តែប្រភេទក្រដាសប្រាក់ ២០,០០០ រៀល និង ៥០,០០០ រៀល ប៉ុណ្ណោះ',
              style: GoogleFonts.battambang(
                fontSize: 13,
                color: const Color(0xFF92400E),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Note / Remark Input Card ─────────────────────────────────────────────
  Widget _buildNoteInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
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
      child: TextField(
        controller: _noteController,
        style: GoogleFonts.battambang(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          hintText: 'ចំណាំ ( មិនដាក់ក៏បាន )',
          hintStyle: GoogleFonts.battambang(
            fontSize: 14,
            color: const Color(0xFF9CA3AF),
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
