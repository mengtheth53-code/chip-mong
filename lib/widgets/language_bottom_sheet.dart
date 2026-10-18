import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_language.dart';

void showLanguageBottomSheet(
  BuildContext context, {
  required String currentLanguage,
  required ValueChanged<String> onLanguageSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) => LanguageBottomSheet(
      currentLanguage: currentLanguage,
      onLanguageSelected: onLanguageSelected,
    ),
  );
}

class LanguageBottomSheet extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onLanguageSelected;

  const LanguageBottomSheet({
    super.key,
    required this.currentLanguage,
    required this.onLanguageSelected,
  });

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = AppLanguage.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLanguage.chooseLanguage,
              style: GoogleFonts.battambang(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            _buildLanguageOption(
              label: 'ភាសាខ្មែរ',
              flagEmoji: '🇰🇭',
              isKhmer: true,
              isSelected: _selected == 'km',
              onTap: () {
                setState(() => _selected = 'km');
                AppLanguage.setLanguage('km');
                widget.onLanguageSelected('ភាសាខ្មែរ');
                Navigator.pop(context);
              },
            ),
            const Divider(height: 24, color: Color(0xFFF1F5F9)),
            _buildLanguageOption(
              label: 'English',
              flagEmoji: '🇺🇸',
              isKhmer: false,
              isSelected: _selected == 'en',
              onTap: () {
                setState(() => _selected = 'en');
                AppLanguage.setLanguage('en');
                widget.onLanguageSelected('English');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String label,
    required String flagEmoji,
    required bool isKhmer,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  flagEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: isKhmer
                    ? GoogleFonts.battambang(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      )
                    : const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0FA958) : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0FA958)
                      : const Color(0xFFCBD5E1),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
