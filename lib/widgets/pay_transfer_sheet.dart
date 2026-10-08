import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/chip_mong_transfer_screen.dart';
import '../screens/edc_payment_screen.dart';
import '../screens/myself_transfer_screen.dart';
import '../screens/phone_topup_screen.dart';

void showPayAndTransferSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const PayAndTransferSheet(),
  );
}

class PayAndTransferSheet extends StatelessWidget {
  const PayAndTransferSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ទូទាត់ និងផ្ទេរប្រាក់',
                  style: GoogleFonts.battambang(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black87,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Top 2 Big Cards
            Row(
              children: [
                Expanded(
                  child: _buildBigActionCard(
                    icon: Icons.person_add_alt_1_rounded,
                    label: 'ផ្ទេរប្រាក់ទៅគណនី\nខ្លួនឯង',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MySelfTransferScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBigActionCard(
                    icon: Icons.swap_horiz_rounded,
                    label: 'ផ្ទេរប្រាក់ទៅគណនី ជីប\nម៉ុង ណាមួយ',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ChipMongTransferScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grid Row 1 (4 columns)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSmallActionItem(
                  badge: _buildCircularBadge(
                    color: const Color(0xFFE52329),
                    child: const Icon(
                      Icons.stars_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  label: 'ផ្ទេរប្រាក់ទៅ\nគណនីបាគង',
                  onTap: () {},
                ),
                _buildSmallActionItem(
                  badge: _buildCircularBadge(
                    color: const Color(0xFF0C8A4A),
                    child: const Icon(
                      Icons.account_balance_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  label: 'ផ្ទេរប្រាក់ទៅ\nគណនីធនាគារ',
                  onTap: () {},
                ),
                _buildSmallActionItem(
                  badge: _buildCircularBadge(
                    color: const Color(0xFF22A3C4),
                    child: const Icon(
                      Icons.upload_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  label: 'ដកប្រាក់ដោយ\nគ្មានប័ណ្ណ',
                  onTap: () {},
                ),
                _buildSmallActionItem(
                  badge: _buildCircularBadge(
                    color: const Color(0xFF1E88E5),
                    child: const Icon(
                      Icons.language_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  label: 'ផ្ទេរប្រាក់\nក្រៅប្រទេស...',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grid Row 2 (4 columns)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 32) / 4,
                  child: _buildSmallActionItem(
                    badge: _buildCircularBadge(
                      color: const Color(0xFF1EA75B),
                      child: const Icon(
                        Icons.phone_android_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    label: 'បញ្ចូលលុយ\nទូរសព្ទ',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PhoneTopupScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 32) / 4,
                  child: _buildSmallActionItem(
                    badge: Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B4E9B),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue.shade100,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'EDC',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    label: 'អគ្គិសនីកម្ពុជា',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EdcPaymentScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 32) / 4,
                  child: _buildSmallActionItem(
                    badge: Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9A825),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.yellow.shade100,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.directions_car_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    label: 'ក្រុមហ៊ុន ផ្លូវ\nល្បឿនលឿន...',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF0FA958),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.battambang(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularBadge({
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(child: child),
    );
  }

  Widget _buildSmallActionItem({
    required Widget badge,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          badge,
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.battambang(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
