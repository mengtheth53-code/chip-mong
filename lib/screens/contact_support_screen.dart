import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/app_screen_header.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final List<_ContactItem> _items = const [
    _ContactItem(
      icon: Icons.phone_outlined,
      title: 'សេវាទំនាក់ទំនងអតិថិជន 24 ម៉ោង',
      subtitle: '(855) 81 811 911 or (855) 66 811 911',
    ),
    _ContactItem(
      icon: Icons.chat_bubble_outline_rounded,
      title: 'ផ្ញើសារតាម Messenger',
      subtitle: 'ទាក់ទងមកកាន់យើងខ្ញុំតាមរយៈ Messenger',
    ),
    _ContactItem(
      icon: Icons.send_outlined,
      title: 'ផ្ញើសារតាម Telegram',
      subtitle: 'ទាក់ទងមកកាន់យើងខ្ញុំតាមរយៈ Telegram',
    ),
    _ContactItem(
      icon: Icons.mail_outline_rounded,
      title: 'ផ្ញើអ៊ីមែលមកការិយាល័យ',
      subtitle: 'info@chipmongbank.com.kh',
    ),
    _ContactItem(
      icon: Icons.language_outlined,
      title: 'គេហទំព័រ',
      subtitle: 'ចូលទៅកាន់គេហទំព័រ ធនាគារ ជីប ម៉ុងយើងខ្ញុំ',
    ),
    _ContactItem(
      icon: Icons.location_on_outlined,
      title: 'អាសយដ្ឋានទីស្នាក់ការកណ្តាល',
      subtitle:
          'ទីស្នាក់ការកណ្តាលតាំងនៅ អគារ ជីប មុំង ថៅវ័រជាន់ផ្ទាល់ដី បន្ទប់លេខហ្សេ01 និង ជាន់ទី15-18 មហាវិថីសហព័ន្ធរុស្ស៊ី ភូមិ10 សង្កាត់ផ្សារដេរប៉ូទី 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildSubtitle(),
                const SizedBox(height: 16),
                ..._items.map((item) => _buildContactCard(item)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────
  Widget _buildAppBar() {
    return const AppScreenHeader(
      title: 'សេវាកម្មអតិថិជន',
      backgroundColor: AppColors.surfaceBackground,
      foregroundColor: Colors.black,
    );
  }

  // ── Subtitle ─────────────────────────────────────────────
  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        'ប្រសិនបើលោកអ្នកមានចម្ងល់ឬសំណួរ សូមពិនិត្យបញ្ជី\nព័ត៌មានខាងក្រោម៖',
        style: GoogleFonts.battambang(
          fontSize: 24,
          color: Color.fromARGB(255, 136, 133, 133),
          height: 1.6,
        ),
      ),
    );
  }

  // ── Contact Card ─────────────────────────────────────────
  Widget _buildContactCard(_ContactItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFDFF0E8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(item.icon, color: const Color(0xFF1A6B3C), size: 24),
        ),
        title: Text(
          item.title,
          style: GoogleFonts.battambang(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.4,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item.subtitle,
            style: GoogleFonts.battambang(
              fontSize: 19,
              color: Color.fromARGB(255, 136, 133, 133),
              height: 1.5,
            ),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        onTap: () {},
      ),
    );
  }
}

// ── Data Models ──────────────────────────────────────────
class _ContactItem {
  final IconData icon;
  final String title;
  final String subtitle;
  const _ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
