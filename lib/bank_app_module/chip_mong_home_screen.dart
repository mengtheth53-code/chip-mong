import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_screen.dart';
import 'app_theme.dart';
import 'borrow_screen.dart';
import 'card_screen.dart';
import 'contact_support_screen.dart';
import 'deposit_screen.dart';
import 'message_screen.dart';
import 'payment_page.dart';
import 'payment_model.dart';
import 'password_screen.dart';
import 'poster.dart';
import 'profile_screen.dart';
import 'promotion_screen.dart' as promotion;
import 'qr_screen.dart';
import 'service_screen.dart';
import 'transfer_screen.dart' as transfer;

class ChipMongHomeScreen extends StatefulWidget {
  const ChipMongHomeScreen({super.key});

  @override
  State<ChipMongHomeScreen> createState() => _ChipMongHomeScreenState();
}

class _ChipMongHomeScreenState extends State<ChipMongHomeScreen> {
  int _selectedIndex = 0;
  bool _balanceVisible = false;
  int _currentBanner = 0;

  final List<_NavItem> _tabs = const [
    _NavItem(
      icon: Icons.account_balance_wallet_outlined,
      label: 'គណនី',
      destination: _AppDestination.account,
    ),
    _NavItem(
      icon: Icons.star_border_rounded,
      label: 'អត្ថប្រយោជន៍',
      destination: _AppDestination.promotion,
    ),
    _NavItem(icon: Icons.qr_code_scanner, label: '', isQr: true),
    _NavItem(
      icon: Icons.savings_outlined,
      label: 'ដកប្រាក់',
      destination: _AppDestination.deposit,
    ),
    _NavItem(
      icon: Icons.headset_mic_outlined,
      label: 'សេវាកម្មអតិថិជន',
      destination: _AppDestination.support,
    ),
  ];

  final List<_ServiceItem> _services = const [
    _ServiceItem(
      icon: Icons.account_balance_wallet_rounded,
      label: 'គណនី',
      destination: _AppDestination.account,
    ),
    _ServiceItem(
      icon: Icons.receipt_long_rounded,
      label: 'ការទូទាត់',
      destination: _AppDestination.paymentPage,
    ),
    _ServiceItem(
      icon: Icons.swap_horiz_rounded,
      label: 'ផ្ទេរប្រាក់',
      destination: _AppDestination.transfer,
    ),
    _ServiceItem(
      icon: Icons.savings_rounded,
      label: 'កម្ចី',
      destination: _AppDestination.borrow,
    ),
    _ServiceItem(
      icon: Icons.credit_card_rounded,
      label: 'ប័ណ្ណ',
      destination: _AppDestination.card,
    ),
    _ServiceItem(
      icon: Icons.bookmark_rounded,
      label: 'គំរូទូទាត់',
      destination: _AppDestination.paymentModel,
    ),
  ];

  final List<_QuickAction> _quickActions = const [
    _QuickAction(icon: Icons.calendar_month_rounded, label: 'កាលវិភាគ'),
    _QuickAction(
      icon: Icons.currency_exchange_rounded,
      label: 'អត្រាប្ដូរប្រាក់',
    ),
    _QuickAction(icon: Icons.location_on_rounded, label: 'ទីតាំង'),
    _QuickAction(
      icon: Icons.receipt_long,
      label: 'សៀវភៅមូលប្បទានប័ត្រ',
      destination: _AppDestination.message,
    ),
    _QuickAction(
      icon: Icons.credit_card,
      label: 'ប័ណ្ណថ្មី',
      destination: _AppDestination.card,
    ),
    _QuickAction(
      icon: Icons.account_balance_wallet,
      label: 'គណនីថ្មី',
      destination: _AppDestination.account,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: Column(
        children: [
          _buildTopSection(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: AppColors.homeBackground),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAccountCard(),
                    _buildBankingServices(),
                    _buildQuickActions(),
                    _buildBannerSection(),
                    _buildFrequentTransactions(),
                    _buildRecentTransactions(),
                    _buildFavorites(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Future<void> _openScreen(Widget screen) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  Future<void> _openProtectedDestination(_AppDestination destination) async {
    final unlocked = await PasswordScreen.show(context);
    if (!mounted || !unlocked) return;
    _openDestination(destination);
  }

  void _openProfile() {
    _openScreen(const ProfileScreen());
  }

  bool _shouldSelectTab(_NavItem tab) => tab.destination == null;

  void _openDestination(_AppDestination? destination) {
    if (destination == null) return;

    switch (destination) {
      case _AppDestination.qr:
        _openScreen(const QrScreen());
        break;
      case _AppDestination.service:
        _openScreen(const ServiceScreen());
        break;
      case _AppDestination.account:
        _openScreen(const AccountsScreen());
        break;
      case _AppDestination.promotion:
        _openScreen(const promotion.PromotionScreen());
        break;
      case _AppDestination.transfer:
        _openScreen(const transfer.FillScreen());
        break;
      case _AppDestination.borrow:
        _openScreen(const BorrowScreen());
        break;
      case _AppDestination.deposit:
        _openScreen(const DepositScreen());
        break;
      case _AppDestination.card:
        _openScreen(const CardScreen());
        break;
      case _AppDestination.paymentModel:
        _openScreen(const PaymentModel());
        break;
      case _AppDestination.paymentPage:
        _openScreen(const PaymentScreen());
        break;
      case _AppDestination.support:
        _openScreen(const ContactSupportScreen());
        break;
      case _AppDestination.message:
        _openScreen(const MessageScreen());
        break;
    }
  }

  Widget _buildTopSection() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildTopIconBtn(
                  icon: Icons.notifications_outlined,
                  onTap: () => _openDestination(_AppDestination.message),
                ),
                const SizedBox(width: 10),
                _buildTopIconBtn(
                  icon: Icons.qr_code_rounded,
                  onTap: () => _openDestination(_AppDestination.qr),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                  onTap: _openProfile,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38, width: 1.5),
                    ),
                    child: Stack(
                      children: [
                        const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 33,
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.priority_high,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MENG THETH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    Text(
                      "សមាជិកចាប់តាំងពីឆ្នាំ '2026",
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _openDestination(_AppDestination.service),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'សេវាកម្មរហ័ស',
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopIconBtn({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildAccountCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_balance_outlined,
                color: AppColors.primaryGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'INSTANT ACCOUNT ...3840',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'គណនីគោល',
                      style: GoogleFonts.battambang(
                        fontSize: 17,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _balanceVisible
                    ? const Text(
                        r'$ 1,250.00',
                        key: ValueKey('visible'),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      )
                    : Container(
                        key: const ValueKey('hidden'),
                        width: 160,
                        height: 22,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => setState(() => _balanceVisible = !_balanceVisible),
                child: const Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.primaryGreen,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => _openDestination(_AppDestination.transfer),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.swap_horiz_rounded,
                            color: AppColors.primaryGreen,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'ទូទាត់ និងផ្ទេរប្រាក់',
                            style: GoogleFonts.battambang(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBankingServices() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'សេវាកម្មធនាគារ',
              style: GoogleFonts.battambang(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return GestureDetector(
                  onTap: () => _openProtectedDestination(service.destination),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          service.icon,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service.label,
                        style: GoogleFonts.battambang(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _quickActions.length,
                itemBuilder: (context, index) {
                  final action = _quickActions[index];
                  return GestureDetector(
                    onTap: () => _openDestination(action.destination),
                    child: Container(
                      margin: EdgeInsets.only(
                        right: index < _quickActions.length - 1 ? 8 : 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryGreen,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              action.icon,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            action.label,
                            style: GoogleFonts.battambang(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() => const SizedBox.shrink();

  Widget _buildBannerSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: poster2.length,
              onPageChanged: (i) => setState(() => _currentBanner = i),
              itemBuilder: (context, index) {
                final poster = poster2[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    poster.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.darkGreen,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white54,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.darkGreen,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white38,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(poster2.length, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _currentBanner == i ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentBanner == i ? Colors.white : Colors.white38,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequentTransactions() {
    return _buildEmptyPanel(
      title: 'ប្រតិបត្តិការញឹកញាប់',
      message: 'មិនមានប្រតិបត្តិការទេ',
      icon: Icons.info_outline,
    );
  }

  Widget _buildRecentTransactions() {
    return _buildEmptyPanel(
      title: 'ប្រតិបត្តិការថ្មីៗ',
      message: 'មិនមានប្រតិបត្តិការទេ',
      icon: Icons.receipt_long_outlined,
      marginTop: 12,
    );
  }

  Widget _buildFavorites() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'គំរូទូទាត់',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _openDestination(_AppDestination.paymentModel),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: AppColors.primaryGreen,
                          size: 14,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'បន្ថែម',
                          style: GoogleFonts.battambang(
                            color: AppColors.primaryGreen,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark_border_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'មិនមានគំរូទូទាត់',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPanel({
    required String title,
    required String message,
    required IconData icon,
    double marginTop = 16,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, marginTop, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text(
              title,
              style: GoogleFonts.battambang(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  message,
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isSelected = _selectedIndex == index;

              if (tab.isQr) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  if (_shouldSelectTab(tab)) {
                    setState(() => _selectedIndex = index);
                  }
                  _openDestination(tab.destination);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab.icon,
                      size: 24,
                      color: isSelected
                          ? AppColors.primaryGreen
                          : Colors.grey.shade400,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tab.label,
                      style: GoogleFonts.battambang(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primaryGreen
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final bool isQr;
  final _AppDestination? destination;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isQr = false,
    this.destination,
  });
}

class _ServiceItem {
  final IconData icon;
  final String label;
  final _AppDestination destination;

  const _ServiceItem({
    required this.icon,
    required this.label,
    required this.destination,
  });
}

class _QuickAction {
  final IconData icon;
  final String label;
  final _AppDestination? destination;

  const _QuickAction({
    required this.icon,
    required this.label,
    this.destination,
  });
}

enum _AppDestination {
  qr,
  service,
  account,
  promotion,
  transfer,
  borrow,
  deposit,
  card,
  paymentModel,
  paymentPage,
  support,
  message,
}
