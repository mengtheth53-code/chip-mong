import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bank/widgets/pay_transfer_sheet.dart';
import 'package:bank/screens/service_screen.dart';
import 'package:bank/theme/app_language.dart';

void main() {
  setUp(() {
    AppLanguage.setLanguage('km');
  });

  group('Sheets and Dialogs Language Tests', () {
    testWidgets('PayAndTransferSheet renders properly in Khmer and English',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PayAndTransferSheet(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Khmer mode
      expect(find.text('ទូទាត់ និងផ្ទេរប្រាក់'), findsOneWidget);
      expect(find.text('ផ្ទេរប្រាក់ទៅគណនី\nខ្លួនឯង'), findsOneWidget);

      // English mode
      AppLanguage.setLanguage('en');
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PayAndTransferSheet(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pay & Transfer'), findsOneWidget);
      expect(find.text('Transfer to Own\nAccount'), findsOneWidget);
      expect(find.text('Transfer to Chip\nMong Account'), findsOneWidget);
      expect(find.text('Bakong\nTransfer'), findsOneWidget);
      expect(find.text('Bank\nTransfer'), findsOneWidget);
      expect(find.text('Cardless\nWithdrawal'), findsOneWidget);
    });

    testWidgets('ServiceScreen renders properly in Khmer and English',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ServiceScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Khmer mode
      expect(find.text('សេវាកម្មរហ័ស'), findsOneWidget);
      expect(find.text('សេវាកម្ម'), findsOneWidget);
      expect(find.text('សេវាកម្មផ្សេងៗ'), findsOneWidget);

      // English mode
      AppLanguage.setLanguage('en');
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ServiceScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Quick Services'), findsOneWidget);
      expect(find.text('Selected Services'), findsOneWidget);
      expect(find.text('Other Services'), findsOneWidget);
    });
  });
}
