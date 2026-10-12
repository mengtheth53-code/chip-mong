import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isKhmer = true;

  // Scan simulation state
  bool _isScanning = false;
  bool _scanSuccess = false;
  String _selectedBiometricType = 'fingerprint'; // 'fingerprint' or 'face'
  double _quickPayLimit = 500.0;
  bool _enableBiometricLogin = true;
  bool _enableBiometricPay = true;

  // Quick Pay simulator state
  double _selectedPayAmount = 24.50;
  String _selectedMerchant = 'Chip Mong Supermarket (ផ្សារទំនើប ជីប ម៉ុង)';
  String _selectedItemName = 'Grocery Express & Snacks';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _simulateLoginScan() {
    if (_isScanning) return;
    setState(() {
      _isScanning = true;
      _scanSuccess = false;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _isScanning = false;
        _scanSuccess = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF065F46),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF34D399), size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _isKhmer
                      ? 'ផ្ទៀងផ្ទាត់ជីវមាត្រជោគជ័យក្នុងរយៈពេល 0.78 វិនាទី!'
                      : 'Biometric Authenticated Successfully in 0.78s!',
                  style: GoogleFonts.battambang(fontSize: 13, color: Colors.white),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _showBiometricPaySheet() {
    final bool isEligible = _selectedPayAmount <= _quickPayLimit;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        bool localScanning = false;
        bool localSuccess = false;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Header Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: isEligible
                          ? const Color(0xFFD1FAE5)
                          : const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isEligible ? Icons.bolt_rounded : Icons.lock_outline_rounded,
                          size: 16,
                          color: isEligible ? const Color(0xFF047857) : const Color(0xFFB45309),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isEligible
                              ? (_isKhmer ? 'ទូទាត់រហ័ស Biometrics (< \$500)' : 'Biometric Quick Pay (< \$500)')
                              : (_isKhmer ? 'ទំហំលើស \$500 (ត្រូវការ PIN/OTP)' : 'Over \$500 Limit (Requires PIN/OTP)'),
                          style: GoogleFonts.battambang(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isEligible ? const Color(0xFF047857) : const Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Merchant info
                  Text(
                    _selectedMerchant,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.battambang(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _selectedItemName,
                    style: GoogleFonts.battambang(
                      fontSize: 13,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Amount
                  Text(
                    '\$${_selectedPayAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (isEligible) ...[
                    // Biometric sensor prompt
                    GestureDetector(
                      onTap: () {
                        if (localScanning || localSuccess) return;
                        setSheetState(() => localScanning = true);
                        Future.delayed(const Duration(milliseconds: 800), () {
                          if (!context.mounted) return;
                          setSheetState(() {
                            localScanning = false;
                            localSuccess = true;
                          });
                          Future.delayed(const Duration(milliseconds: 700), () {
                            if (!context.mounted) return;
                            Navigator.pop(ctx);
                            _showReceiptDialog();
                          });
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: localSuccess
                              ? const Color(0xFFD1FAE5)
                              : const Color(0xFFF0FDF4),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: localSuccess
                                ? const Color(0xFF10B981)
                                : const Color(0xFF34D399),
                            width: 2,
                          ),
                        ),
                        child: localScanning
                            ? const SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Color(0xFF059669),
                                ),
                              )
                            : Icon(
                                localSuccess
                                    ? Icons.check_circle_rounded
                                    : (_selectedBiometricType == 'fingerprint'
                                        ? Icons.fingerprint_rounded
                                        : Icons.face_retouching_natural_rounded),
                                size: 54,
                                color: localSuccess
                                    ? const Color(0xFF059669)
                                    : AppColors.primaryGreen,
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localSuccess
                          ? (_isKhmer ? '✅ ផ្ទៀងផ្ទាត់ជោគជ័យ! កំពុងចេញបង្កាន់ដៃ...' : '✅ Verified! Issuing receipt...')
                          : localScanning
                              ? (_isKhmer ? 'កំពុងស្កេនជីវមាត្រ...' : 'Scanning Biometric...')
                              : (_isKhmer
                                  ? 'ចុចលើរូបក្រយៅដៃដើម្បីអនុម័ត (គ្មាន PIN / OTP)'
                                  : 'Tap sensor icon to sign transaction (No PIN / OTP)'),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.battambang(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: localSuccess ? const Color(0xFF047857) : const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isKhmer
                          ? 'ប្រតិបត្តិការត្រូវបានចុះហត្ថលេខាឌីជីថលដោយ Secure Enclave របស់ទូរស័ព្ទ'
                          : 'Cryptographically signed via device hardware Secure Enclave',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.battambang(
                        fontSize: 11,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ] else ...[
                    // Over limit warning
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFFECACA)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.shield_outlined, color: Color(0xFFDC2626), size: 32),
                          const SizedBox(height: 8),
                          Text(
                            _isKhmer
                                ? 'ទឹកប្រាក់លើស \$500 ត្រូវផ្ទៀងផ្ទាត់ដោយលេខ PIN ៦ ខ្ទង់ និងសារ SMS OTP ដើម្បីធានាសុវត្ថិភាពខ្ពស់បំផុត។'
                                : 'Amounts exceeding \$500 require standard 6-digit PIN and SMS OTP verification for heightened security.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.battambang(
                              fontSize: 12.5,
                              color: const Color(0xFF991B1B),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F172A),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isKhmer
                                    ? 'ប្តូរទៅកាន់ផ្ទាំងវាយ PIN & SMS OTP ធម្មតា'
                                    : 'Redirected to standard PIN & SMS OTP flow',
                                style: GoogleFonts.battambang(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.pin, color: Colors.white, size: 20),
                        label: Text(
                          _isKhmer ? 'វាយលេខ PIN & ទទួល SMS OTP' : 'Enter 6-Digit PIN & SMS OTP',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showReceiptDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Color(0xFFD1FAE5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Color(0xFF059669), size: 36),
              ),
              const SizedBox(height: 14),
              Text(
                _isKhmer ? 'ទូទាត់ជោគជ័យ!' : 'Payment Successful!',
                style: GoogleFonts.battambang(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF065F46),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _isKhmer ? 'អនុម័តដោយការស្កេនជីវមាត្ររហ័ស' : 'Approved via Biometric Instant Signing',
                style: GoogleFonts.battambang(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildReceiptRow(_isKhmer ? 'អ្នកទទួល' : 'Merchant', _selectedMerchant),
                    const Divider(height: 18),
                    _buildReceiptRow(_isKhmer ? 'ទឹកប្រាក់' : 'Amount', '\$${_selectedPayAmount.toStringAsFixed(2)}'),
                    const Divider(height: 18),
                    _buildReceiptRow(_isKhmer ? 'វិធីផ្ទៀងផ្ទាត់' : 'Auth Method', 'Biometric ($_selectedBiometricType)'),
                    const Divider(height: 18),
                    _buildReceiptRow(_isKhmer ? 'រយៈពេល' : 'Signing Time', '0.78s (Instant)'),
                    const Divider(height: 18),
                    _buildReceiptRow(_isKhmer ? 'ថ្លៃដើម SMS' : 'SMS Cost', '\$0.00 (Saved \$0.03)'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    _isKhmer ? 'រួចរាល់ (Done)' : 'Done',
                    style: GoogleFonts.battambang(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.battambang(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.battambang(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.fingerprint_rounded, color: Color(0xFF34D399), size: 20),
                const SizedBox(width: 8),
                Text(
                  _isKhmer ? 'ការផ្ទៀងផ្ទាត់ជីវមាត្រ' : 'Biometric Authentication',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Innovation 01 • Fingerprint & Face Recognition',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _isKhmer = !_isKhmer),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white60, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isKhmer ? '🇰🇭 ខ្មែរ' : '🇬🇧 EN',
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.swap_horiz, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF34D399),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: GoogleFonts.battambang(fontSize: 12.5, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: _isKhmer ? 'ចូលប្រើ ១ វិនាទី' : 'Quick Login'),
            Tab(text: _isKhmer ? 'ទូទាត់ < \$500' : 'Quick Pay < \$500'),
            Tab(text: _isKhmer ? 'ការកំណត់ & សុវត្ថិភាព' : 'Security & Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildQuickLoginTab(),
          _buildQuickPayTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  // TAB 1: QUICK LOGIN SIMULATOR
  Widget _buildQuickLoginTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner pitch
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF064E3B), Color(0xFF047857)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flash_on_rounded, color: Color(0xFFFBBF24), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      _isKhmer ? 'ចូលប្រើ App ត្រឹមតែ ១ វិនាទី' : '1-Second Instant App Login',
                      style: GoogleFonts.battambang(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _isKhmer
                      ? 'លែងបារម្ភរឿងភ្លេចលេខកូដសម្ងាត់ PIN/Password ឬអ្នកដទៃលួចមើលនៅទីសាធារណៈ (Shoulder Surfing)។ គ្រាន់តែដាក់មេដៃ ឬស្កេនផ្ទៃមុខ ដើម្បីចូលប្រើប្រាស់គណនីភ្លាមៗ។'
                      : 'Eliminate forgotten passwords and public shoulder-surfing vulnerabilities. Simply present your fingerprint or face to authenticate securely in under 1 second.',
                  style: GoogleFonts.battambang(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Selector: Face ID vs Fingerprint
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selectedBiometricType = 'fingerprint';
                    _scanSuccess = false;
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedBiometricType == 'fingerprint'
                          ? AppColors.primaryGreen
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _selectedBiometricType == 'fingerprint'
                            ? AppColors.primaryGreen
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fingerprint_rounded,
                          color: _selectedBiometricType == 'fingerprint' ? Colors.white : Colors.black87,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isKhmer ? 'ក្រយៅដៃ (Fingerprint)' : 'Fingerprint',
                          style: GoogleFonts.battambang(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: _selectedBiometricType == 'fingerprint' ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selectedBiometricType = 'face';
                    _scanSuccess = false;
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedBiometricType == 'face'
                          ? AppColors.primaryGreen
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _selectedBiometricType == 'face'
                            ? AppColors.primaryGreen
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.face_retouching_natural_rounded,
                          color: _selectedBiometricType == 'face' ? Colors.white : Colors.black87,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isKhmer ? 'ផ្ទៃមុខ (Face ID)' : 'Face Recognition',
                          style: GoogleFonts.battambang(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: _selectedBiometricType == 'face' ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Central Scanner Simulator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _simulateLoginScan,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: _scanSuccess
                            ? [const Color(0xFF059669), const Color(0xFF10B981)]
                            : _isScanning
                                ? [const Color(0xFF2563EB), const Color(0xFF3B82F6)]
                                : [const Color(0xFF064E3B), const Color(0xFF047857)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_scanSuccess
                                  ? const Color(0xFF10B981)
                                  : _isScanning
                                      ? const Color(0xFF3B82F6)
                                      : const Color(0xFF047857))
                              .withValues(alpha: 0.35),
                          blurRadius: 18,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isScanning
                          ? const SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3.5,
                              ),
                            )
                          : Icon(
                              _scanSuccess
                                  ? Icons.check_circle_outline_rounded
                                  : (_selectedBiometricType == 'fingerprint'
                                      ? Icons.fingerprint_rounded
                                      : Icons.face_retouching_natural_rounded),
                              size: 64,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  _scanSuccess
                      ? (_isKhmer ? 'ផ្ទៀងផ្ទាត់ជោគជ័យ! (0.78 វិនាទី)' : 'Authenticated Successfully! (0.78s)')
                      : _isScanning
                          ? (_isKhmer ? 'កំពុងស្កេនជីវមាត្រ...' : 'Scanning Hardware Sensor...')
                          : (_isKhmer
                              ? 'ចុចលើរូបដើម្បីសាកល្បងស្កេន (Tap to Test)'
                              : 'Tap Sensor to Test Instant Scan'),
                  style: GoogleFonts.battambang(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _scanSuccess
                        ? const Color(0xFF047857)
                        : _isScanning
                            ? const Color(0xFF1D4ED8)
                            : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _scanSuccess
                      ? (_isKhmer
                          ? 'សូមស្វាគមន៍មកកាន់ Chip Mong Bank, ម៉េង ថេត (Meng Theth)'
                          : 'Welcome back to Chip Mong Bank, Meng Theth')
                      : (_isKhmer
                          ? 'ដំណើរការដោយ Android BiometricPrompt API / iOS LocalAuthentication'
                          : 'Powered by Android BiometricPrompt / iOS LocalAuthentication'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.battambang(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Speed Comparison Metric Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isKhmer ? '📊 ការប្រៀបធៀបល្បឿន និងបទពិសោធន៍' : '📊 Speed & UX Benchmark',
                  style: GoogleFonts.battambang(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 14),
                _buildMetricBar(
                  title: _isKhmer ? '⚡ Biometric Quick Login' : '⚡ Biometric Quick Login',
                  time: '0.8s',
                  percentage: 0.15,
                  barColor: const Color(0xFF10B981),
                  badge: _isKhmer ? 'លឿនជាង ៨ ដង' : '8x Faster',
                ),
                const SizedBox(height: 12),
                _buildMetricBar(
                  title: _isKhmer ? '⏳ ការវាយលេខកូដ PIN ៦ ខ្ទង់' : '⏳ Manual 6-Digit PIN',
                  time: '6.5s',
                  percentage: 0.85,
                  barColor: const Color(0xFF94A3B8),
                  badge: _isKhmer ? 'ងាយវាយខុស' : 'Typo Prone',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBar({
    required String title,
    required String time,
    required double percentage,
    required Color barColor,
    required String badge,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.battambang(fontSize: 12.5, fontWeight: FontWeight.w600)),
            Row(
              children: [
                Text(time, style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: barColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.battambang(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: barColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  // TAB 2: QUICK PAY UNDER $500 SIMULATOR
  Widget _buildQuickPayTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F766E), Color(0xFF0D9488)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.qr_code_scanner_rounded, color: Color(0xFF5EEAD4), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      _isKhmer ? 'ទូទាត់រហ័សក្រោម \$500 គ្មាន PIN/OTP' : 'Biometric Quick Pay Under \$500',
                      style: GoogleFonts.battambang(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _isKhmer
                      ? 'ពេលស្កេនទូទាត់ KHQR នៅផ្សារ ឬផ្ទេរប្រាក់ក្រោម \$500 គ្រាន់តែស្កេនក្រយៅដៃ ឬផ្ទៃមុខ ១ វិនាទី ដើម្បីបញ្ជាក់ភ្លាមៗ ដោយមិនបាច់វាយលេខ PIN ឬរង់ចាំ SMS OTP ឡើយ!'
                      : 'For KHQR merchant payments or transfers under \$500, sign instantly with Face ID or Touch ID without PIN friction or SMS OTP delays.',
                  style: GoogleFonts.battambang(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Preset Transaction Cards to test
          Text(
            _isKhmer ? 'ជ្រើសរើសប្រតិបត្តិការដើម្បីសាកល្បង៖' : 'Select a sample transaction to test:',
            style: GoogleFonts.battambang(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 10),

          _buildTransactionOption(
            icon: Icons.local_grocery_store_rounded,
            title: 'Chip Mong Supermarket',
            subtitle: 'Grocery Express & Drinks',
            amount: 24.50,
          ),
          _buildTransactionOption(
            icon: Icons.coffee_rounded,
            title: 'Brown Coffee KHQR Pay',
            subtitle: 'Latte & Croissant',
            amount: 4.80,
          ),
          _buildTransactionOption(
            icon: Icons.school_rounded,
            title: 'NUM Tuition Partial Payment',
            subtitle: 'National University of Management',
            amount: 250.00,
          ),
          _buildTransactionOption(
            icon: Icons.apartment_rounded,
            title: 'Apartment Monthly Rent (High Value)',
            subtitle: 'Over \$500 limit test scenario',
            amount: 650.00,
          ),

          const SizedBox(height: 20),

          // Active Selected Transaction Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _selectedPayAmount <= _quickPayLimit
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedMerchant,
                          style: GoogleFonts.battambang(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          _selectedItemName,
                          style: GoogleFonts.battambang(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${_selectedPayAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: _selectedPayAmount <= _quickPayLimit
                            ? AppColors.primaryGreen
                            : const Color(0xFFDC2626),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _selectedPayAmount <= _quickPayLimit
                        ? const Color(0xFFECFDF5)
                        : const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _selectedPayAmount <= _quickPayLimit
                            ? Icons.check_circle_rounded
                            : Icons.warning_rounded,
                        size: 16,
                        color: _selectedPayAmount <= _quickPayLimit
                            ? const Color(0xFF059669)
                            : const Color(0xFFDC2626),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedPayAmount <= _quickPayLimit
                              ? (_isKhmer
                                  ? 'ចូលលក្ខខណ្ឌ Biometric Quick Pay (< \$500) — គ្មាន PIN / OTP'
                                  : 'Eligible for Biometric Quick Pay (< \$500) — No PIN / OTP')
                              : (_isKhmer
                                  ? 'លើសកម្រិតកំណត់ \$500 — តម្រូវឱ្យប្រើ PIN + SMS OTP ធម្មតា'
                                  : 'Exceeds \$500 threshold — Requires PIN + SMS OTP fallback'),
                          style: GoogleFonts.battambang(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: _selectedPayAmount <= _quickPayLimit
                                ? const Color(0xFF065F46)
                                : const Color(0xFF991B1B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPayAmount <= _quickPayLimit
                          ? AppColors.primaryGreen
                          : const Color(0xFF0F172A),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: _showBiometricPaySheet,
                    icon: Icon(
                      _selectedPayAmount <= _quickPayLimit
                          ? (_selectedBiometricType == 'fingerprint'
                              ? Icons.fingerprint_rounded
                              : Icons.face_retouching_natural_rounded)
                          : Icons.lock_outline_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      _selectedPayAmount <= _quickPayLimit
                          ? (_isKhmer ? 'ទូទាត់ភ្លាមៗដោយជីវមាត្រ' : 'Pay Instantly with Biometrics')
                          : (_isKhmer ? 'ទូទាត់ជាមួយ PIN & OTP' : 'Pay via Standard PIN & OTP'),
                      style: GoogleFonts.battambang(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required double amount,
  }) {
    final isSelected = _selectedPayAmount == amount;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedPayAmount = amount;
        _selectedMerchant = title;
        _selectedItemName = subtitle;
      }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFECFDF5) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGreen.withValues(alpha: 0.15) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: isSelected ? AppColors.primaryGreen : Colors.black87, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.battambang(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.battambang(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: amount <= _quickPayLimit ? const Color(0xFF059669) : const Color(0xFFDC2626),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAB 3: SECURITY, PROPOSAL VALUE, & SETTINGS
  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Proposal Deep Dive Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.description_rounded, color: AppColors.primaryGreen, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      _isKhmer ? 'ខ្លឹមសារសំណើគម្រោង (Proposal Summary)' : 'Proposal Executive Details',
                      style: GoogleFonts.battambang(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildProposalBullet(
                  titleKm: 'ផលវិបាករបស់អតិថិជន (Pain Points):',
                  titleEn: 'Customer Pain Points:',
                  descKm: '• ភ្លេចលេខសម្ងាត់ PIN/Password ពេលកំពុងប្រញាប់នៅមុខបញ្ជរ\n• ហានិភ័យ Shoulder Surfing នៅទីសាធារណៈ\n• រង់ចាំ SMS OTP យឺតយ៉ាវដោយសារសេវាទូរស័ព្ទខ្សោយ',
                  descEn: '• Forgotten PIN/passwords during checkout rushes\n• Shoulder surfing risks in public crowded locations\n• SMS OTP latency due to mobile network signal deadzones',
                ),
                const SizedBox(height: 10),
                _buildProposalBullet(
                  titleKm: 'ដំណោះស្រាយ (Solution):',
                  titleEn: 'Bank Solution:',
                  descKm: '• ផ្ទៀងផ្ទាត់ជីវមាត្រកម្រិតខ្ពស់ ក្រយៅដៃ និងផ្ទៃមុខ\n• ចូលប្រើ App ត្រឹមតែ ១ វិនាទី (Quick Login)\n• អនុម័តទូទាត់ក្រោម \$500 ភ្លាមៗដោយគ្មាន PIN/OTP',
                  descEn: '• Native Biometric Authentication (Face ID & Touch ID)\n• 1-second Instant App Quick Login\n• Fast transaction signing for purchases under \$500 without PIN/OTP',
                ),
                const SizedBox(height: 10),
                _buildProposalBullet(
                  titleKm: 'ផលចំណេញដល់ធនាគារ (Value to Bank):',
                  titleEn: 'Value to Chip Mong Bank:',
                  descKm: '• បង្កើនសុវត្ថិភាពខ្ពស់បំផុតការពារការលួចគណនី (Anti-Fraud)\n• កាត់បន្ថយថ្លៃដើមផ្ញើសារ SMS OTP រាប់ម៉ឺនដុល្លារក្នុងមួយខែ\n• ជំរុញចំនួនអ្នកប្រើប្រាស់សកម្ម (Daily Active Users - DAU)',
                  descEn: '• Superior cryptographic Anti-Fraud defense\n• Substantial operational savings on SMS OTP provider fees\n• Drives Daily Active Users (DAU) & higher card transaction velocity',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Toggles
          Text(
            _isKhmer ? 'ការកំណត់សុវត្ថិភាពជីវមាត្រ' : 'Biometric Security Controls',
            style: GoogleFonts.battambang(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: AppColors.primaryGreen,
                  title: Text(
                    _isKhmer ? 'ចូលគណនីរហ័សតាម Biometrics' : 'Quick Biometric Login',
                    style: GoogleFonts.battambang(fontSize: 13.5, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _isKhmer ? 'ប្រើក្រយៅដៃ ឬផ្ទៃមុខជំនួសពាក្យសម្ងាត់' : 'Use fingerprint or face recognition instead of password',
                    style: GoogleFonts.battambang(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                  value: _enableBiometricLogin,
                  onChanged: (val) => setState(() => _enableBiometricLogin = val),
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: AppColors.primaryGreen,
                  title: Text(
                    _isKhmer ? 'ទូទាត់រហ័សក្រោម \$500' : 'Quick Pay Under Threshold',
                    style: GoogleFonts.battambang(fontSize: 13.5, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _isKhmer ? 'មិនបាច់វាយ PIN សម្រាប់ប្រតិបត្តិការខ្នាតតូច' : 'No PIN required for small retail KHQR payments',
                    style: GoogleFonts.battambang(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                  value: _enableBiometricPay,
                  onChanged: (val) => setState(() => _enableBiometricPay = val),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isKhmer ? 'កម្រិតទឹកប្រាក់អតិបរមាគ្មាន PIN' : 'Biometric Max Threshold',
                            style: GoogleFonts.battambang(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${_quickPayLimit.toStringAsFixed(0)}',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        min: 100,
                        max: 1000,
                        divisions: 9,
                        activeColor: AppColors.primaryGreen,
                        value: _quickPayLimit,
                        onChanged: (val) => setState(() => _quickPayLimit = val),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Technical Architecture & Hardware Badge
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.security_rounded, color: Color(0xFF34D399), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Hardware Security Architecture',
                      style: GoogleFonts.roboto(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildTechRow('API Integration', 'AndroidX BiometricPrompt & iOS LocalAuth'),
                _buildTechRow('Key Storage', 'Hardware-backed Keystore / Secure Enclave'),
                _buildTechRow('Cryptographic Algo', 'ECDSA P-256 with SHA-256 Digest'),
                _buildTechRow('Compliance', 'NBC KHQR Digital Security Standard & PCI-DSS'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProposalBullet({
    required String titleKm,
    required String titleEn,
    required String descKm,
    required String descEn,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isKhmer ? titleKm : titleEn,
          style: GoogleFonts.battambang(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF065F46),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _isKhmer ? descKm : descEn,
          style: GoogleFonts.battambang(
            fontSize: 11.5,
            color: const Color(0xFF334155),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildTechRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.roboto(fontSize: 11, color: Colors.white70)),
          Text(value, style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF34D399))),
        ],
      ),
    );
  }
}
