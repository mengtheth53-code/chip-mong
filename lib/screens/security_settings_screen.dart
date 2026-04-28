import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';



class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricLogin = false;
  bool _biometricTransfer = false;
  bool _hideBalance = false;
  String _autoLogoutDuration = '៣០ នាទី';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title:  Text(
          'សុវត្ថិភាព',
          style:GoogleFonts.battambang(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
         
        Padding(
            padding: EdgeInsets.only(bottom: 16, top: 4),
            child: Text(
              'គ្រប់គ្រងការកំណត់គណនី និងការកំណត់សុវត្ថិភាពរបស់អ្នកបានយ៉ាងងាយស្រួល',
              style: GoogleFonts.battambang(
                fontSize: 18,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ),

          
          _buildSettingCard(
            icon: CupertinoIcons.person_crop_circle_badge_checkmark,
            iconColor: Color.fromARGB(255, 51, 155, 124),
            title: 'ចូលគណនីតាមរយៈ Biometrics',
            trailing: CupertinoSwitch(
              value: _biometricLogin,
              activeTrackColor: const Color(0xFF34C759),
              onChanged: (val) => setState(() => _biometricLogin = val),
            ),
          ),

          const SizedBox(height: 12),

         
          _buildSettingCard(
            icon: CupertinoIcons.eye_slash,
            iconColor: Color.fromARGB(255, 51, 155, 124),
            title: 'ទូទាត់ & ផ្ទេរប្រាក់ដោយប្រើ Biometrics',
            trailing: CupertinoSwitch(
              value: _biometricTransfer,
              activeTrackColor: const Color(0xFF34C759),
              onChanged: (val) => setState(() => _biometricTransfer = val),
            ),
          ),

          const SizedBox(height: 12),

        
          _buildSettingCard(
            icon: CupertinoIcons.lock_fill,
            iconColor: Color.fromARGB(255, 51, 155, 124),
            title: 'ប្តូរលេខសម្ងាត់ (PIN)',
            trailing: const Icon(
              Icons.chevron_right,
              color: Color(0xFFC7C7CC),
            ),
            onTap: () {
              
            },
          ),

          const SizedBox(height: 12),

          
          _buildSettingCard(
            icon: CupertinoIcons.arrow_right_square_fill,
            iconColor: Color.fromARGB(255, 51, 155, 124),
            title: 'ចាកចេញដោយស្វ័យប្រវត្តិក្រោយពី',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _autoLogoutDuration,
                  style: GoogleFonts.battambang(
                    fontSize: 18,
                    color: Color(0xFF8A8A8E),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFC7C7CC),
                ),
              ],
            ),
            onTap: () {
              _showAutoLogoutPicker(context);
            },
          ),

          const SizedBox(height: 12),

        
          _buildSettingCard(
            icon: CupertinoIcons.eye_slash_fill,
            iconColor:  Color.fromARGB(255, 51, 155, 124),
            title: 'មុខងារ ទិន្នន័យសម្ងាត់',
            trailing: CupertinoSwitch(
              value: _hideBalance,
              activeTrackColor: const Color(0xFF34C759),
              onChanged: (val) => setState(() => _hideBalance = val),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.battambang(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  void _showAutoLogoutPicker(BuildContext context) {
    final options = [' ៥វិនាទី', '១០ វិនាទី', '១៥ វិនាទី', '៣០ វិនាទី', '៦០ វិនាទី'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'ចាកចេញដោយស្វ័យប្រវត្តិ',
                  style: GoogleFonts.battambang(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Divider(height: 1),
              ...options.map((option) => ListTile(
                    title: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: option == _autoLogoutDuration
                            ? const Color(0xFF34C759)
                            : Colors.black,
                        fontWeight: option == _autoLogoutDuration
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() => _autoLogoutDuration = option);
                      Navigator.pop(context);
                    },
                  )),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
