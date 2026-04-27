import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'splash_screen.dart';

class ChipMongApp extends StatelessWidget {
  const ChipMongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chip Mong Bank',
      debugShowCheckedModeBanner: false,
      theme: buildChipMongTheme(),
      scrollBehavior: const AppScrollBehavior(),
      home: const SplashScreen(),
    );
  }
}
