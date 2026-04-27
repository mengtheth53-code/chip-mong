import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'welcome_page.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedLanguage;
  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 109, 65),
        
      ),
      backgroundColor: const Color.fromARGB(255, 239, 244, 241),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Header
              FadeTransition(opacity: _fadeIn, child: _buildHeader()),

              const Spacer(flex: 2),

              // Icon + Title
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slideUp,
                  child: _buildIconSection(),
                ),
              ),

              const Spacer(flex: 2),

              // Language options
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slideUp,
                  child: _buildLanguageOptions(),
                ),
              ),

              const Spacer(flex: 3),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to',
          style: GoogleFonts.battambang(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text:  TextSpan(
            children: [
              TextSpan(
                text: 'CHIP MONG ',
                style: GoogleFonts.battambang(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
              TextSpan(
                text: 'BANK',
                style: GoogleFonts.battambang(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A6B3C),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconSection() {
    return Center(
      child: Column(
        children: [
          // Translate icon bubble
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFB8D9C5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Center(
              child: Icon(
                Icons.translate_rounded,
                size: 52,
                color: Color.fromARGB(255, 34, 129, 74),
              ),
            ),
          ),
          const SizedBox(height: 28),
           Text(
            'CHOOSE YOUR LANGUAGE',
            style: GoogleFonts.battambang(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOptions() {
    return Column(
      children: [
        _buildLanguageTile(
          language: 'km',
          label: 'ភាសាខ្មែរ',
          flagEmoji: '🇰🇭',
        ),
        const SizedBox(height: 14),
        _buildLanguageTile(language: 'en', label: 'English', flagEmoji: '🇺🇸'),
      ],
    );
  }

  Widget _buildLanguageTile({
    required String language,
    required String label,
    required String flagEmoji,
  }) {
    final bool isSelected = _selectedLanguage == language;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedLanguage = language);
        Future.delayed(const Duration(milliseconds: 220), () {
          if (!mounted || _selectedLanguage != language) return;
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const WelcomePage()));
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A6B3C) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Flag
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(flagEmoji, style: const TextStyle(fontSize: 30)),
              ),
            ),
            const SizedBox(width: 14),

            // Language label
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.battambang(
                  fontSize: 25,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Checkmark
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.25,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? const Color(0xFF1A6B3C) : Colors.grey,
                ),
                child: const Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
