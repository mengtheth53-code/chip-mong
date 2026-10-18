import 'package:flutter/material.dart';

class AppLanguage {
  // ValueNotifier to trigger reactive updates across any screen listening to it
  static final ValueNotifier<String> languageNotifier =
      ValueNotifier<String>('km');

  static String get currentLanguage => languageNotifier.value;

  static bool get isKhmer =>
      languageNotifier.value == 'km' || languageNotifier.value == 'ភាសាខ្មែរ';

  static bool get isEnglish => !isKhmer;

  static void setLanguage(String lang) {
    if (lang == 'en' || lang.toLowerCase() == 'english') {
      languageNotifier.value = 'en';
    } else {
      languageNotifier.value = 'km';
    }
  }

  static void toggleLanguage() {
    if (isKhmer) {
      setLanguage('en');
    } else {
      setLanguage('km');
    }
  }

  // Quick bilingual string helper
  static String tr({required String km, required String en}) {
    return isKhmer ? km : en;
  }

  // Common UI Vocabulary Dictionary
  static String get settings => tr(km: 'ការកំណត់', en: 'Settings');
  static String get userId =>
      tr(km: 'លេខសម្គាល់: 0126103000082', en: 'User ID: 0126103000082');
  static String get myProfile =>
      tr(km: 'ប្រវត្តិរូបរបស់ខ្ញុំ', en: 'My Profile');
  static String get security => tr(km: 'សុវត្ថិភាព', en: 'Security');
  static String get language => tr(km: 'ភាសា', en: 'Language');
  static String get languageName => tr(km: 'ភាសាខ្មែរ', en: 'English');
  static String get termsAndConditions =>
      tr(km: 'ខចែង និងលក្ខខណ្ឌទូទៅ', en: 'Terms & Conditions');
  static String get appVersion =>
      tr(km: 'កំណែកម្មវិធី: 5.2.17 - 5021703', en: 'App Version: 5.2.17 - 5021703');
  static String get lastLogin =>
      tr(km: 'login ចុងក្រោយ: Oct 05, 2026 | 11:39 PM', en: 'Last login: Oct 05, 2026 | 11:39 PM');
  static String get chooseLanguage =>
      tr(km: 'ជ្រើសរើសភាសា', en: 'Choose Language');

  // Bottom Navigation & Home
  static String get navHome => tr(km: 'ទំព័រដើម', en: 'Home');
  static String get navPromotions => tr(km: 'ប្រូម៉ូសិន', en: 'Promotions');
  static String get navQr => tr(km: 'QR', en: 'KHQR');
  static String get navBorrow => tr(km: 'កម្ចី', en: 'Loans');
  static String get navSupport => tr(km: 'ជំនួយ', en: 'Support');

  // Quick Action Buttons
  static String get actionTransfer => tr(km: 'ផ្ទេរប្រាក់', en: 'Transfer');
  static String get actionPayment => tr(km: 'ទូទាត់', en: 'Payments');
  static String get actionOpenAccount => tr(km: 'បើកគណនី', en: 'Open Account');
  static String get actionCardlessCash => tr(km: 'ដកប្រាក់', en: 'Cardless Cash');
  static String get actionCards => tr(km: 'ប័ណ្ណ', en: 'Cards');
  static String get actionServices => tr(km: 'សេវាកម្ម', en: 'Services');
  static String get actionRates => tr(km: 'អត្រាប្តូរប្រាក់', en: 'Exchange Rates');
  static String get actionBranches => tr(km: 'សាខា & ATM', en: 'Branches & ATMs');

  // Dashboard Greetings & Balances
  static String get greeting => tr(km: 'ទិវាសួស្តី,', en: 'Good afternoon,');
  static String get totalBalance => tr(km: 'សមតុល្យសរុប', en: 'Total Balance');
  static String get savingsAccount => tr(km: 'គណនីសន្សំ', en: 'Savings Account');
  static String get currentAccount => tr(km: 'គណនីចរន្ត', en: 'Current Account');
  static String get viewHistory => tr(km: 'មើលប្រវត្តិ', en: 'View History');
  static String get searchHint => tr(km: 'ស្វែងរកមុខងារ ឬសេវាកម្ម...', en: 'Search features or services...');
}
