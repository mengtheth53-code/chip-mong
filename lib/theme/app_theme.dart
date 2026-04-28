import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF1A6B3C);
  static const Color darkGreen = Color(0xFF155A32);
  static const Color homeBackground = Color.fromARGB(255, 14, 125, 90);
  static const Color cardBackground = Color(0xFFDFF0E8);
  static const Color pageBackground = Color(0xFFF5F5F5);
  static const Color surfaceBackground = Color(0xFFF2F4F7);
}

ThemeData buildChipMongTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.pageBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),
  );
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.unknown,
  };
}
