import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'aboutapp_screen.dart';
import 'my_profile_screen.dart';
import 'security_settings_screen.dart';
import '../widgets/language_bottom_sheet.dart';
import '../theme/app_language.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _green = Color(0xFF0C6B38);
  static const Color _bgGray = Color(0xFFF2F4F7);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppLanguage.languageNotifier,
      builder: (context, currentLang, _) {
        final isKhmer = AppLanguage.isKhmer;

        return Scaffold(
          backgroundColor: _bgGray,
          body: Column(
            children: [
              _buildGreenHeader(context, isKhmer),
              _buildMyProfileBar(context, isKhmer),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                  child: Column(
                    children: [
                      _buildMenuCard(
                        icon: Icons.verified_user_rounded,
                        label: AppLanguage.security,
                        isKhmer: isKhmer,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SecuritySettingsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildMenuCard(
                        icon: Icons.language_rounded,
                        label: AppLanguage.language,
                        trailingText: AppLanguage.languageName,
                        isKhmer: isKhmer,
                        onTap: () {
                          showLanguageBottomSheet(
                            context,
                            currentLanguage: AppLanguage.currentLanguage,
                            onLanguageSelected: (lang) {
                              AppLanguage.setLanguage(lang);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildMenuCard(
                        icon: Icons.edit_note_rounded,
                        label: AppLanguage.termsAndConditions,
                        isKhmer: isKhmer,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AboutAppScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      Text(
                        AppLanguage.appVersion,
                        style: isKhmer
                            ? GoogleFonts.battambang(
                                color: const Color(0xFF94A3B8),
                                fontSize: 13,
                              )
                            : const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                              ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLanguage.lastLogin,
                        style: isKhmer
                            ? GoogleFonts.battambang(
                                color: const Color(0xFF94A3B8),
                                fontSize: 13,
                              )
                            : const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                              ),
                      ),
                      const SizedBox(height: 36),
                      _buildChipMongLogo(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGreenHeader(BuildContext context, bool isKhmer) {
    return Container(
      color: _green,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Text(
                    AppLanguage.settings,
                    style: isKhmer
                        ? GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          )
                        : GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Big Avatar with Camera badge
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.8),
                        width: 2.5,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1EA75B),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'MENG THETH',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLanguage.userId,
                style: isKhmer
                    ? GoogleFonts.battambang(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                    : GoogleFonts.roboto(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyProfileBar(BuildContext context, bool isKhmer) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const MyProfileScreen()),
        );
      },
      child: Container(
        color: const Color(0xFF094E29),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLanguage.myProfile,
              style: isKhmer
                  ? GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )
                  : GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required bool isKhmer,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF0FA958),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: isKhmer
                    ? GoogleFonts.battambang(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      )
                    : GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
              ),
            ),
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: isKhmer
                    ? GoogleFonts.battambang(
                        fontSize: 15,
                        color: const Color(0xFF64748B),
                      )
                    : GoogleFonts.roboto(
                        fontSize: 15,
                        color: const Color(0xFF64748B),
                      ),
              ),
              const SizedBox(width: 4),
            ],
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipMongLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFF0C8A4A),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.all_inclusive_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'CHIP MONG',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0C8A4A),
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'BANK',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFFE52329),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
