import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_info_screen.dart';
import '../widgets/pay_transfer_sheet.dart';

class AccountHistoryScreen extends StatefulWidget {
  final String accountNumber;
  final String accountName;
  final String balance;

  const AccountHistoryScreen({
    super.key,
    this.accountNumber = '10163840',
    this.accountName = 'PREMIER ACCOUNT',
    this.balance = '94.24 KHR',
  });

  @override
  State<AccountHistoryScreen> createState() => _AccountHistoryScreenState();
}

class _AccountHistoryScreenState extends State<AccountHistoryScreen> {
  static const Color _green = Color(0xFF0C6B38);
  static const Color _buttonGreen = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);
  static const Color _selectedTabBg = Color(0xFFCFECE0);

  int _selectedFilterIndex = 0; // 0: ទាំងអស់, 1: លុយចូល, 2: លុយចេញ

  final List<_TransactionGroup> _allGroups = [
    _TransactionGroup(
      date: 'តុលា 01, 2026',
      items: [
        _TransactionItem(
          title: 'CREDIT INTEREST',
          time: '12:13 AM',
          amount: '0.10 KHR',
          isIncome: true,
          badgeType: _BadgeType.rielIncome,
        ),
      ],
    ),
    _TransactionGroup(
      date: 'កញ្ញា 01, 2026',
      items: [
        _TransactionItem(
          title: 'TAX',
          time: '12:22 AM',
          amount: '-0.06 KHR',
          isIncome: false,
          badgeType: _BadgeType.rielTax,
        ),
        _TransactionItem(
          title: 'CREDIT INTEREST',
          time: '12:22 AM',
          amount: '1.55 KHR',
          isIncome: true,
          badgeType: _BadgeType.rielIncome,
        ),
      ],
    ),
    _TransactionGroup(
      date: 'សីហា 05, 2026',
      items: [
        _TransactionItem(
          title: 'THETH MENG',
          time: '02:55 PM',
          amount: '-1,200.00 KHR',
          isIncome: false,
          badgeType: _BadgeType.chipMong,
        ),
        _TransactionItem(
          title: 'BUN PHANIT',
          time: '07:37 AM',
          amount: '-4,000.00 KHR',
          isIncome: false,
          badgeType: _BadgeType.khqr,
        ),
      ],
    ),
    _TransactionGroup(
      date: 'សីហា 04, 2026',
      items: [
        _TransactionItem(
          title: 'CHHAN SREYNICH',
          time: '08:15 AM',
          amount: '-2,000.00 KHR',
          isIncome: false,
          badgeType: _BadgeType.khqr,
        ),
      ],
    ),
    _TransactionGroup(
      date: 'សីហា 02, 2026',
      items: [
        _TransactionItem(
          title: 'CASH DEPOSIT ATM',
          time: '09:06 PM',
          amount: '150,000.00 KHR',
          isIncome: true,
          badgeType: _BadgeType.rielIncome,
        ),
      ],
    ),
  ];

  List<_TransactionGroup> get _filteredGroups {
    if (_selectedFilterIndex == 0) return _allGroups;

    final isLookingForIncome = _selectedFilterIndex == 1;
    final List<_TransactionGroup> result = [];

    for (final group in _allGroups) {
      final filteredItems = group.items
          .where((item) => item.isIncome == isLookingForIncome)
          .toList();
      if (filteredItems.isNotEmpty) {
        result.add(_TransactionGroup(date: group.date, items: filteredItems));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: Column(
        children: [
          _buildGreenHeader(context),
          _buildAccountInfoBar(context),
          _buildFilterTabs(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
              itemCount: _filteredGroups.length,
              itemBuilder: (context, index) {
                final group = _filteredGroups[index];
                return _buildTransactionGroup(group);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomPayButton(context),
    );
  }

  Widget _buildGreenHeader(BuildContext context) {
    return Container(
      color: _green,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
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
                    'ប្រវត្តិគណនីសន្សំប្រីមៀរ',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Account Details Subtitle
              Text(
                widget.accountName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${widget.accountNumber} | ${widget.accountName}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              // Balance Center
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ទឹកប្រាក់ដែលអាចមាន',
                          style: GoogleFonts.battambang(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white70,
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.balance,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'ទឹកប្រាក់សរុប: ${widget.balance}',
                      style: GoogleFonts.battambang(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountInfoBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AccountInfoScreen(
              accountNumber: widget.accountNumber,
              accountName: widget.accountName,
              balance: widget.balance,
            ),
          ),
        );
      },
      child: Container(
        color: const Color(0xFF094E29),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ព័ត៌មានគណនី',
              style: GoogleFonts.battambang(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ['ទាំងអស់', 'លុយចូល', 'លុយចេញ'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilterIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? _selectedTabBg : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tabs[index],
                style: GoogleFonts.battambang(
                  color: isSelected ? _green : const Color(0xFF475569),
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTransactionGroup(_TransactionGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 14, 4, 8),
          child: Text(
            group.date,
            style: GoogleFonts.battambang(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
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
            children: List.generate(group.items.length, (index) {
              final item = group.items[index];
              final isLast = index == group.items.length - 1;
              return Column(
                children: [
                  _buildTransactionRow(item),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.only(left: 68, right: 16),
                      child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionRow(_TransactionItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          _buildBadge(item.badgeType),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          Text(
            item.amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: item.isIncome
                  ? const Color(0xFF0FA958)
                  : const Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(_BadgeType badgeType) {
    switch (badgeType) {
      case _BadgeType.rielIncome:
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF0FA958),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '៛',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF0FA958),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(
                  Icons.south_west_rounded,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ],
        );

      case _BadgeType.rielTax:
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF0FA958),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '៛',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(
                  Icons.north_east_rounded,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ],
        );

      case _BadgeType.chipMong:
        return Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Color(0xFFE52329),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.stars_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        );

      case _BadgeType.khqr:
        return Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Color(0xFFE52329),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'KHQR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
    }
  }

  Widget _buildBottomPayButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => showPayAndTransferSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _buttonGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              'ទូទាត់ និងផ្ទេរប្រាក់',
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

enum _BadgeType {
  rielIncome,
  rielTax,
  chipMong,
  khqr,
}

class _TransactionGroup {
  final String date;
  final List<_TransactionItem> items;

  const _TransactionGroup({
    required this.date,
    required this.items,
  });
}

class _TransactionItem {
  final String title;
  final String time;
  final String amount;
  final bool isIncome;
  final _BadgeType badgeType;

  const _TransactionItem({
    required this.title,
    required this.time,
    required this.amount,
    required this.isIncome,
    required this.badgeType,
  });
}
