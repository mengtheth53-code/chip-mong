import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountInfoScreen extends StatelessWidget {
  final String accountNumber;
  final String accountName;
  final String currency;
  final String balance;

  const AccountInfoScreen({
    super.key,
    this.accountNumber = '10163840',
    this.accountName = 'PREMIER ACCOUNT',
    this.currency = 'KHR',
    this.balance = '94.24 KHR',
  });

  static const Color _green = Color(0xFF0C6B38);
  static const Color _bgGray = Color(0xFFF2F4F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: Column(
        children: [
          _buildGreenHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('ព័ត៌មានគណនី'),
                  const SizedBox(height: 10),
                  _buildAccountDetailsCard(context),
                  const SizedBox(height: 22),
                  _buildSectionTitle('ទំហំទឹកប្រាក់ប្រតិបត្តិការ'),
                  const SizedBox(height: 10),
                  _buildTransactionLimitsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreenHeader(BuildContext context) {
    return Container(
      color: _green,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            children: [
              // Navigation bar
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Text(
                    'ព័ត៌មានគណនី',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Balance block
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ទឹកប្រាក់ដែលអាចមាន',
                    style: GoogleFonts.battambang(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white70,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                balance,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ទឹកប្រាក់សរុប: $balance',
                style: GoogleFonts.battambang(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.battambang(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildAccountDetailsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _buildDetailRow(
            label: 'លេខគណនី',
            valueWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  accountNumber,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: accountNumber));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('បានចម្លងលេខគណនី'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F1FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.copy_rounded,
                      color: Color(0xFF2A7CE8),
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _divider(),
          _buildDetailRow(
            label: 'ឈ្មោះគណនី',
            value: accountName,
          ),
          _divider(),
          _buildDetailRow(
            label: 'រូបិយប័ណ្ណ',
            value: currency,
          ),
          _divider(),
          _buildDetailRow(
            label: 'កាលបរិច្ឆេទបើកគណនី',
            value: 'Apr 13, 2026',
          ),
          _divider(),
          _buildDetailRow(
            label: 'អត្រាការប្រាក់ខ្ពស់',
            value: '1.25% p.a',
          ),
          _divider(),
          _buildDetailRow(
            label: 'លេខកូដសាខា',
            value: '007',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionLimitsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _buildDetailRow(
            label: 'ផ្ទេរប្រាក់ទៅគណនី ជីប\nម៉ុង ណាមួយ',
            value: '800,000,000 KHR',
          ),
          _divider(),
          _buildDetailRow(
            label: 'ផ្ទេរប្រាក់ក្រៅប្រទេស\nតាមរយៈប្រព័ន្ធ SWIFT',
            value: '200,000,000 KHR',
          ),
          _divider(),
          _buildDetailRow(
            label: 'ដកប្រាក់ដោយគ្មានប័ណ្ណ',
            value: '8,000,000 KHR',
          ),
          _divider(),
          _buildDetailRow(
            label: 'បញ្ចូលលុយទូរសព្ទ',
            value: '200,000 KHR',
          ),
          _divider(),
          _buildDetailRow(
            label: 'ផ្ទេរប្រាក់ទៅគណនីបាគង',
            value: '2,000,000 KHR',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Divider(height: 1, color: Color(0xFFF1F3F5)),
    );
  }

  Widget _buildDetailRow({
    required String label,
    String? value,
    Widget? valueWidget,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Text(
              label,
              style: GoogleFonts.battambang(
                fontSize: 14,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w400,
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerRight,
              child: valueWidget ??
                  Text(
                    value ?? '',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.battambang(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
