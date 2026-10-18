import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VirtualCardScreen extends StatefulWidget {
  const VirtualCardScreen({super.key});

  @override
  State<VirtualCardScreen> createState() => _VirtualCardScreenState();
}

class _VirtualCardScreenState extends State<VirtualCardScreen>
    with SingleTickerProviderStateMixin {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _showBack = false;

  bool _isCardFrozen = false;
  bool _isOnlineEnabled = true;
  bool _isInternationalEnabled = true;
  double _dailyOnlineLimit = 2500.0;
  double _dailyAtmLimit = 1000.0;
  bool _isCvvVisible = false;

  final String _cardNumber = '6201 8845 9210 4492';
  final String _cvv = '882';
  final String _expiry = '09/29';
  final String _holderName = 'MENG THETH';

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    if (_showBack) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _showBack = !_showBack);
  }

  void _copyCardNumber() {
    Clipboard.setData(ClipboardData(text: _cardNumber.replaceAll(' ', '')));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              'បានចម្លងលេខប័ណ្ណរួចរាល់ (Card number copied)',
              style: GoogleFonts.battambang(),
            ),
          ],
        ),
        backgroundColor: _darkGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLimitModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalCtx, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'កំណត់ទំហំទឹកប្រាក់ចំណាយ (Card Limits)',
                    style: GoogleFonts.battambang(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Online Shopping Limit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ទិញទំនិញ Online ប្រចាំថ្ងៃ:',
                        style: GoogleFonts.battambang(fontSize: 13),
                      ),
                      Text(
                        '\$${_dailyOnlineLimit.toInt()}',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _green,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _dailyOnlineLimit,
                    min: 100,
                    max: 5000,
                    divisions: 49,
                    activeColor: _green,
                    inactiveColor: Colors.grey.shade300,
                    onChanged: (val) {
                      setModalState(() => _dailyOnlineLimit = val);
                      setState(() => _dailyOnlineLimit = val);
                    },
                  ),
                  const SizedBox(height: 12),

                  // ATM Withdrawal Limit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ដកប្រាក់តាមទូ ATM ប្រចាំថ្ងៃ:',
                        style: GoogleFonts.battambang(fontSize: 13),
                      ),
                      Text(
                        '\$${_dailyAtmLimit.toInt()}',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _green,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _dailyAtmLimit,
                    min: 100,
                    max: 2500,
                    divisions: 24,
                    activeColor: _green,
                    inactiveColor: Colors.grey.shade300,
                    onChanged: (val) {
                      setModalState(() => _dailyAtmLimit = val);
                      setState(() => _dailyAtmLimit = val);
                    },
                  ),
                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'បានរក្សាទុកទំហំចំណាយប័ណ្ណដោយជោគជ័យ',
                              style: GoogleFonts.battambang(),
                            ),
                            backgroundColor: _darkGreen,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _darkGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'យល់ព្រមរក្សាទុក',
                        style: GoogleFonts.battambang(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Flip Hint
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.touch_app_rounded,
                              size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 6),
                          Text(
                            'ចុចលើប័ណ្ណដើម្បីបង្វិលមើលមុខ / ក្រោយ (Tap card to flip)',
                            style: GoogleFonts.battambang(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 3D Flippable Virtual Card
                    GestureDetector(
                      onTap: _toggleFlip,
                      child: AnimatedBuilder(
                        animation: _flipAnimation,
                        builder: (context, child) {
                          final angle = _flipAnimation.value * pi;
                          final isBack = angle > pi / 2;

                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(angle),
                            alignment: Alignment.center,
                            child: isBack
                                ? Transform(
                                    transform: Matrix4.identity()..rotateY(pi),
                                    alignment: Alignment.center,
                                    child: _buildCardBack(),
                                  )
                                : _buildCardFront(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Quick Action Buttons (Copy, CVV, Freeze)
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.copy_rounded,
                            label: 'ចម្លងលេខប័ណ្ណ',
                            onTap: _copyCardNumber,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildActionButton(
                            icon: _isCvvVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            label: _isCvvVisible ? 'លាក់ CVV' : 'បង្ហាញ CVV',
                            onTap: () {
                              setState(() => _isCvvVisible = !_isCvvVisible);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildActionButton(
                            icon: _isCardFrozen
                                ? Icons.lock_open_rounded
                                : Icons.lock_outline_rounded,
                            label: _isCardFrozen ? 'ដោះសោរប័ណ្ណ' : 'ចាក់សោរប័ណ្ណ',
                            iconColor: _isCardFrozen ? _green : Colors.red,
                            onTap: () {
                              setState(() => _isCardFrozen = !_isCardFrozen);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _isCardFrozen
                                        ? 'ប័ណ្ណត្រូវបានចាក់សោរបណ្តោះអាសន្ន (Card Frozen)'
                                        : 'ប័ណ្ណត្រូវបានដោះសោររួចរាល់ (Card Active)',
                                    style: GoogleFonts.battambang(),
                                  ),
                                  backgroundColor:
                                      _isCardFrozen ? Colors.red.shade700 : _green,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Controls Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ការគ្រប់គ្រងសុវត្ថិភាពប័ណ្ណ (Card Security)',
                            style: GoogleFonts.battambang(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E1E1E),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Limit Settings Tile
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _green.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.tune_rounded, color: _green),
                            ),
                            title: Text(
                              'កំណត់ទំហំទឹកប្រាក់ចំណាយ (Limit)',
                              style: GoogleFonts.battambang(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'Online: \$${_dailyOnlineLimit.toInt()} | ATM: \$${_dailyAtmLimit.toInt()}',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 14, color: Colors.grey),
                            onTap: _showLimitModal,
                          ),
                          const Divider(height: 16),

                          // Online Payment Toggle
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            activeThumbColor: _green,
                            secondary: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0284C7).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.shopping_cart_outlined,
                                  color: Color(0xFF0284C7)),
                            ),
                            title: Text(
                              'ការទូទាត់ទំនិញ Online',
                              style: GoogleFonts.battambang(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'អនុញ្ញាតការទិញទំនិញតាមអ៊ីនធឺណិត',
                              style: GoogleFonts.battambang(
                                fontSize: 11.5,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            value: _isOnlineEnabled,
                            onChanged: (val) =>
                                setState(() => _isOnlineEnabled = val),
                          ),
                          const Divider(height: 16),

                          // International Payments Toggle
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            activeThumbColor: _green,
                            secondary: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC59B27).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.public,
                                  color: Color(0xFFC59B27)),
                            ),
                            title: Text(
                              'ការទូទាត់អន្តរជាតិ (International)',
                              style: GoogleFonts.battambang(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'អនុញ្ញាតប្រតិបត្តិការក្រៅប្រទេស',
                              style: GoogleFonts.battambang(
                                fontSize: 11.5,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            value: _isInternationalEnabled,
                            onChanged: (val) =>
                                setState(() => _isInternationalEnabled = val),
                          ),
                          const Divider(height: 16),

                          // Change PIN
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.purple.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.pin_rounded,
                                  color: Colors.purple),
                            ),
                            title: Text(
                              'ផ្លាស់ប្តូរលេខសម្ងាត់ PIN ប័ណ្ណ',
                              style: GoogleFonts.battambang(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'កំណត់លេខ PIN ថ្មី ៦ ខ្ទង់តាមទូរសព្ទ',
                              style: GoogleFonts.battambang(
                                fontSize: 11.5,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 14, color: Colors.grey),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'សូមបញ្ចូលលេខកូដ OTP ដើម្បីផ្លាស់ប្តូរលេខ PIN ប័ណ្ណ',
                                    style: GoogleFonts.battambang(),
                                  ),
                                  backgroundColor: _darkGreen,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
          ),
          Text(
            'ប័ណ្ណនិម្មិត UnionPay',
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ── Front of the Virtual Card ──────────────────────────────────────────────
  Widget _buildCardFront() {
    return Container(
      height: 215,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isCardFrozen
              ? [const Color(0xFF475569), const Color(0xFF1E293B)]
              : [const Color(0xFF0B6634), const Color(0xFF032B14)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          // Background subtle circle pattern
          Positioned(
            right: -30,
            bottom: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          // Frozen Overlay Badge if locked
          if (_isCardFrozen)
            Positioned(
              top: 50,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'FROZEN',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Row: Chip Mong Bank & UnionPay Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'CHIP MONG BANK',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'VIRTUAL',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // UnionPay Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'UnionPay ',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF003882),
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          '银联',
                          style: TextStyle(
                            color: const Color(0xFFD31145),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // EMV Chip & Contactless
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2B755),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.wifi, color: Colors.white70, size: 20),
                ],
              ),

              // 16-Digit Card Number
              Text(
                _cardNumber,
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),

              // Bottom Row: Holder Name & Expiry
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CARD HOLDER',
                        style: GoogleFonts.roboto(
                          color: Colors.white60,
                          fontSize: 9,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        _holderName,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'EXPIRES',
                        style: GoogleFonts.roboto(
                          color: Colors.white60,
                          fontSize: 9,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        _expiry,
                        style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Back of the Virtual Card ───────────────────────────────────────────────
  Widget _buildCardBack() {
    return Container(
      height: 215,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF032B14), const Color(0xFF085329)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Magnetic stripe
          Container(
            height: 38,
            width: double.infinity,
            color: const Color(0xFF1A1A1A),
          ),
          const SizedBox(height: 16),

          // Signature & CVV Strip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    color: Colors.white70,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Authorized Signature',
                      style: GoogleFonts.caveat(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 36,
                  width: 55,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    _isCvvVisible ? _cvv : '•••',
                    style: GoogleFonts.robotoMono(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Security Disclaimer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This digital card is issued by Chip Mong Commercial Bank Plc pursuant to a license by UnionPay International.',
                  style: GoogleFonts.roboto(color: Colors.white60, fontSize: 8),
                ),
                const SizedBox(height: 4),
                Text(
                  'Customer Service 24/7: 081 811 911 | +855 23 999 999',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
          children: [
            Icon(icon, color: iconColor ?? _darkGreen, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.battambang(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
