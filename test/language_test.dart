import 'package:flutter_test/flutter_test.dart';
import 'package:bank/theme/app_language.dart';

void main() {
  group('AppLanguage Controller & Translation Tests', () {
    setUp(() {
      AppLanguage.setLanguage('km');
    });

    test('Initial language is Khmer', () {
      expect(AppLanguage.currentLanguage, 'km');
      expect(AppLanguage.isKhmer, isTrue);
      expect(AppLanguage.isEnglish, isFalse);
    });

    test('Switching to English updates state and helpers reactively', () {
      AppLanguage.setLanguage('en');
      expect(AppLanguage.currentLanguage, 'en');
      expect(AppLanguage.isKhmer, isFalse);
      expect(AppLanguage.isEnglish, isTrue);

      expect(
        AppLanguage.tr(km: 'សួស្តី', en: 'Hello'),
        'Hello',
      );
      expect(AppLanguage.settings, 'Settings');
      expect(AppLanguage.myProfile, 'My Profile');
      expect(AppLanguage.actionTransfer, 'Transfer');
    });

    test('Switching back to Khmer returns Khmer translations', () {
      AppLanguage.setLanguage('en');
      AppLanguage.setLanguage('km');
      expect(AppLanguage.currentLanguage, 'km');
      expect(AppLanguage.isKhmer, isTrue);
      expect(
        AppLanguage.tr(km: 'សួស្តី', en: 'Hello'),
        'សួស្តី',
      );
      expect(AppLanguage.settings, 'ការកំណត់');
      expect(AppLanguage.chooseLanguage, 'ជ្រើសរើសភាសា');
    });

    test('ValueNotifier notifies listeners when language changes', () {
      String observed = '';
      void listener() {
        observed = AppLanguage.languageNotifier.value;
      }

      AppLanguage.languageNotifier.addListener(listener);

      AppLanguage.setLanguage('en');
      expect(observed, 'en');

      AppLanguage.setLanguage('km');
      expect(observed, 'km');

      AppLanguage.languageNotifier.removeListener(listener);
    });
  });
}
