import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'deposit_screen.dart';
import 'myself_transfer_screen.dart';

// ─────────────────────────────────────────────
//  Transfer Screen
// ─────────────────────────────────────────────
class FillScreen extends StatefulWidget {
  const FillScreen({super.key});

  @override
  State<FillScreen> createState() => _FillScreenState();
}

class _FillScreenState extends State<FillScreen> {
  static const _green = Color(0xFF0FA958);
  static const _bgGray = Color(0xFFF2F2F7);

  final _searchController = TextEditingController();

  final List<_TransferItem> _items = [
    _TransferItem(
      icon: Icons.person_outline_rounded,
      iconBg: Color(0xFF0FA958),
      title: 'ផ្ទេរប្រាក់ទៅគណនីខ្លួនឯង',
      subtitle: 'ផ្ទេរប្រាក់ទៅគណនីខ្លួនឯង',
    ),
    _TransferItem(
      icon: Icons.swap_horiz_rounded,
      iconBg: Color(0xFF0FA958),
      title: 'ផ្ទេរប្រាក់ទៅគណនី ជីប ម៉ុង ណាមួយ',
      subtitle: 'ផ្ទេរប្រាក់ទៅគណនី ជីប​ ម៉ុង​ ណាមួយ',
    ),
    _TransferItem(
      icon: Icons.account_balance_rounded,
      iconBg: Color(0xFFB8860B),
      title: 'ផ្ទេរប្រាក់ក្នុងស្រុក',
      subtitle: 'ផ្ទេរប្រាក់ទៅគណនីបាគង និងគណនីធនាគារ',
    ),
    _TransferItem(
      icon: Icons.upload_rounded,
      iconBg: Color(0xFF26A9D0),
      title: 'ដកប្រាក់',
      subtitle: 'ដកសាច់ប្រាក់តាមម៉៉ាស៊ីន ATM តាមរយៈលេខកូដ',
    ),
    _TransferItem(
      icon: Icons.language_rounded,
      iconBg: Color(0xFF26A9D0),
      title: 'ផ្ទេរប្រាក់ទៅក្រៅប្រទេស',
      subtitle: 'ផ្ទេរប្រាក់ទៅគណនីធនាគារក្រៅប្រទេស',
    ),
  ];

  List<_TransferItem> get _filtered {
    final q = _searchController.text.toLowerCase();
    if (q.isEmpty) return _items;
    return _items
        .where(
          (e) =>
              e.title.toLowerCase().contains(q) ||
              e.subtitle.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: Column(
        children: [
          // ── Green header
          _TransferHeader(green: _green),

          // ── Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Search bar
                  _SearchBar(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 12),

                  // Transfer items
                  AnimatedBuilder(
                    animation: _searchController,
                    builder: (_, __) => Column(
                      children: _filtered
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _TransferTile(item: item),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Green Header
// ─────────────────────────────────────────────
class _TransferHeader extends StatelessWidget {
  final Color green;
  const _TransferHeader({required this.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: green,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  Text(
                    'ផ្ទេរប្រាក់',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Promo banner
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.workspace_premium_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'បន្ថែមគំរូទូទាត់ថ្មី',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'បង្កើតគំរូទូទាត់របស់អ្នកឥឡូវនេះសម្រាប់ការធ្វើប្រតិបត្តិការឆាប់រហ័ស និងងាយស្រួល',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 18,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Button
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            'បង្កើតគំរូទូទាត់ថ្មី',
                            style: GoogleFonts.battambang(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // White rounded transition
            Container(
              height: 22,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Search bar
// ─────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.battambang(fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'ស្វែងរក',
          hintStyle: TextStyle(color: Color(0xFFAAAAAA), fontSize: 18),
          prefixIcon: Icon(Icons.search, color: Color(0xFFAAAAAA), size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Transfer tile
// ─────────────────────────────────────────────
class _TransferItem {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  const _TransferItem({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });
}

class _TransferTile extends StatelessWidget {
  final _TransferItem item;
  const _TransferTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (item.title == 'ផ្ទេរប្រាក់ទៅគណនីខ្លួនឯង') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const MySelfTransferScreen(),
              ),
            );
          } else if (item.title == 'ដកប្រាក់') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const DepositScreen(),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Icon
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: item.iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.battambang(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.battambang(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 107, 105, 105),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Color(0xFFCCCCCC),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
