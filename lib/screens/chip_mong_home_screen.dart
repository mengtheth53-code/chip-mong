import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_history_screen.dart';
import 'account_screen.dart';
import '../widgets/pay_transfer_sheet.dart';
import '../theme/app_theme.dart';
import 'borrow_screen.dart';
import 'card_screen.dart';
import 'chip_mong_map_screen.dart';
import 'contact_support_screen.dart';
import 'create_payment_template_screen.dart';
import 'deposit_screen.dart';
import 'message_screen.dart';
import 'payment_page.dart';
import '../widgets/payment_model.dart';
import '../widgets/poster.dart';
import 'profile_screen.dart';
import 'promotion_screen.dart' as promotion;
import 'qr_screen.dart';
import 'scan_qr_screen.dart';
import 'cheque_book_screen.dart';
import 'exchange_rates_screen.dart';
import 'open_account_screen.dart';
import 'phone_topup_screen.dart';
import 'schedule_screen.dart';
import 'service_screen.dart';
import 'transfer_screen.dart' as transfer;
import '../widgets/transaction_receipt_sheet.dart';
import 'ai_assistant_screen.dart';
import 'smart_credit_screen.dart';
import 'campus_hub_screen.dart';
import 'shared_savings_screen.dart';
import 'daily_auto_savings_screen.dart';
import 'biometric_auth_screen.dart';
import 'innovation_hub_screen.dart';

class ChipMongHomeScreen extends StatefulWidget {
  const ChipMongHomeScreen({super.key});

  @override
  State<ChipMongHomeScreen> createState() => _ChipMongHomeScreenState();
}

class _ChipMongHomeScreenState extends State<ChipMongHomeScreen> {
  int _selectedIndex = 0;
  bool _balanceVisible = false;
  int _currentBanner = 0;

  Future<void> _openProtectedDestination(_AppDestination destination) async {
    _openDestination(destination);
  }

  final List<_NavItem> _tabs = const [
    _NavItem(
      icon: Icons.home_rounded,
      label: 'ទំព័រដើម',
      destination: null,
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
      icon: Icons.swap_horiz_rounded,
      label: 'ផ្ទេរប្រាក់',
      destination: _AppDestination.transfer,
    ),
    _ServiceItem(
      icon: Icons.receipt_long_rounded,
      label: 'ការទូទាត់',
      destination: _AppDestination.paymentPage,
    ),
    _ServiceItem(
      icon: Icons.phone_android_rounded,
      label: 'បញ្ចូលលុយទូរស័ព្ទ',
      destination: _AppDestination.topup,
    ),
    _ServiceItem(
      icon: Icons.local_atm_rounded,
      label: 'ដកប្រាក់រហ័ស',
      destination: _AppDestination.deposit,
    ),
    _ServiceItem(
      icon: Icons.account_balance_wallet_rounded,
      label: 'គណនី',
      destination: _AppDestination.account,
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
      icon: Icons.savings_outlined,
      label: 'សន្សំ',
      destination: _AppDestination.termDeposit,
    ),
    _ServiceItem(
      icon: Icons.apps_rounded,
      label: 'ផ្សេងៗ',
      destination: _AppDestination.service,
    ),
  ];

  final List<_QuickAction> _quickActions = const [
    _QuickAction(
      icon: Icons.lightbulb_rounded,
      label: 'នវានុវត្តន៍ទាំង ៥',
      destination: _AppDestination.innovationHub,
    ),
    _QuickAction(
      icon: Icons.fingerprint_rounded,
      label: 'ជីវមាត្រ Biometric',
      destination: _AppDestination.biometricAuth,
    ),
    _QuickAction(
      icon: Icons.psychology_rounded,
      label: 'AI ជំនួយការ',
      destination: _AppDestination.aiAssistant,
    ),
    _QuickAction(
      icon: Icons.school_rounded,
      label: 'Campus Hub',
      destination: _AppDestination.campusHub,
    ),
    _QuickAction(
      icon: Icons.bolt_rounded,
      label: 'AI ឥណទាន',
      destination: _AppDestination.smartCredit,
    ),
    _QuickAction(
      icon: Icons.savings_rounded,
      label: 'សន្សំប្រចាំថ្ងៃ',
      destination: _AppDestination.dailyAutoSavings,
    ),
    _QuickAction(
      icon: Icons.groups_rounded,
      label: 'សន្សំរួមគ្នា',
      destination: _AppDestination.sharedSavings,
    ),
    _QuickAction(
      icon: Icons.calendar_month_rounded,
      label: 'កាលវិភាគ',
      destination: _AppDestination.schedule,
    ),
    _QuickAction(
      icon: Icons.currency_exchange_rounded,
      label: 'អត្រាប្ដូរប្រាក់',
      destination: _AppDestination.exchangeRates,
    ),
    _QuickAction(
      icon: Icons.location_on_rounded,
      label: 'ទីតាំង',
      destination: _AppDestination.location,
    ),
    _QuickAction(
      icon: Icons.receipt_long,
      label: 'សៀវភៅមូលប្បទានប័ត្រ',
      destination: _AppDestination.chequeBook,
    ),
    _QuickAction(
      icon: Icons.credit_card,
      label: 'ប័ណ្ណថ្មី',
      destination: _AppDestination.card,
    ),
    _QuickAction(
      icon: Icons.account_balance_wallet,
      label: 'គណនីថ្មី',
      destination: _AppDestination.openAccount,
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
                    _buildGreetingHeader(),
                    _buildAccountCard(),
                    _buildInnovationHubBanner(),
                    _buildBankingServices(),
                    _buildQuickActions(),
                    _buildBannerSection(),
                    _buildFrequentTransactions(),
                    _buildRecentTransactions(),
                    _buildFavorites(),
                    _buildOtherServices(),
                    _buildCustomizeAppCard(),
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
        showQuickServicesSheet(context);
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
      case _AppDestination.topup:
        _openScreen(const PhoneTopupScreen());
        break;
      case _AppDestination.termDeposit:
      case _AppDestination.openAccount:
        _openScreen(const OpenAccountScreen());
        break;
      case _AppDestination.exchangeRates:
        _openScreen(const ExchangeRatesScreen());
        break;
      case _AppDestination.schedule:
        _openScreen(const ScheduleScreen());
        break;
      case _AppDestination.chequeBook:
        _openScreen(const ChequeBookScreen());
        break;
      case _AppDestination.location:
        _openScreen(const ChipMongMapScreen());
        break;
      case _AppDestination.innovationHub:
        _openScreen(const InnovationHubScreen());
        break;
      case _AppDestination.biometricAuth:
        _openScreen(const BiometricAuthScreen());
        break;
      case _AppDestination.aiAssistant:
        _openScreen(const AiAssistantScreen());
        break;
      case _AppDestination.smartCredit:
        _openScreen(const SmartCreditScreen());
        break;
      case _AppDestination.campusHub:
        _openScreen(const CampusHubScreen());
        break;
      case _AppDestination.sharedSavings:
        _openScreen(const SharedSavingsScreen());
        break;
      case _AppDestination.dailyAutoSavings:
        _openScreen(const DailyAutoSavingsScreen());
        break;
    }
  }

  Widget _buildTopSection() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: _openProfile,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.7),
                        width: 1.5,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'MENG THETH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildTopIconBtn(
              icon: Icons.notifications_none_rounded,
              onTap: () => _openDestination(_AppDestination.message),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _openScreen(const ScanQrScreen()),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFE52329),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "សមាជិកចាប់តាំងពីឆ្នាំ '2026",
            style: GoogleFonts.battambang(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13.5,
            ),
          ),
          GestureDetector(
            onTap: () => _openDestination(_AppDestination.service),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
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
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
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

  Widget _buildTopIconBtn({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
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
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _openScreen(const AccountHistoryScreen()),
            child: Row(
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
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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
                          fontSize: 15,
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _openScreen(const AccountHistoryScreen()),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _balanceVisible
                        ? const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '94.24 KHR',
                              key: ValueKey('visible'),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              key: const ValueKey('hidden'),
                              width: 140,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => setState(() => _balanceVisible = !_balanceVisible),
                child: Icon(
                  _balanceVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
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
                  onTap: () => showPayAndTransferSheet(context),
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
                            Icons.north_east_rounded,
                            color: AppColors.primaryGreen,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'ទូទាត់ និងផ្ទេរប្រាក់',
                            style: GoogleFonts.battambang(
                              fontSize: 16,
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

  Widget _buildInnovationHubBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF063A1D),
            Color(0xFF095A2C),
            Color(0xFF0B6B38),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF34D399).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF085329).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _openScreen(const InnovationHubScreen()),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag & Executive Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFFBBF24).withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome, color: Color(0xFFFBBF24), size: 13),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                '៥ គំនិតនវានុវត្តន៍ • INNOVATIONS',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                  color: const Color(0xFFFBBF24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'HR & LEADERSHIP',
                        style: GoogleFonts.roboto(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Main Title & Subtitle
                Text(
                  'គំនិតនវានុវត្តន៍ទាំង ៥ សម្រាប់ធនាគារ ជីប ម៉ុង',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ដំណោះស្រាយ Biometrics ចូលប្រើនិងទូទាត់, AI ឥណទាន, Campus Hub, និងការសន្សំស្វ័យប្រវត្ត',
                  style: GoogleFonts.battambang(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),

                // Horizontal Mini Shortcuts for all 5 features
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildInnovationMiniPill(
                        icon: Icons.fingerprint_rounded,
                        label: 'One-Touch QuickPay',
                        onTap: () => _openScreen(const BiometricAuthScreen()),
                      ),
                      const SizedBox(width: 8),
                      _buildInnovationMiniPill(
                        icon: Icons.bolt_rounded,
                        label: 'Smart Nano-Credit',
                        onTap: () => _openScreen(const SmartCreditScreen()),
                      ),
                      const SizedBox(width: 8),
                      _buildInnovationMiniPill(
                        icon: Icons.school_rounded,
                        label: 'NUM Campus Hub',
                        onTap: () => _openScreen(const CampusHubScreen()),
                      ),
                      const SizedBox(width: 8),
                      _buildInnovationMiniPill(
                        icon: Icons.groups_rounded,
                        label: 'Shared Goal Vault',
                        onTap: () => _openScreen(const SharedSavingsScreen()),
                      ),
                      const SizedBox(width: 8),
                      _buildInnovationMiniPill(
                        icon: Icons.savings_rounded,
                        label: 'Daily Auto-Save',
                        onTap: () => _openScreen(const DailyAutoSavingsScreen()),
                      ),
                      const SizedBox(width: 8),
                      _buildInnovationMiniPill(
                        icon: Icons.psychology_rounded,
                        label: 'AI Assistant',
                        onTap: () => _openScreen(const AiAssistantScreen()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Explore Hub CTA
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _openScreen(const InnovationHubScreen()),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'បើកមើលបទបង្ហាញពេញលេញ (Open Full Presentation)',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _buildInnovationMiniPill({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 5),
            Text(
              label,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
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
                childAspectRatio: 0.95,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
              ),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _openProtectedDestination(service.destination),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0FA958),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          service.icon,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        service.label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.battambang(
                          fontSize: 14.5,
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
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        height: 52,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _quickActions.length,
          itemBuilder: (context, index) {
            final action = _quickActions[index];
            return GestureDetector(
              onTap: () {
                if (action.label == 'ទីតាំង') {
                  _openScreen(const ChipMongMapScreen());
                } else if (action.destination != null) {
                  _openDestination(action.destination);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'សេវាកម្ម ${action.label}',
                        style: GoogleFonts.battambang(),
                      ),
                    ),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: index < _quickActions.length - 1 ? 8 : 0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0FA958),
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
                        fontSize: 14.5,
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
    );
  }

  Widget _buildBannerSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        children: [
          SizedBox(
            height: 195,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: PageView(
                    onPageChanged: (i) => setState(() => _currentBanner = i),
                    children: [
                      _buildVisaCashbackBanner(),
                      _buildSavingsBanner(),
                      _buildNetworkBanner(poster2[0].image),
                      _buildNetworkBanner(poster2[1].image),
                    ],
                  ),
                ),
                // Indicator dots in translucent pill inside banner bottom
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(4, (i) {
                          final isActive = _currentBanner == i;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: isActive ? 7 : 5,
                            height: isActive ? 7 : 5,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF0FA958)
                                  : Colors.white.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
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

  Widget _buildNetworkBanner(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => _buildVisaCashbackBanner(),
    );
  }

  Widget _buildVisaCashbackBanner() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E1E1E),
            Color(0xFF121212),
            Color(0xFF2C2416),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Gold Accents
          Positioned(
            right: -30,
            bottom: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD97706).withValues(alpha: 0.15),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'កាន់តែចំណាយ កាន់តែចំណេញ',
                        style: GoogleFonts.battambang(
                          color: const Color(0xFFF59E0B),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 12,
                            height: 1.35,
                          ),
                          children: const [
                            TextSpan(text: 'ទទួលបានប្រាក់ត្រឡប់មកវិញរហូតដល់ '),
                            TextSpan(
                              text: '\$100\n',
                              style: TextStyle(
                                color: Color(0xFFF59E0B),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'ជាមួយ ',
                            ),
                            TextSpan(
                              text: 'ប័ណ្ណឥណទាន Visa ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: 'ធនាគារ ជីប ម៉ុង'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Mini Visa Cards Graphic
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFE2E8F0), Color(0xFF94A3B8)],
                              ),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.white70, width: 0.5),
                            ),
                            child: const Center(
                              child: Text(
                                'VISA',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 48,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFDE68A), Color(0xFFD97706)],
                              ),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.white70, width: 0.5),
                            ),
                            child: const Center(
                              child: Text(
                                'VISA',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Right Ambassador Illustration
                Expanded(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFEF3C7).withValues(alpha: 0.2),
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.credit_card_rounded,
                          size: 68,
                          color: Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Logo top right
          Positioned(
            top: 12,
            right: 12,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.donut_large_rounded,
                  color: Color(0xFF0FA958),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  'CHIP MONG\nBANK',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 7.5,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsBanner() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE6F7EF),
            Color(0xFFD1FAE5),
            Color(0xFF10B981),
          ],
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Chip Mong Bank logo
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.donut_large_rounded,
                            color: Color(0xFF0FA958),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'CHIP MONG\nBANK',
                            style: GoogleFonts.roboto(
                              color: const Color(0xFF065F46),
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'បង្កើនចំណេញលុយ',
                        style: GoogleFonts.battambang(
                          color: const Color(0xFF065F46),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF065F46),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'តាម CHIP MONG BANK APP',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Badge 3%
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: const BoxDecoration(
                        color: Color(0xFF065F46),
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'បានការប្រាក់',
                            style: GoogleFonts.battambang(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                          const Text(
                            '3%',
                            style: TextStyle(
                              color: Color(0xFFFBBF24),
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'ក្នុងមួយឆ្នាំ',
                            style: GoogleFonts.battambang(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ],
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

  Widget _buildFrequentTransactions() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ប្រតិបត្តិការញឹកញាប់',
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.radio_button_checked,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'មិនមានប្រតិបត្តិការទេ',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final transactions = [
      {
        'title': 'THETH MENG',
        'date': 'សីហា 05, 2026 | 02:55 PM',
        'amount': '-20,000 ៛',
      },
      {
        'title': 'THETH MENG',
        'date': 'សីហា 05, 2026 | 02:55 PM',
        'amount': '-50,000 ៛',
      },
      {
        'title': 'THETH MENG',
        'date': 'សីហា 05, 2026 | 01:48 PM',
        'amount': '-100,000 ៛',
      },
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text(
              'ប្រតិបត្តិការថ្មីៗ',
              style: GoogleFonts.battambang(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: List.generate(transactions.length, (index) {
                final item = transactions[index];
                final isLast = index == transactions.length - 1;
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showTransactionReceiptSheet(
                          context,
                          title: item['title']!,
                          subtitle: item['title']!,
                          amount: item['amount']!,
                          date: item['date']!,
                          isIncome: false,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            // Red Octagonal / Star Icon
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE52329),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.stars_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    item['date']!,
                                    style: GoogleFonts.battambang(
                                      fontSize: 12.5,
                                      color: const Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Masked Amount Capsule
                            _buildMaskedAmountPill(item['amount']!),
                          ],
                        ),
                      ),
                    ),
                    if (!isLast)
                      const Divider(
                        height: 12,
                        thickness: 0.6,
                        color: Color(0xFFE5E7EB),
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaskedAmountPill(String amount) {
    return GestureDetector(
      onTap: () => setState(() => _balanceVisible = !_balanceVisible),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: _balanceVisible
            ? Text(
                amount,
                style: GoogleFonts.roboto(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F2937),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 75,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade300,
                          Colors.grey.shade400,
                          Colors.grey.shade300,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFavorites() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'គំរូទូទាត់',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: () => _openScreen(const CreatePaymentTemplateScreen()),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+ បន្ថែម',
                    style: GoogleFonts.battambang(
                      color: const Color(0xFF0C8A4A),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.radio_button_checked,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'មិនមានគំរូទូទាត់',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtherServices() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'សេវាកម្មផ្សេងៗ',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: () => showQuickServicesSheet(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'បង្ហាញទាំងអស់',
                    style: GoogleFonts.battambang(
                      color: const Color(0xFF0C8A4A),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'សេវាព័ត៌មានក្បាលដី (អគ្គនាយកដ្ឋានសុរិយោដី និងភូមិសាស្ត្រ)',
                    style: GoogleFonts.battambang(),
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF67B0E8),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0284C7),
                        shape: BoxShape.circle,
                      ),
                      child: const Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.public, color: Colors.white, size: 24),
                          Icon(
                            Icons.architecture_rounded,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'សេវាព័ត៌មានក...',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizeAppCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'កែប្រែកម្មវិធីរបស់អ្នក',
            style: GoogleFonts.battambang(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'កំណត់ឥឡូវនេះដើម្បីប្រើប្រាស់ផ្ទាំងវិជិតនិងម៉ូតរចនាកាតជាច្រើន ដែលមាននៅក្នុងកម្មវិធីរបស់អ្នក។',
            style: GoogleFonts.battambang(
              fontSize: 13,
              color: const Color(0xFF6B7280),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'មុខងារកែប្រែផ្ទាំងវិជិត និងម៉ូតរចនាកាត',
                        style: GoogleFonts.battambang(),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF5EA),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    'កំណត់ឥឡូវនេះ',
                    style: GoogleFonts.battambang(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0C8A4A),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 48,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFF34D399), width: 2),
                            left: BorderSide(color: Color(0xFF34D399), width: 2),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          4,
                          (_) => Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF34D399).withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                return Expanded(
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _openDestination(_AppDestination.qr),
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
                  ),
                );
              }

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
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
                        textAlign: TextAlign.center,
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
  topup,
  termDeposit,
  openAccount,
  exchangeRates,
  schedule,
  chequeBook,
  location,
  innovationHub,
  biometricAuth,
  aiAssistant,
  smartCredit,
  campusHub,
  sharedSavings,
  dailyAutoSavings,
}
