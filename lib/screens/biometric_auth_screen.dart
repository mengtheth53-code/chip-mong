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
  double _quickPayLimit = 10.0; // Pilot limit under $10 per Section 4.1 proposal
  bool _enableBiometricLogin = true;
  bool _enableBiometricPay = true;
  bool _enableLivenessDetection = true; // Face Liveness Detection per Section 4.1

  // Quick Pay simulator state
  double _selectedPayAmount = 1.50; // $1.50 coffee per Section 4.1 proposal
  String _selectedMerchant = 'Brown Coffee (កាហ្វេប្រចាំថ្ងៃ)';
  String _selectedItemName = 'Iced Latte & Croissant';

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

    Future.delayed(const Duration(milliseconds: 850), () {
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
                      ? 'ផ្ទៀងផ្ទាត់ជោគជ័យក្នុងរយៈពេល 0.78 វិនាទី! (FIDO2 On-Device)'
                      : 'Authenticated Successfully in 0.78s! (FIDO2 On-Device)',
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
                          isEligible ? Icons.flash_on_rounded : Icons.shield_rounded,
                          size: 16,
                          color: isEligible ? const Color(0xFF047857) : const Color(0xFFB45309),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isEligible
                              ? (_isKhmer
                                  ? 'One-Touch QuickPay (< \$${_quickPayLimit.toInt()})'
                                  : 'One-Touch QuickPay (< \$${_quickPayLimit.toInt()})')
                              : (_isKhmer
                                  ? 'Biometric Step-Up (> \$${_quickPayLimit.toInt()})'
                                  : 'Biometric Step-Up Security (> \$${_quickPayLimit.toInt()})'),
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
                      color: isEligible ? AppColors.primaryGreen : const Color(0xFFB45309),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (isEligible) ...[
                    // Biometric sensor prompt
                    GestureDetector(
                      onTap: () {
                        if (localScanning || localSuccess) return;
                        setSheetState(() => localScanning = true);
                        Future.delayed(const Duration(milliseconds: 750), () {
                          if (!context.mounted) return;
                          setSheetState(() {
                            localScanning = false;
                            localSuccess = true;
                          });
                          Future.delayed(const Duration(milliseconds: 650), () {
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
                            width: 2.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF10B981).withValues(alpha: 0.2),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: localScanning
                            ? const SizedBox(
                                width: 54,
                                height: 54,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.5,
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
                              ? (_isKhmer ? 'កំពុងផ្ទៀងផ្ទាត់ជីវមាត្រ...' : 'Verifying Biometrics...')
                              : (_isKhmer
                                  ? 'ចុចលើរូបដើម្បីអនុម័ត One-Touch QuickPay (គ្មាន PIN)'
                                  : 'Tap sensor icon to sign One-Touch QuickPay (No PIN)'),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.battambang(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: localSuccess ? const Color(0xFF047857) : const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isKhmer
                          ? 'ដំណើរការលើឧបករណ៍ (FIDO2 / Secure Enclave) មិនបញ្ជូនរូប Biometric ទៅ Server'
                          : 'Processed locally via FIDO2 / Secure Enclave (Zero raw biometrics sent to server)',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.battambang(
                        fontSize: 11,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ] else ...[
                    // Step-up Security required
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.security_update_warning_rounded, color: Color(0xFFB45309), size: 30),
                          const SizedBox(height: 8),
                          Text(
                            _isKhmer
                                ? 'គោលការណ៍ Biometric Step-Up Security៖ ដោយសារទឹកប្រាក់លើស \$${_quickPayLimit.toInt()} ឬមានហានិភ័យខ្ពស់ ប្រព័ន្ធទាមទារការផ្ទៀងផ្ទាត់បន្ថែម (PIN ៦ ខ្ទង់ ឬ SMS OTP) ដើម្បីសុវត្ថិភាពអតិបរមា។'
                                : 'Biometric Step-Up Security: Transactions exceeding \$${_quickPayLimit.toInt()} or flagged as high risk require secondary verification (6-digit PIN or SMS OTP) per bank security policy.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.battambang(
                              fontSize: 12,
                              color: const Color(0xFF92400E),
                              height: 1.45,
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
                          backgroundColor: const Color(0xFF0F172A),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isKhmer
                                    ? 'ប្តូរទៅកាន់ផ្ទាំង Step-Up PIN & SMS OTP ជោគជ័យ'
                                    : 'Proceeding with Step-Up PIN & SMS OTP verification',
                                style: GoogleFonts.battambang(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.password_rounded, color: Colors.white, size: 20),
                        label: Text(
                          _isKhmer ? 'ផ្ទៀងផ្ទាត់ដោយ PIN & SMS OTP' : 'Verify with PIN & SMS OTP',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 13.5,
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
                _isKhmer ? 'អនុម័តដោយ One-Touch QuickPay (FIDO2)' : 'Approved via One-Touch QuickPay (FIDO2)',
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
                    const Divider(height: 16),
                    _buildReceiptRow(_isKhmer ? 'ទឹកប្រាក់' : 'Amount', '\$${_selectedPayAmount.toStringAsFixed(2)}'),
                    const Divider(height: 16),
                    _buildReceiptRow(_isKhmer ? 'វិធីផ្ទៀងផ្ទាត់' : 'Auth Protocol', 'FIDO2 / ${_selectedBiometricType.toUpperCase()}'),
                    const Divider(height: 16),
                    _buildReceiptRow(_isKhmer ? 'រយៈពេលប្រតិបត្តិការ' : 'Turnaround Time', '0.78 វិនាទី (Instant)'),
                    const Divider(height: 16),
                    _buildReceiptRow(_isKhmer ? 'សុវត្ថិភាព' : 'Security', 'On-Device Secure Enclave'),
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
                  _isKhmer ? 'One-Touch QuickPay' : 'One-Touch QuickPay',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Biometric Authentication • Proposal 4.1',
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
          labelStyle: GoogleFonts.battambang(fontSize: 12, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: _isKhmer ? 'ចូលប្រើ ១ វិនាទី' : 'Quick Login'),
            Tab(text: _isKhmer ? 'One-Touch QuickPay' : 'One-Touch Pay'),
            Tab(text: _isKhmer ? 'FIDO2 & Step-Up' : 'Security & KPIs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildQuickLoginTab(),
          _buildQuickPayTab(),
          _buildSecurityAndKpiTab(),
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
          const SizedBox(height: 18),

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
                          _isKhmer ? 'ផ្ទៃមុខ (Face ID)' : 'Face ID',
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
          const SizedBox(height: 20),

          // Central Scanner Simulator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
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
                    width: 110,
                    height: 110,
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
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isScanning
                          ? const SizedBox(
                              width: 48,
                              height: 48,
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
                              size: 58,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _scanSuccess
                      ? (_isKhmer ? 'ផ្ទៀងផ្ទាត់ជោគជ័យ! (0.78 វិនាទី)' : 'Authenticated Successfully! (0.78s)')
                      : _isScanning
                          ? (_isKhmer ? 'កំពុងស្កេនជីវមាត្រ...' : 'Scanning Biometric Sensor...')
                          : (_isKhmer
                              ? 'ចុចលើរូបដើម្បីសាកល្បងស្កេន (Tap to Test)'
                              : 'Tap Sensor to Test Instant Scan'),
                  style: GoogleFonts.battambang(
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold,
                    color: _scanSuccess
                        ? const Color(0xFF047857)
                        : _isScanning
                            ? const Color(0xFF1D4ED8)
                            : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _scanSuccess
                      ? (_isKhmer
                          ? 'សូមស្វាគមន៍មកកាន់ Chip Mong Bank, ម៉េង ថេត (Meng Theth)'
                          : 'Welcome back to Chip Mong Bank, Meng Theth')
                      : (_isKhmer
                          ? 'ដំណើរការដោយ Android BiometricPrompt & iOS LocalAuthentication'
                          : 'Powered by Android BiometricPrompt & iOS LocalAuthentication'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.battambang(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Speed Comparison Metric Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isKhmer ? '📊 សូចនាករល្បឿន និងបទពិសោធន៍អ្នកប្រើប្រាស់' : '📊 UX Turnaround & Speed Benchmark',
                  style: GoogleFonts.battambang(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 12),
                _buildMetricBar(
                  title: _isKhmer ? '⚡ Biometric Quick Login' : '⚡ Biometric Quick Login',
                  time: '0.8s',
                  percentage: 0.15,
                  barColor: const Color(0xFF10B981),
                  badge: _isKhmer ? 'លឿនជាង ៨ ដង' : '8x Faster',
                ),
                const SizedBox(height: 10),
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
            Text(title, style: GoogleFonts.battambang(fontSize: 12, fontWeight: FontWeight.w600)),
            Row(
              children: [
                Text(time, style: GoogleFonts.roboto(fontSize: 12.5, fontWeight: FontWeight.bold)),
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

  // TAB 2: ONE-TOUCH QUICKPAY SIMULATOR
  Widget _buildQuickPayTab() {
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
                    const Icon(Icons.touch_app_rounded, color: Color(0xFF5EEAD4), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      _isKhmer ? 'One-Touch QuickPay សម្រាប់ប្រតិបត្តិការតូច' : 'One-Touch QuickPay for Micro-Purchases',
                      style: GoogleFonts.battambang(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _isKhmer
                      ? 'ដូចមានបញ្ជាក់ក្នុងសំណើ ៤.១៖ ពេលទិញកាហ្វេ \$1.50 ឬទំនិញ \$5 នៅ Chip Mong Supermarket អតិថិជនគ្រាន់តែស្កេនមេដៃ ឬផ្ទៃមុខ One-Touch QuickPay ដោយមិនបាច់វាយលេខកូដ PIN រាល់ពេលឡើយ!'
                      : 'Per Proposal 4.1: When buying \$1.50 coffee or \$5 groceries at Chip Mong Supermarket, customers approve instantly with One-Touch Biometrics without manual PIN fatigue.',
                  style: GoogleFonts.battambang(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.92),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Presets strictly from Proposal 4.1
          Text(
            _isKhmer ? 'ជ្រើសរើសប្រតិបត្តិការគំរូពីសំណើ ៤.១៖' : 'Select sample scenario from Proposal 4.1:',
            style: GoogleFonts.battambang(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 10),

          _buildTransactionOption(
            icon: Icons.coffee_rounded,
            title: 'Brown Coffee (ទិញកាហ្វេ)',
            subtitle: 'Micro-purchase scenario from Proposal 4.1',
            amount: 1.50,
          ),
          _buildTransactionOption(
            icon: Icons.local_grocery_store_rounded,
            title: 'Chip Mong Supermarket (ទិញទំនិញ)',
            subtitle: 'Groceries scenario from Proposal 4.1',
            amount: 5.00,
          ),
          _buildTransactionOption(
            icon: Icons.school_rounded,
            title: 'NUM Tuition Installment (សាកលវិទ្យាល័យ)',
            subtitle: 'National University of Management (Proposal 4.3)',
            amount: 250.00,
          ),
          _buildTransactionOption(
            icon: Icons.apartment_rounded,
            title: 'High-Value Transfer (ប្រតិបត្តិការខ្ពស់)',
            subtitle: 'Step-Up Security fallback demo (> \$10 threshold)',
            amount: 650.00,
          ),

          const SizedBox(height: 18),

          // Active Selected Transaction Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _selectedPayAmount <= _quickPayLimit
                    ? const Color(0xFF10B981)
                    : const Color(0xFFF59E0B),
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
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          _selectedItemName,
                          style: GoogleFonts.battambang(
                            fontSize: 11,
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
                            : const Color(0xFFD97706),
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
                        : const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _selectedPayAmount <= _quickPayLimit
                            ? Icons.check_circle_rounded
                            : Icons.security_rounded,
                        size: 16,
                        color: _selectedPayAmount <= _quickPayLimit
                            ? const Color(0xFF059669)
                            : const Color(0xFFD97706),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedPayAmount <= _quickPayLimit
                              ? (_isKhmer
                                  ? 'ចូលលក្ខខណ្ឌ One-Touch QuickPay (< \$${_quickPayLimit.toInt()}) — គ្មាន PIN'
                                  : 'Eligible for One-Touch QuickPay (< \$${_quickPayLimit.toInt()}) — No PIN')
                              : (_isKhmer
                                  ? 'លើសកម្រិតកំណត់ \$${_quickPayLimit.toInt()} — តម្រូវឱ្យប្រើ Biometric Step-Up (PIN/OTP)'
                                  : 'Exceeds \$${_quickPayLimit.toInt()} limit — Triggers Biometric Step-Up (PIN/OTP)'),
                          style: GoogleFonts.battambang(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: _selectedPayAmount <= _quickPayLimit
                                ? const Color(0xFF065F46)
                                : const Color(0xFF92400E),
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
                          ? (_isKhmer ? 'ទូទាត់ One-Touch QuickPay' : 'Approve with One-Touch QuickPay')
                          : (_isKhmer ? 'ទូទាត់ជាមួយ Step-Up PIN & OTP' : 'Pay via Step-Up PIN & OTP'),
                      style: GoogleFonts.battambang(
                        fontSize: 13.5,
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
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.battambang(
                      fontSize: 10.5,
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
                color: amount <= _quickPayLimit ? const Color(0xFF059669) : const Color(0xFFD97706),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAB 3: FIDO2, STEP-UP SECURITY, & KPIS
  Widget _buildSecurityAndKpiTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 4.1 Proposal Details Card
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
                    const Icon(Icons.verified_user_rounded, color: AppColors.primaryGreen, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      _isKhmer ? 'យន្តការសុវត្ថិភាព Biometric Step-Up (៤.១)' : 'Biometric Step-Up Security (4.1)',
                      style: GoogleFonts.battambang(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildProposalBullet(
                  titleKm: 'គោលការណ៍ Biometric Step-Up Security:',
                  titleEn: 'Biometric Step-Up Protocol:',
                  descKm: 'កម្រិតការផ្ទៀងផ្ទាត់ត្រូវកើនឡើងទៅតាមទំហំទឹកប្រាក់ និងកម្រិតហានិភ័យនៃប្រតិបត្តិការ។ ប្រតិបត្តិការទំហំតូច (ក្រោម \$10) ប្រើ One-Touch Biometric រហ័ស។ ប្រតិបត្តិការខ្ពស់ ឬមានសញ្ញាសង្ស័យ ត្រូវ Step-up ទាមទារ PIN ឬ OTP បន្ថែម។',
                  descEn: 'Verification rigor scales progressively with transaction value and risk rating. Micro-purchases (< \$10) authenticate with 1-touch; higher-value transactions step up to mandatory PIN or SMS OTP.',
                ),
                const SizedBox(height: 10),
                _buildProposalBullet(
                  titleKm: 'ស្តង់ដារ FIDO2 & Local On-Device Processing:',
                  titleEn: 'FIDO2 Standard & On-Device Security:',
                  descKm: 'ទិន្នន័យស្នាមមេដៃ ឬផ្ទៃមុខត្រូវដំណើរការលើឧបករណ៍អ្នកប្រើប្រាស់ (Secure Enclave / Android Keystore) ដោយមិនបញ្ជូនរូបភាព Biometric ដើមទៅម៉ាស៊ីនមេរបស់ធនាគារឡើយ។',
                  descEn: 'Biometric keys are processed entirely within local hardware Secure Enclave using FIDO2 cryptographic tokens. No raw biometric imagery is ever transmitted to the bank server.',
                ),
                const SizedBox(height: 10),
                _buildProposalBullet(
                  titleKm: 'Face Liveness Detection:',
                  titleEn: 'Face Liveness Anti-Spoofing:',
                  descKm: 'ផ្ទៀងផ្ទាត់ភាពរស់រវើកនៃផ្ទៃមុខ ដើម្បីការពារការក្លែងបន្លំតាមរយៈរូបថត ឬវីដេអូ (Presentation Attack Detection) តាមស្តង់ដារសុវត្ថិភាពធនាគារ។',
                  descEn: 'Detects facial motion and depth to prevent photo or video replay presentation attacks, meeting international banking standards.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Toggles and Controls
          Text(
            _isKhmer ? 'ការកំណត់កម្រិត One-Touch QuickPay' : 'One-Touch QuickPay Controls',
            style: GoogleFonts.battambang(
              fontSize: 13.5,
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
                    style: GoogleFonts.battambang(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _isKhmer ? 'ប្រើក្រយៅដៃ ឬផ្ទៃមុខជំនួសពាក្យសម្ងាត់' : 'Use fingerprint or face recognition instead of password',
                    style: GoogleFonts.battambang(fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                  value: _enableBiometricLogin,
                  onChanged: (val) => setState(() => _enableBiometricLogin = val),
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: AppColors.primaryGreen,
                  title: Text(
                    _isKhmer ? 'One-Touch QuickPay (< \$${_quickPayLimit.toInt()})' : 'One-Touch QuickPay (< \$${_quickPayLimit.toInt()})',
                    style: GoogleFonts.battambang(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _isKhmer ? 'មិនបាច់វាយ PIN សម្រាប់កាហ្វេ និងទំនិញតូចតាច' : 'No PIN required for coffee & small groceries',
                    style: GoogleFonts.battambang(fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                  value: _enableBiometricPay,
                  onChanged: (val) => setState(() => _enableBiometricPay = val),
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: AppColors.primaryGreen,
                  title: Text(
                    _isKhmer ? 'Face Liveness Detection' : 'Face Liveness Detection',
                    style: GoogleFonts.battambang(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _isKhmer ? 'ការពារការក្លែងបន្លំរូបថត ឬវីដេអូ' : 'Anti-spoofing presentation attack detection',
                    style: GoogleFonts.battambang(fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                  value: _enableLivenessDetection,
                  onChanged: (val) => setState(() => _enableLivenessDetection = val),
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
                            _isKhmer ? 'កម្រិតសាកល្បង One-Touch (Pilot Limit)' : 'One-Touch Pilot Threshold',
                            style: GoogleFonts.battambang(fontSize: 12.5, fontWeight: FontWeight.bold),
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
                        min: 5,
                        max: 50,
                        divisions: 9,
                        activeColor: AppColors.primaryGreen,
                        value: _quickPayLimit,
                        onChanged: (val) => setState(() => _quickPayLimit = val),
                      ),
                      Text(
                        _isKhmer
                            ? 'កម្រិតក្រោម \$10 ជាកម្រិតសាកល្បងដំបូងស្របតាមសំណើ ៤.១'
                            : 'Threshold under \$10 recommended for initial pilot per Proposal 4.1',
                        style: GoogleFonts.battambang(fontSize: 10.5, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Proposal 4.1 KPIs Dashboard Card
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
                    const Icon(Icons.insights_rounded, color: Color(0xFF34D399), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _isKhmer ? 'សូចនាករវាស់វែងប្រសិទ្ធភាព (KPIs per 4.1)' : 'Success Metrics & KPIs (Proposal 4.1)',
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTechRow('Turnaround Time', '0.78s (Down from 6.5s)'),
                _buildTechRow('Transaction Failure Rate', '< 0.02% (Target < 0.1%)'),
                _buildTechRow('Public Shoulder Surfing Risk', '0% (PIN-free Micro-Pay)'),
                _buildTechRow('Raw Biometric Server Leakage', '0% (FIDO2 On-Device Keystore)'),
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
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF065F46),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          _isKhmer ? descKm : descEn,
          style: GoogleFonts.battambang(
            fontSize: 11,
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
