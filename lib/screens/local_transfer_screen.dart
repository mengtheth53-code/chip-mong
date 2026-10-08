import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'success_screen.dart';

class LocalTransferScreen extends StatefulWidget {
  final String fromAccountNumber;
  final String fromAccountName;

  const LocalTransferScreen({
    super.key,
    this.fromAccountNumber = 'PREMIER ACCOUNT ••• 3840',
    this.fromAccountName = 'គណនីគោល',
  });

  @override
  State<LocalTransferScreen> createState() => _LocalTransferScreenState();
}

class _LocalTransferScreenState extends State<LocalTransferScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  int _selectedBankIndex = 0;
  bool _isBakong = true;
  bool _isKHR = true;
  bool _isVerified = false;
  String _recipientName = '';
  bool _createTemplate = false;

  final List<Map<String, dynamic>> _banks = [
    {
      'name': 'Bakong Wallet',
      'khName': 'កាបូបលុយបាគង',
      'code': 'BAKONG',
      'color': Color(0xFFD32F2F),
      'icon': Icons.qr_code_2_rounded,
    },
    {
      'name': 'ABA Bank',
      'khName': 'ធនាគារ អេ ប៊ី អេ',
      'code': 'ABA',
      'color': Color(0xFF005A9C),
      'icon': Icons.account_balance,
    },
    {
      'name': 'ACLEDA Bank',
      'khName': 'ធនាគារ អេស៊ីលីដា',
      'code': 'ACLEDA',
      'color': Color(0xFF1E3A8A),
      'icon': Icons.account_balance,
    },
    {
      'name': 'Wing Bank',
      'khName': 'ធនាគារ វីង',
      'code': 'WING',
      'color': Color(0xFF84CC16),
      'icon': Icons.account_balance_wallet,
    },
    {
      'name': 'Canadia Bank',
      'khName': 'ធនាគារ កាណាឌីយ៉ា',
      'code': 'CNB',
      'color': Color(0xFFDC2626),
      'icon': Icons.account_balance,
    },
    {
      'name': 'Sathapana Bank',
      'khName': 'ធនាគារ សហគ្រាស',
      'code': 'SPB',
      'color': Color(0xFF0369A1),
      'icon': Icons.account_balance,
    },
    {
      'name': 'Prince Bank',
      'khName': 'ធនាគារ ព្រីនស៍',
      'code': 'PRINCE',
      'color': Color(0xFF6B21A8),
      'icon': Icons.account_balance,
    },
  ];

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_onAccountChanged);
    _amountController.addListener(() => setState(() {}));
  }

  void _onAccountChanged() {
    final text = _accountController.text.trim();
    if (text.length >= 8) {
      setState(() {
        _isVerified = true;
        _recipientName = 'SOKHA CHAN (សុខា ចាន់)';
      });
    } else {
      setState(() {
        _isVerified = false;
        _recipientName = '';
      });
    }
  }

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  bool get _canProceed =>
      _accountController.text.trim().isNotEmpty &&
      _amountController.text.trim().isNotEmpty;

  void _showBankPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.65,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ជ្រើសរើសធនាគារ ឬស្ថាប័ន',
                      style: GoogleFonts.battambang(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  itemCount: _banks.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, indent: 64),
                  itemBuilder: (_, index) {
                    final b = _banks[index];
                    final isSelected = _selectedBankIndex == index;
                    return ListTile(
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (b['color'] as Color).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          b['icon'] as IconData,
                          color: b['color'] as Color,
                          size: 22,
                        ),
                      ),
                      title: Text(
                        b['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        b['khName'] as String,
                        style: GoogleFonts.battambang(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: _green)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedBankIndex = index;
                          _isBakong = (b['code'] == 'BAKONG');
                        });
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onConfirmTransfer() {
    final bank = _banks[_selectedBankIndex];
    final currencySymbol = _isKHR ? 'KHR' : 'USD';
    final amountFormatted = '${_amountController.text.trim()} $currencySymbol';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'បញ្ជាក់ការផ្ទេរប្រាក់',
                  style: GoogleFonts.battambang(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildConfirmRow('ពីគណនី', widget.fromAccountNumber),
              _buildConfirmRow('ធនាគារទទួល', bank['name'] as String),
              _buildConfirmRow('លេខគណនីទទួល', _accountController.text.trim()),
              if (_recipientName.isNotEmpty)
                _buildConfirmRow('ឈ្មោះអ្នកទទួល', _recipientName),
              _buildConfirmRow('ចំនួនទឹកប្រាក់', amountFormatted, isHighlight: true),
              _buildConfirmRow('ថ្លៃសេវា', 'ឥតគិតថ្លៃ (0.00 USD)'),
              if (_remarkController.text.trim().isNotEmpty)
                _buildConfirmRow('សម្គាល់', _remarkController.text.trim()),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => SuccessScreen(
                          userName: _recipientName.isNotEmpty
                              ? _recipientName
                              : 'SOKHA CHAN',
                          accountLabel: bank['name'] as String,
                          accountNumber: _accountController.text.trim(),
                          buttonLabel: 'ត្រឡប់ទៅទំព័រដើម',
                          successLabel: 'ផ្ទេរប្រាក់បានជោគជ័យ!',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'ផ្ទេរប្រាក់ឥឡូវនេះ',
                    style: GoogleFonts.battambang(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildConfirmRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.battambang(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.battambang(
                fontSize: isHighlight ? 17 : 14,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
                color: isHighlight ? _green : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentBank = _banks[_selectedBankIndex];

    return Scaffold(
      backgroundColor: _bgGray,
      body: Column(
        children: [
          _buildGreenHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFromAccountCard(),
                  const SizedBox(height: 12),
                  _buildBankSelectorCard(currentBank),
                  const SizedBox(height: 12),
                  _buildRecipientInputCard(),
                  const SizedBox(height: 12),
                  _buildAmountInputCard(),
                  const SizedBox(height: 12),
                  _buildRemarkCard(),
                  const SizedBox(height: 14),
                  _buildTemplateSwitchCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildGreenHeader(BuildContext context) {
    return Container(
      color: _darkGreen,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
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
              Text(
                'ផ្ទេរប្រាក់ក្នុងស្រុក / បាគង',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFromAccountCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ពីគណនី',
            style: GoogleFonts.battambang(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: _green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.fromAccountNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'សមតុល្យដែលអាចប្រើបាន: \$ 2,540.50',
                      style: GoogleFonts.battambang(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.fromAccountName,
                  style: GoogleFonts.battambang(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBankSelectorCard(Map<String, dynamic> currentBank) {
    return GestureDetector(
      onTap: _showBankPicker,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ធនាគារ ឬស្ថាប័នទទួល',
              style: GoogleFonts.battambang(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: (currentBank['color'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    currentBank['icon'] as IconData,
                    color: currentBank['color'] as Color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentBank['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        currentBank['khName'] as String,
                        style: GoogleFonts.battambang(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black45,
                  size: 26,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipientInputCard() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isBakong ? 'លេខទូរស័ព្ទ / គណនីបាគង' : 'លេខគណនីធនាគារទទួល',
                style: GoogleFonts.battambang(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              const Icon(
                Icons.contacts_rounded,
                color: _green,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _accountController,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: _isBakong
                  ? 'ឧទាហរណ៍៖ 012 345 678 ឬ user@bakong'
                  : 'បញ្ចូលលេខគណនី',
              hintStyle: GoogleFonts.battambang(
                fontSize: 14,
                color: Colors.black38,
                fontWeight: FontWeight.normal,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
          if (_isVerified) ...[
            const Divider(height: 16),
            Row(
              children: [
                const Icon(Icons.check_circle, color: _green, size: 16),
                const SizedBox(width: 6),
                Text(
                  _recipientName,
                  style: GoogleFonts.battambang(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: _green,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountInputCard() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ចំនួនទឹកប្រាក់',
                style: GoogleFonts.battambang(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    _buildCurrencyToggle('KHR', _isKHR, () => setState(() => _isKHR = true)),
                    _buildCurrencyToggle('USD', !_isKHR, () => setState(() => _isKHR = false)),
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
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: const TextStyle(
                fontSize: 22,
                color: Colors.black26,
                fontWeight: FontWeight.w800,
              ),
              prefixText: _isKHR ? '៛ ' : '\$ ',
              prefixStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _green,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyToggle(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: active ? _green : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: active ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildRemarkCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'សម្គាល់ (ជាជម្រើស)',
            style: GoogleFonts.battambang(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _remarkController,
            style: GoogleFonts.battambang(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'បញ្ចូលសារសម្គាល់របស់អ្នក',
              hintStyle: GoogleFonts.battambang(
                fontSize: 13,
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

  Widget _buildTemplateSwitchCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'រក្សាទុកជាគំរូទូទាត់',
            style: GoogleFonts.battambang(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Switch(
            value: _createTemplate,
            activeThumbColor: _green,
            onChanged: (val) => setState(() => _createTemplate = val),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _canProceed ? _onConfirmTransfer : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _green,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: Text(
            'បន្ត',
            style: GoogleFonts.battambang(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _canProceed ? Colors.white : Colors.black38,
            ),
          ),
        ),
      ),
    );
  }
}
