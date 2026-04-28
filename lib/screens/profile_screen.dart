import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'aboutapp_screen.dart';
import 'security_settings_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryGreen = Color(0xFF1A6B3C);
  static const Color surfaceGreen = Color(0xFF234E3B);
  static const Color background = Color(0xFFF2F4F7);
  static const Color iconGreen = Color(0xFF1E7A45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          // Header section with green background
          _buildHeader(context),

          // Profile info row
          _buildProfileInfoBanner(),

          // Menu items
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    _buildMenuCard([
                      _buildMenuItem(
                        icon: Icons.verified_user_rounded,
                        label: 'សុវត្ថិភាព',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SecuritySettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ]),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _buildMenuItem(
                        icon: Icons.language_rounded,
                        label: 'ភាសា',
                        trailing: Text(
                          'ភាសាខ្មែរ',
                          style: GoogleFonts.battambang(
                            color: Color(0xFF888888),
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ]),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _buildMenuItem(
                        icon: Icons.edit_note_rounded,
                        label: 'ខចែង និងលក្ខខណ្ឌទៅ',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AboutAppScreen(),
                            ),
                          );
                        },
                      ),
                    ]),
                    const SizedBox(height: 24),
                    // Version info
                     Text(
                      'App Version:  5.2.2 - 5020200',
                      style: GoogleFonts.battambang(
                        color: Color(0xFFAAAAAA),
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                     Text(
                      'Last Login:  Apr 24, 2026 | 01:21 PM',
                      style: GoogleFonts.battambang(
                        color: Color(0xFFAAAAAA),
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Logo
                    _buildLogo(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryGreen,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: Text(
                      'ការកំណត់',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // balance the back button
                ],
              ),
              const SizedBox(height: 18),
              Container(
                width: 98,
                height: 98,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.20),
                    width: 4,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2C7A53),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 14),
               Text(
                'MENG THETH',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'លេខសម្គាល់: 0126103000082',
                style: GoogleFonts.battambang(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  'គណនីដំណើរការ',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfoBanner() {
    return Container(
      color: primaryGreen,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: surfaceGreen,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'ប្រូហ្វាលរបស់ខ្ញុំ',
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style:  GoogleFonts.battambang(
                  fontSize: 18,
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (trailing != null) ...[
              trailing,
              const SizedBox(width: 8),
            ],
            const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Chip Mong circular logo mark
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryGreen,
            border: Border.all(
              color: const Color(0xFFE0E8E3),
            ),
          ),
          child: ClipOval(
            child: Image.network(
              'https://images.crunchbase.com/image/upload/c_pad,h_256,w_256,f_auto,q_auto:eco,dpr_1/ujrwed9bibpujkrzshvt?ik-sanitizeSvg=true',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 20,
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CHIP MONG',
              style: GoogleFonts.battambang(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 45, 96, 69),
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'BANK',
              style: GoogleFonts.battambang(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color:  Color.fromARGB(255, 40, 39, 39),
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
