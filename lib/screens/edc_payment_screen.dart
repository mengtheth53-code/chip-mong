import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'qr_screen.dart';
import 'success_screen.dart';

class EdcPaymentScreen extends StatefulWidget {
  final String fromAccount;
  final String accountBadge;
  final String billerTitle;
  final String billerCode;

  const EdcPaymentScreen({
    super.key,
    this.fromAccount = 'PREMIER ACCOUNT ••• 3840',
    this.accountBadge = 'គណនីគោល',
    this.billerTitle = 'អគ្គិសនីកម្ពុជា',
    this.billerCode = 'EDC',
  });

  @override
  State<EdcPaymentScreen> createState() => _EdcPaymentScreenState();
}

class _EdcPaymentScreenState extends State<EdcPaymentScreen> {
  static const Color _green = Color(0xFF0C6B38);
  static const Color _buttonGreen = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  final TextEditingController _consumerIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool _createTemplate = false;
  bool _autoPayment = false;

  bool get _canProceed =>
      _consumerIdController.text.trim().isNotEmpty &&
      _amountController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _consumerIdController.dispose();
    _amountController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFromAccountCard(),
                  const SizedBox(height: 12),
                  _buildConsumerIdCard(context),
                  const SizedBox(height: 12),
                  _buildAmountCard(),
                  const SizedBox(height: 18),
                  _buildSwitchRow(
                    title: 'បង្កើតគំរូទូទាត់',
                    subtitle: 'បង្កើតគំរូទូទាត់សម្រាប់ការធ្វើប្រតិបត្តិការរហ័ស',
                    value: _createTemplate,
                    onChanged: (val) => setState(() => _createTemplate = val),
                  ),
                  const SizedBox(height: 14),
                  _buildSwitchRow(
                    title: 'ប្រវត្តិប្រតិបត្តិការទូទាត់ស្វ័យប្រវត្តិ',
                    subtitle: 'ផ្ទេរប្រាក់និងទូទាត់នៅពេលក្រោយដោយស្វ័យប្រវត្តិ',
                    value: _autoPayment,
                    onChanged: (val) => setState(() => _autoPayment = val),
                  ),
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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B4E9B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue.shade100, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          widget.billerCode,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.billerTitle,
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
            'ពីគណនី',
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
                  widget.fromAccount,
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
                  widget.accountBadge,
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

  Widget _buildConsumerIdCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _consumerIdController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'លេខសម្គាល់អតិថិជន',
                hintStyle: GoogleFonts.battambang(
                  color: const Color(0xFF94A3B8),
                  fontSize: 15,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const QrScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.crop_free_rounded,
                color: Color(0xFF64748B),
                size: 24,
              ),
            ),
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

  Widget _buildSwitchRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.battambang(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.battambang(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          activeThumbColor: _buttonGreen,
          onChanged: onChanged,
        ),
      ],
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
                          accountLabel: 'អគ្គិសនីកម្ពុជា (EDC)',
                          accountNumber: _consumerIdController.text,
                          buttonLabel: 'ត្រឡប់ទៅទំព័រដើម',
                          successLabel: 'ទូទាត់វិក្កយបត្របានជោគជ័យ!',
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _buttonGreen,
              disabledBackgroundColor: const Color(0xFFD1D5DB),
              disabledForegroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              'ទូទាត់',
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
