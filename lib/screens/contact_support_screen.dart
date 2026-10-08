import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_screen.dart';
import 'chip_mong_map_screen.dart';
import 'deposit_screen.dart';
import 'promotion_screen.dart';
import 'scan_qr_screen.dart';

class ContactSupportScreen extends StatefulWidget {
  final bool showBackButton;

  const ContactSupportScreen({super.key, this.showBackButton = false});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  static const Color _bgGray = Color(0xFFF4F6F8);
  static const Color _greenPrimary = Color(0xFF0C8A4A);
  static const Color _textDark = Color(0xFF1E293B);
  static const Color _textMuted = Color(0xFF8C98A4);

  final List<_ContactItem> _items = const [
    _ContactItem(
      icon: Icons.phone_outlined,
      title: 'សេវាទំនាក់ទំនងអតិថិជន 24 ម៉ោង',
      subtitle: '( 855 ) 81 811 911 or ( 855 ) 66 811 911',
      actionType: _ContactActionType.phone,
    ),
    _ContactItem(
      icon: Icons.chat_bubble_outline_rounded,
      title: 'ផ្ញើសារតាម Messenger',
      subtitle: 'ទាក់ទងមកកាន់យើងខ្ញុំតាមរយៈ Messenger',
      actionType: _ContactActionType.messenger,
    ),
    _ContactItem(
      icon: Icons.send_rounded,
      title: 'ផ្ញើសារតាម Telegram',
      subtitle: 'ទាក់ទងមកកាន់យើងខ្ញុំតាមរយៈ Telegram',
      actionType: _ContactActionType.telegram,
    ),
    _ContactItem(
      icon: Icons.mail_outline_rounded,
      title: 'ផ្ញើអ៊ីម៉ែលមកកាន់យើងខ្ញុំ',
      subtitle: 'info@chipmongbank.com.kh',
      actionType: _ContactActionType.email,
    ),
    _ContactItem(
      icon: Icons.language_rounded,
      title: 'គេហទំព័រ',
      subtitle: 'ចូលទៅកាន់គេហទំព័រ ធនាគារ ជីប ម៉ុងយើងខ្ញុំ',
      actionType: _ContactActionType.website,
    ),
    _ContactItem(
      icon: Icons.location_on_outlined,
      title: 'អាសយដ្ឋានទីស្នាក់ការកណ្តាល',
      subtitle:
          'ទីស្នាក់ការកណ្តាលតាំងនៅ អគារ ជីប ម៉ុង ថៅវ័រ ជាន់ផ្ទាល់ដី បន្ទប់លេខហ្សេ01 និង ជាន់ទី15-18 មហាវិថីសហព័ន្ធរុស្ស៊ី ភូមិ10 សង្កាត់ផ្សារដេប៉ូទី 3',
      actionType: _ContactActionType.location,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                children: [
                  _buildSubtitle(),
                  const SizedBox(height: 14),
                  ..._items.map((item) => _buildContactCard(item)),
                ],
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.showBackButton || Navigator.canPop(context))
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: _textDark,
                  size: 20,
                ),
              ),
            ),
          Center(
            child: Text(
              'សេវាកម្មអតិថិជន',
              style: GoogleFonts.battambang(
                fontSize: 18.5,
                fontWeight: FontWeight.w700,
                color: _textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Subtitle ─────────────────────────────────────────────
  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        'ប្រសិនបើលោកអ្នកមានចម្ងល់ឬសំណួរ សូមពិនិត្យបញ្ជី\nព័ត៌មានខាងក្រោម៖',
        style: GoogleFonts.battambang(
          fontSize: 13.5,
          color: _textMuted,
          height: 1.5,
        ),
      ),
    );
  }

  // ── Contact Card ─────────────────────────────────────────
  Widget _buildContactCard(_ContactItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _handleItemTap(item),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Soft Mint Squircle Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F4EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.icon,
                    color: const Color(0xFF0C8A4A),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.battambang(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _textDark,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.battambang(
                          fontSize: 12.5,
                          color: _textMuted,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Trailing Chevron
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFCFD6DC),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Actions ──────────────────────────────────────────────
  void _handleItemTap(_ContactItem item) {
    switch (item.actionType) {
      case _ContactActionType.phone:
        _showPhoneActionSheet();
        break;
      case _ContactActionType.messenger:
        _showSocialAction(
          title: 'Messenger',
          message: 'ចូលទៅកាន់ការសន្ទនាតាម Messenger?',
        );
        break;
      case _ContactActionType.telegram:
        _showSocialAction(
          title: 'Telegram',
          message: 'ចូលទៅកាន់ការសន្ទនាតាម Telegram (@chipmongbank)?',
        );
        break;
      case _ContactActionType.email:
        _showSocialAction(
          title: 'Email',
          message: 'ផ្ញើអ៊ីម៉ែលទៅកាន់ info@chipmongbank.com.kh?',
        );
        break;
      case _ContactActionType.website:
        _showSocialAction(
          title: 'គេហទំព័រ',
          message: 'ចូលទៅកាន់គេហទំព័រផ្លូវការ www.chipmongbank.com?',
        );
        break;
      case _ContactActionType.location:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ChipMongMapScreen()),
        );
        break;
    }
  }

  // ── Phone Action Sheet (media_1791223876912.png) ───────────
  void _showPhoneActionSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Action Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      // 081 811 911
                      InkWell(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                        onTap: () {
                          Navigator.pop(sheetContext);
                          _callNumber('081 811 911');
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            '081 811 911',
                            style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 0.5,
                        thickness: 0.5,
                        color: Color(0xFFE5E5EA),
                      ),
                      // 066 811 911
                      InkWell(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
                        onTap: () {
                          Navigator.pop(sheetContext);
                          _callNumber('066 811 911');
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            '066 811 911',
                            style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Cancel Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Navigator.pop(sheetContext),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _callNumber(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '📞 កំពុងហៅទៅកាន់ $phone...',
          style: GoogleFonts.battambang(),
        ),
        backgroundColor: const Color(0xFF0C8A4A),
      ),
    );
  }

  void _showSocialAction({required String title, required String message}) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: GoogleFonts.battambang(fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: GoogleFonts.battambang(fontSize: 13.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'បោះបង់',
              style: GoogleFonts.battambang(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0C8A4A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'កំពុងភ្ជាប់ទៅកាន់ $title...',
                    style: GoogleFonts.battambang(),
                  ),
                ),
              );
            },
            child: Text(
              'បើក',
              style: GoogleFonts.battambang(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Navigation Bar (media_1791223871054.png) ────────
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 0: គណនី
              _buildNavTab(
                icon: Icons.account_balance_wallet_outlined,
                label: 'គណនី',
                isSelected: false,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const AccountsScreen()),
                  );
                },
              ),
              // 1: អត្ថប្រយោជន៍
              _buildNavTab(
                icon: Icons.star_border_rounded,
                label: 'អត្ថប្រយោជន៍',
                isSelected: false,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const PromotionScreen()),
                  );
                },
              ),
              // 2: Scan QR
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ScanQrScreen()),
                  );
                },
                child: Container(
                  width: 62,
                  height: 62,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8CE0B0),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C8A4A),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
              // 3: ដកប្រាក់
              _buildNavTab(
                icon: Icons.savings_outlined,
                label: 'ដកប្រាក់',
                isSelected: false,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const DepositScreen()),
                  );
                },
              ),
              // 4: សេវាកម្មអតិថិជន (Active Tab)
              _buildNavTab(
                icon: Icons.support_agent_rounded,
                label: 'សេវាកម្មអតិថិជន',
                isSelected: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavTab({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? _greenPrimary : Colors.grey.shade400,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.battambang(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? _greenPrimary : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Contact Item Model ────────────────────────────────────
enum _ContactActionType {
  phone,
  messenger,
  telegram,
  email,
  website,
  location,
}

class _ContactItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final _ContactActionType actionType;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.actionType,
  });
}
