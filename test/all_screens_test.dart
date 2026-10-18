import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bank/screens/chip_mong_home_screen.dart';
import 'package:bank/screens/innovation_hub_screen.dart';
import 'package:bank/screens/biometric_auth_screen.dart';
import 'package:bank/screens/smart_credit_screen.dart';
import 'package:bank/screens/campus_hub_screen.dart';
import 'package:bank/screens/shared_savings_screen.dart';
import 'package:bank/screens/daily_auto_savings_screen.dart';
import 'package:bank/screens/ai_assistant_screen.dart';
import 'package:bank/screens/account_screen.dart';
import 'package:bank/screens/account_history_screen.dart';
import 'package:bank/screens/account_info_screen.dart';
import 'package:bank/screens/card_screen.dart';
import 'package:bank/screens/qr_screen.dart';
import 'package:bank/screens/borrow_screen.dart';
import 'package:bank/screens/deposit_screen.dart';
import 'package:bank/screens/open_account_screen.dart';
import 'package:bank/screens/exchange_rates_screen.dart';
import 'package:bank/screens/cheque_book_screen.dart';
import 'package:bank/screens/contact_support_screen.dart';
import 'package:bank/screens/chip_mong_map_screen.dart';
import 'package:bank/screens/message_screen.dart';
import 'package:bank/screens/phone_topup_screen.dart';
import 'package:bank/screens/promotion_screen.dart';
import 'package:bank/screens/profile_screen.dart';
import 'package:bank/screens/security_settings_screen.dart';
import 'package:bank/screens/service_screen.dart';
import 'package:bank/screens/schedule_screen.dart';
import 'package:bank/screens/aboutapp_screen.dart';
import 'package:bank/screens/splash_screen.dart';
import 'package:bank/screens/welcome_page.dart';

Future<void> _pumpScreen(WidgetTester tester, Widget screen) async {
  tester.view.physicalSize = const Size(412, 915);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  await tester.pumpWidget(MaterialApp(home: screen));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('All Screens Build & Render Verification', () {
    testWidgets('ChipMongHomeScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ChipMongHomeScreen());
      expect(find.byType(ChipMongHomeScreen), findsOneWidget);
    });

    testWidgets('InnovationHubScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const InnovationHubScreen());
      expect(find.byType(InnovationHubScreen), findsOneWidget);
    });

    testWidgets('BiometricAuthScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const BiometricAuthScreen());
      expect(find.byType(BiometricAuthScreen), findsOneWidget);
    });

    testWidgets('SmartCreditScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const SmartCreditScreen());
      expect(find.byType(SmartCreditScreen), findsOneWidget);
    });

    testWidgets('CampusHubScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const CampusHubScreen());
      expect(find.byType(CampusHubScreen), findsOneWidget);
    });

    testWidgets('SharedSavingsScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const SharedSavingsScreen());
      expect(find.byType(SharedSavingsScreen), findsOneWidget);
    });

    testWidgets('DailyAutoSavingsScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const DailyAutoSavingsScreen());
      expect(find.byType(DailyAutoSavingsScreen), findsOneWidget);
    });

    testWidgets('AiAssistantScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const AiAssistantScreen());
      expect(find.byType(AiAssistantScreen), findsOneWidget);
    });

    testWidgets('AccountsScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const AccountsScreen());
      expect(find.byType(AccountsScreen), findsOneWidget);
    });

    testWidgets('AccountHistoryScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const AccountHistoryScreen());
      expect(find.byType(AccountHistoryScreen), findsOneWidget);
    });

    testWidgets('AccountInfoScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const AccountInfoScreen());
      expect(find.byType(AccountInfoScreen), findsOneWidget);
    });

    testWidgets('CardScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const CardScreen());
      expect(find.byType(CardScreen), findsOneWidget);
    });

    testWidgets('QrScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const QrScreen());
      expect(find.byType(QrScreen), findsOneWidget);
    });

    testWidgets('BorrowScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const BorrowScreen());
      expect(find.byType(BorrowScreen), findsOneWidget);
    });

    testWidgets('DepositScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const DepositScreen());
      expect(find.byType(DepositScreen), findsOneWidget);
    });

    testWidgets('OpenAccountScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const OpenAccountScreen());
      expect(find.byType(OpenAccountScreen), findsOneWidget);
    });

    testWidgets('ExchangeRatesScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ExchangeRatesScreen());
      expect(find.byType(ExchangeRatesScreen), findsOneWidget);
    });

    testWidgets('ChequeBookScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ChequeBookScreen());
      expect(find.byType(ChequeBookScreen), findsOneWidget);
    });

    testWidgets('ContactSupportScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ContactSupportScreen());
      expect(find.byType(ContactSupportScreen), findsOneWidget);
    });

    testWidgets('ChipMongMapScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ChipMongMapScreen());
      expect(find.byType(ChipMongMapScreen), findsOneWidget);
    });

    testWidgets('MessageScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const MessageScreen());
      expect(find.byType(MessageScreen), findsOneWidget);
    });

    testWidgets('PhoneTopupScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const PhoneTopupScreen());
      expect(find.byType(PhoneTopupScreen), findsOneWidget);
    });

    testWidgets('PromotionScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const PromotionScreen());
      expect(find.byType(PromotionScreen), findsOneWidget);
    });

    testWidgets('ProfileScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ProfileScreen());
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('SecuritySettingsScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const SecuritySettingsScreen());
      expect(find.byType(SecuritySettingsScreen), findsOneWidget);
    });

    testWidgets('ServiceScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ServiceScreen());
      expect(find.byType(ServiceScreen), findsOneWidget);
    });

    testWidgets('ScheduleScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const ScheduleScreen());
      expect(find.byType(ScheduleScreen), findsOneWidget);
    });

    testWidgets('AboutAppScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const AboutAppScreen());
      expect(find.byType(AboutAppScreen), findsOneWidget);
    });

    testWidgets('SplashScreen renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const SplashScreen());
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('WelcomePage renders properly', (WidgetTester tester) async {
      await _pumpScreen(tester, const WelcomePage());
      expect(find.byType(WelcomePage), findsOneWidget);
    });
  });
}
