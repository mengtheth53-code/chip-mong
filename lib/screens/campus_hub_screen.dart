import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CampusHubScreen extends StatefulWidget {
  const CampusHubScreen({super.key});

  @override
  State<CampusHubScreen> createState() => _CampusHubScreenState();
}

class _CampusHubScreenState extends State<CampusHubScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedUniversity = 'សាកលវិទ្យាល័យជាតិគ្រប់គ្រង (NUM)';

  final List<String> _universities = [
    'សាកលវិទ្យាល័យជាតិគ្រប់គ្រង (NUM)',
    'សាកលវិទ្យាល័យភូមិន្ទភ្នំពេញ (RUPP)',
    'វិទ្យាស្ថានបច្ចេកវិទ្យាកម្ពុជា (ITC)',
    'សាកលវិទ្យាល័យ ន័រតុន (Norton)',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showTuitionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'បង់ថ្លៃសិក្សា (Tuition Payment)',
                  style: GoogleFonts.battambang(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _buildInvoiceRow('សាកលវិទ្យាល័យ', 'NUM (National University of Management)'),
                  const SizedBox(height: 6),
                  _buildInvoiceRow('អត្តលេខនិស្សិត', 'STU-2026-9812'),
                  const SizedBox(height: 6),
                  _buildInvoiceRow('ឆមាស (Semester)', 'Year 4, Semester 1'),
                  const Divider(height: 16),
                  _buildInvoiceRow('ទឹកប្រាក់ត្រូវបង់', '\$350.00', isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0FA958),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF0FA958),
                      content: Text(
                        'ការបង់ថ្លៃសិក្សា \$350.00 ទទួលបានជោគជ័យ!',
                        style: GoogleFonts.battambang(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'បង់ប្រាក់ឥឡូវនេះ (\$350.00)',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.battambang(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              fontSize: 13.5,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? const Color(0xFF0FA958) : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.school_rounded, color: Color(0xFF6EE7B7), size: 20),
                const SizedBox(width: 8),
                Text(
                  'Campus Hub',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'University Ecosystem Integration',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF0FA958),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: GoogleFonts.battambang(fontWeight: FontWeight.w700, fontSize: 13),
          tabs: const [
            Tab(text: 'កាតនិស្សិត (ID Card)'),
            Tab(text: 'សេវាកម្ម (Services)'),
            Tab(text: 'អត្ថប្រយោជន៍ (Perks)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildIdCardTab(),
          _buildServicesTab(),
          _buildPerksTab(),
        ],
      ),
    );
  }

  Widget _buildIdCardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // University Picker Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedUniversity,
                items: _universities.map((uni) {
                  return DropdownMenuItem(
                    value: uni,
                    child: Text(uni, style: GoogleFonts.battambang(fontSize: 13.5)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedUniversity = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Digital Student ID Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E3A8A).withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Logo + Bank Partner
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.school, color: Colors.white, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          'DIGITAL STUDENT ID',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'CHIP MONG BANK',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Student Details Row
                Row(
                  children: [
                    // Student Photo
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Colors.white, size: 40),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MENG THETH',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ID: STU-2026-9812',
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Major: Information Technology (IT)',
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Divider(color: Colors.white30, height: 1),
                const SizedBox(height: 14),

                // Card Footer with QR code & status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ស្ថានភាព៖ បានផ្ទៀងផ្ទាត់ (Verified)',
                          style: GoogleFonts.battambang(
                            color: const Color(0xFF6EE7B7),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'សុពលភាព៖ 31 ធ្នូ 2027',
                          style: GoogleFonts.battambang(
                            color: Colors.white60,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.qr_code_2, color: Colors.black87, size: 36),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Quick Action Cards
          Row(
            children: [
              Expanded(
                child: _buildActionTile(
                  icon: Icons.payments_rounded,
                  color: const Color(0xFF0FA958),
                  title: 'បង់ថ្លៃសិក្សា',
                  subtitle: 'Tuition Fee',
                  onTap: _showTuitionSheet,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionTile(
                  icon: Icons.qr_code_scanner_rounded,
                  color: const Color(0xFF3B82F6),
                  title: 'ស្កេនអាហារដ្ឋាន',
                  subtitle: 'Canteen KHQR',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('បើកប្រព័ន្ធស្កេន KHQR អាហារដ្ឋាននិស្សិត...', style: GoogleFonts.battambang())),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceCard(
          icon: Icons.account_balance,
          color: const Color(0xFF0FA958),
          title: 'បង់ថ្លៃសិក្សាប្រចាំឆមាស',
          desc: 'បង់ថ្លៃសិក្សាដោយផ្ទាល់ទៅកាន់សាកលវិទ្យាល័យដៃគូ គ្មានថ្លៃសេវា',
          buttonText: 'បង់ប្រាក់',
          onTap: _showTuitionSheet,
        ),
        const SizedBox(height: 12),
        _buildServiceCard(
          icon: Icons.restaurant_menu,
          color: const Color(0xFFF59E0B),
          title: 'អាហារដ្ឋាន & បណ្ណាគារនិស្សិត',
          desc: 'ស្កេនទូទាត់ KHQR នៅគ្រប់តូបអាហារ និងបណ្ណាគារក្នុងបរិវេណសាលា',
          buttonText: 'ស្កេនទូទាត់',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildServiceCard(
          icon: Icons.workspace_premium,
          color: const Color(0xFF8B5CF6),
          title: 'អាហារូបករណ៍ & ឥណទាននិស្សិត',
          desc: 'ស្នើសុំឥណទានសិក្សាការប្រាក់អនុគ្រោះ ឬពិនិត្យអាហារូបករណ៍ ជីប ម៉ុង',
          buttonText: 'ស្វែងយល់បន្ថែម',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPerksTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFF59E0B)),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFD97706), size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'អត្ថប្រយោជន៍ផ្តាច់មុខសម្រាប់និស្សិតដែលភ្ជាប់ Digital Student ID ជាមួយ Chip Mong Bank',
                  style: GoogleFonts.battambang(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF92400E),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        _buildPerkTile(
          logoText: 'SUPERMARKET',
          title: 'Chip Mong Supermarket',
          discount: 'បញ្ចុះតម្លៃ 15%',
          desc: 'រាល់ថ្ងៃពុធសម្រាប់រាល់ទំនិញស្រស់ និងសម្ភារសិក្សា',
          color: const Color(0xFF0FA958),
        ),
        const SizedBox(height: 10),
        _buildPerkTile(
          logoText: 'CINEMA',
          title: 'Legend Cinema',
          discount: 'សំបុត្រកុនត្រឹម \$3.00',
          desc: 'រាល់ថ្ងៃច័ន្ទ ដល់ ថ្ងៃព្រហស្បតិ៍ គ្រប់សាខា',
          color: const Color(0xFFEF4444),
        ),
        const SizedBox(height: 10),
        _buildPerkTile(
          logoText: 'MEGA MALL',
          title: 'Chip Mong Mega Mall (271)',
          discount: 'ប័ណ្ណបញ្ចុះតម្លៃ 20%',
          desc: 'សម្រាប់ភោជនីយដ្ឋាន និងហាងកាហ្វេក្នុងផ្សារទំនើប',
          color: const Color(0xFF3B82F6),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: GoogleFonts.battambang(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 2),
            Text(subtitle, style: GoogleFonts.roboto(color: Colors.grey.shade600, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.battambang(fontSize: 14.5, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(desc, style: GoogleFonts.battambang(fontSize: 12, color: Colors.grey.shade600, height: 1.35)),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      buttonText,
                      style: GoogleFonts.battambang(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerkTile({
    required String logoText,
    required String title,
    required String discount,
    required String desc,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                logoText.substring(0, 1),
                style: GoogleFonts.roboto(color: color, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(discount, style: GoogleFonts.battambang(fontSize: 12.5, fontWeight: FontWeight.w700, color: color)),
                Text(desc, style: GoogleFonts.battambang(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
