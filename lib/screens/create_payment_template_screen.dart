import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_template_forms_screen.dart';
import 'edc_payment_screen.dart';

class CreatePaymentTemplateScreen extends StatefulWidget {
  const CreatePaymentTemplateScreen({super.key});

  @override
  State<CreatePaymentTemplateScreen> createState() =>
      _CreatePaymentTemplateScreenState();
}

class _CreatePaymentTemplateScreenState
    extends State<CreatePaymentTemplateScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'បង្កើតគំរូទូទាត់',
          style: GoogleFonts.battambang(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search Bar ──────────────────────────────────────────────
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Color(0xFF9CA3AF),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // ── Section 1: ផ្ទេរ (Transfers) ─────────────────────────────
            Text(
              'ផ្ទេរ',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildTransferTile(
                    iconWidget: _buildBakongIcon(),
                    title: 'ផ្ទេរប្រាក់ទៅគណនីបាគង',
                    subtitle: 'ផ្ទេរប្រាក់ទៅគណនីបាគង',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CreateBakongTemplateScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 64, color: Color(0xFFF0F0F0)),
                  _buildTransferTile(
                    iconWidget: _buildSwiftIcon(),
                    title: 'ក្រៅប្រទេសតាមរយៈប្រព័ន្ធ SWIFT',
                    subtitle: null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CreateSwiftTemplateScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 64, color: Color(0xFFF0F0F0)),
                  _buildTransferTile(
                    iconWidget: _buildChipMongTransferIcon(),
                    title: 'ផ្ទេរប្រាក់ទៅគណនី ជីប ម៉ុង ណាមួយ',
                    subtitle: 'ទៅគណនីធនាគារជីបម៉ុង',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CreateChipMongTemplateScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 64, color: Color(0xFFF0F0F0)),
                  _buildTransferTile(
                    iconWidget: _buildBankIcon(),
                    title: 'ផ្ទេរប្រាក់ទៅគណនីធនាគារ',
                    subtitle: null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CreateBakongTemplateScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // ── Section 2: ទូទាត់ (Payments) ─────────────────────────────
            Text(
              'ទូទាត់',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildPaymentTile(
                    iconWidget: _buildChipMongLandIcon(),
                    title: 'ក្រុមហ៊ុន ជីប ម៉ុង លែន',
                    subtitle: null,
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 64, color: Color(0xFFF0F0F0)),
                  _buildPaymentTile(
                    iconWidget: _buildFwdIcon(),
                    title: 'អាយុជីវិតវែលយូឌី ខេមបូឌា',
                    subtitle: 'អាយុជីវិតវែលយូឌី ខេមបូឌា',
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 64, color: Color(0xFFF0F0F0)),
                  _buildPaymentTile(
                    iconWidget: _buildEdcIcon(),
                    title: 'អគ្គិសនីកម្ពុជា',
                    subtitle: null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EdcPaymentScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferTile({
    required Widget iconWidget,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.battambang(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.battambang(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTile({
    required Widget iconWidget,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.battambang(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.battambang(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Icons ────────────────────────────────────────────────────────────────
  Widget _buildBakongIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE52329),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.brightness_7,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildSwiftIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF0072CE),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Text(
        'SWIFT',
        style: TextStyle(
          color: Colors.white,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildChipMongTransferIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF5AB64A),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.swap_horiz_rounded,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildBankIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF0C8A4A),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.account_balance_rounded,
        color: Colors.white,
        size: 22,
      ),
    );
  }

  Widget _buildChipMongLandIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE2F5EC),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF0C8A4A), width: 1.5),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.apartment, color: Color(0xFF0C8A4A), size: 16),
          Text(
            'LAND',
            style: TextStyle(
              fontSize: 6.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C8A4A),
              height: 0.9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFwdIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFE87722),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'FWD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          Text(
            'insurance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 5.5,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEdcIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF0FA958), width: 1.5),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.flash_on,
        color: Color(0xFF0FA958),
        size: 22,
      ),
    );
  }
}
