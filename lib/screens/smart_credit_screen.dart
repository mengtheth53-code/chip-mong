import 'package:flutter/material.dart';
import 'ai_assistant_screen.dart';

/// Unified SmartCreditScreen pointing to the combined AI & Smart Credit hub.
class SmartCreditScreen extends StatelessWidget {
  final int initialIndex;
  const SmartCreditScreen({super.key, this.initialIndex = 1});

  @override
  Widget build(BuildContext context) {
    return AiAssistantScreen(initialIndex: initialIndex);
  }
}
