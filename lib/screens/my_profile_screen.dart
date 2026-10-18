import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_language.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  static const Color _green = Color(0xFF0C6B38);
  static const Color _bgGray = Color(0xFFF2F4F7);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppLanguage.languageNotifier,
      builder: (context, _, __) {
        final isKhmer = AppLanguage.isKhmer;

        return Scaffold(
          backgroundColor: _bgGray,
          body: Column(
            children: [
              _buildHeader(context, isKhmer),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLanguage.tr(
                          km: 'ព័ត៌មានផ្ទាល់ខ្លួន',
                          en: 'Personal Information',
                        ),
                        style: isKhmer
                            ? GoogleFonts.battambang(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              )
                            : GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                      ),
                      const SizedBox(height: 12),
                      _buildPersonalInfoCard(isKhmer),
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

  Widget _buildHeader(BuildContext context, bool isKhmer) {
    return Container(
      color: _green,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                    AppLanguage.myProfile,
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

  Widget _buildPersonalInfoCard(bool isKhmer) {
    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.person_outline_rounded,
            label: AppLanguage.tr(km: 'ឈ្មោះ', en: 'Full Name'),
            value: 'MENG THETH',
            isKhmer: isKhmer,
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.transgender_rounded,
            label: AppLanguage.tr(km: 'ភេទ', en: 'Gender'),
            value: AppLanguage.tr(km: 'ប្រុស (M)', en: 'Male (M)'),
            isKhmer: isKhmer,
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.description_outlined,
            label: AppLanguage.tr(km: 'ប្រភេទឯកសារ', en: 'Document Type'),
            value: AppLanguage.tr(km: 'អត្តសញ្ញាណប័ណ្ណសញ្ជាតិខ្មែរ', en: 'Cambodian National ID'),
            isKhmer: isKhmer,
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.badge_outlined,
            label: AppLanguage.tr(km: 'លេខអត្តសញ្ញាណប័ណ្ណ', en: 'National ID Number'),
            value: '010892415',
            isKhmer: isKhmer,
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.access_time_rounded,
            label: AppLanguage.tr(km: 'កាលបរិច្ឆេទផុតកំណត់', en: 'Expiry Date'),
            value: '2032-10-15',
            isKhmer: isKhmer,
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.mail_outline_rounded,
            label: AppLanguage.tr(km: 'អ៊ីមែល', en: 'Email Address'),
            value: 'mengtheth@chipmongbank.com',
            isLast: true,
            isKhmer: isKhmer,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, color: Color(0xFFF1F5F9));
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isKhmer,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF94A3B8), size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: isKhmer
                      ? GoogleFonts.battambang(
                          fontSize: 14,
                          color: const Color(0xFF94A3B8),
                          fontWeight: FontWeight.w400,
                        )
                      : GoogleFonts.roboto(
                          fontSize: 14,
                          color: const Color(0xFF94A3B8),
                          fontWeight: FontWeight.w400,
                        ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: isKhmer
                      ? GoogleFonts.battambang(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        )
                      : GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
