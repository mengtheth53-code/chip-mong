import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bank/screens/chip_mong_home_screen.dart';
import 'package:bank/screens/profile_screen.dart';
import 'package:bank/widgets/language_bottom_sheet.dart';
import 'package:bank/theme/app_language.dart';

void main() {
  setUp(() {
    AppLanguage.setLanguage('km');
  });

  group('End-to-End Language Switching Widget Tests', () {
    testWidgets('ProfileScreen switches dynamically between Khmer and English',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Initial State: Khmer
      expect(find.text('ការកំណត់'), findsOneWidget);
      expect(find.text('ប្រវត្តិរូបរបស់ខ្ញុំ'), findsOneWidget);
      expect(find.text('សុវត្ថិភាព'), findsOneWidget);
      expect(find.text('ភាសា'), findsOneWidget);
      expect(find.text('ភាសាខ្មែរ'), findsOneWidget);

      // 2. Switch to English
      AppLanguage.setLanguage('en');
      await tester.pumpAndSettle();

      // Assert English labels are rendered
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('My Profile'), findsOneWidget);
      expect(find.text('Security'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);

      // 3. Switch back to Khmer
      AppLanguage.setLanguage('km');
      await tester.pumpAndSettle();

      expect(find.text('ការកំណត់'), findsOneWidget);
      expect(find.text('ប្រវត្តិរូបរបស់ខ្ញុំ'), findsOneWidget);
    });

    testWidgets('LanguageBottomSheet allows user to tap and switch language',
        (WidgetTester tester) async {
      String selectedLanguage = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageBottomSheet(
              currentLanguage: 'ភាសាខ្មែរ',
              onLanguageSelected: (lang) {
                selectedLanguage = lang;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ជ្រើសរើសភាសា'), findsOneWidget);
      expect(find.text('ភាសាខ្មែរ'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);

      // Tap English
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      expect(AppLanguage.isEnglish, isTrue);
      expect(selectedLanguage, 'English');
    });

    testWidgets('ChipMongHomeScreen displays localized labels for Khmer and English',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ChipMongHomeScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // In Khmer
      expect(find.text('សេវាកម្មធនាគារ'), findsOneWidget);
      expect(find.text('គណនីគោល'), findsOneWidget);
      expect(find.text('ទំព័រដើម'), findsOneWidget);
      expect(find.text('អត្ថប្រយោជន៍'), findsOneWidget);
      expect(find.text('ដកប្រាក់'), findsWidgets);
      expect(find.text('សេវាកម្មអតិថិជន'), findsOneWidget);

      // Switch language to English
      AppLanguage.setLanguage('en');
      await tester.pumpAndSettle();

      // In English
      expect(find.text('Banking Services'), findsOneWidget);
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Promos'), findsOneWidget);
      expect(find.text('Cash Out'), findsWidgets);
      expect(find.text('Support'), findsOneWidget);
      expect(find.text('Pay & Transfer'), findsOneWidget);
      expect(find.text('Recent Transactions'), findsOneWidget);
      expect(find.text('Frequent Transactions'), findsOneWidget);
    });
  });
}
