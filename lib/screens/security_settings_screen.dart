import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'password_screen.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  static const Color _bgGray = Color(0xFFF2F4F7);
  static const Color _green = Color(0xFF0FA958);

  bool _biometricLogin = false;
  bool _biometricTransfer = false;
  bool _privateDataMode = false;
  String _autoLogoutDuration = '៣០ វិនាទី';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'សុវត្ថិភាព',
          style: GoogleFonts.battambang(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 4),
            child: Text(
              'គ្រប់គ្រងការកំណត់គណនី និងការកំណត់សុវត្ថិភាពរបស់អ្នកបានយ៉ាងងាយស្រួល',
              style: GoogleFonts.battambang(
                fontSize: 15,
                color: const Color(0xFF64748B),
                height: 1.45,
              ),
            ),
          ),
          _buildToggleCard(
            icon: Icons.fingerprint_rounded,
            title: 'ចូលគណនីតាមរយៈ Biometrics',
            value: _biometricLogin,
            onChanged: (val) => setState(() => _biometricLogin = val),
          ),
          const SizedBox(height: 12),
          _buildToggleCard(
            icon: Icons.document_scanner_outlined,
            title: 'ទូទាត់ & ផ្ទេរប្រាក់ដោយប្រើ Biometrics',
            value: _biometricTransfer,
            onChanged: (val) => setState(() => _biometricTransfer = val),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            icon: Icons.pin_outlined,
            title: 'ប្តូរលេខសម្ងាត់ ( PIN )',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PasswordScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            icon: Icons.logout_rounded,
            title: 'ចាកចេញដោយស្វ័យប្រវត្តិកក្រោយពី',
            trailingText: _autoLogoutDuration,
            onTap: _showAutoLogoutPicker,
          ),
          const SizedBox(height: 12),
          _buildToggleCard(
            icon: Icons.visibility_off_outlined,
            title: 'មុខងារ ទិន្នន័យសម្ងាត់',
            value: _privateDataMode,
            onChanged: (val) => setState(() => _privateDataMode = val),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: _green, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.battambang(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            activeThumbColor: _green,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
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
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Icon(icon, color: _green, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.battambang(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: GoogleFonts.battambang(
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

  void _showAutoLogoutPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final options = ['៣០ វិនាទី', '១ នាទី', '៥ នាទី', '១០ នាទី'];
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ចាកចេញដោយស្វ័យប្រវត្តិក្រោយពី',
                style: GoogleFonts.battambang(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...options.map(
                (opt) => ListTile(
                  title: Text(
                    opt,
                    style: GoogleFonts.battambang(fontSize: 16),
                  ),
                  trailing: _autoLogoutDuration == opt
                      ? const Icon(Icons.check, color: _green)
                      : null,
                  onTap: () {
                    setState(() => _autoLogoutDuration = opt);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
