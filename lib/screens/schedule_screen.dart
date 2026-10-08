import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  int _selectedFilter = 0; // 0: All, 1: Active, 2: Completed

  final List<Map<String, dynamic>> _schedules = [
    {
      'title': 'ទូទាត់ថ្លៃអគ្គិសនី EDC',
      'subtitle': 'រៀងរាល់ថ្ងៃទី ១៥ នៃខែ',
      'account': 'គណនីចម្បង ••• 3840',
      'amount': '35.00 USD',
      'status': 'ដំណើរការ',
      'isActive': true,
      'icon': Icons.bolt_rounded,
      'color': Color(0xFFEAB308),
    },
    {
      'title': 'ថ្លៃអ៊ីនធឺណិត OPENNET',
      'subtitle': 'រៀងរាល់ថ្ងៃទី ២០ នៃខែ',
      'account': 'គណនីចម្បង ••• 3840',
      'amount': '25.00 USD',
      'status': 'ដំណើរការ',
      'isActive': true,
      'icon': Icons.wifi_rounded,
      'color': Color(0xFF3B82F6),
    },
    {
      'title': 'ផ្ទេរប្រាក់សន្សំប្រចាំខែ',
      'subtitle': 'រៀងរាល់ថ្ងៃទី ០១ នៃខែ',
      'account': 'គណនីចម្បង ••• 3840',
      'amount': '100.00 USD',
      'status': 'ដំណើរការ',
      'isActive': true,
      'icon': Icons.savings_rounded,
      'color': _green,
    },
    {
      'title': 'ទូទាត់វិក្កយបត្រទឹកស្អាត PPWSA',
      'subtitle': 'កាលបរិច្ឆេទ៖ ៣០ មិថុនា ២០២៦',
      'account': 'គណនីចម្បង ••• 3840',
      'amount': '12.50 USD',
      'status': 'បានបញ្ចប់',
      'isActive': false,
      'icon': Icons.water_drop_rounded,
      'color': Color(0xFF06B6D4),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = _schedules.where((item) {
      if (_selectedFilter == 1) return item['isActive'] == true;
      if (_selectedFilter == 2) return item['isActive'] == false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: _bgGray,
      appBar: AppBar(
        backgroundColor: _darkGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'កាលវិភាគប្រតិបត្តិការ',
          style: GoogleFonts.battambang(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            color: _darkGreen,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              children: [
                _buildFilterPill('ទាំងអស់', 0),
                const SizedBox(width: 8),
                _buildFilterPill('កំពុងដំណើរការ', 1),
                const SizedBox(width: 8),
                _buildFilterPill('បានបញ្ចប់', 2),
              ],
            ),
          ),

          // Schedules List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final s = filteredList[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: (s['color'] as Color).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          s['icon'] as IconData,
                          color: s['color'] as Color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s['title'] as String,
                              style: GoogleFonts.battambang(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s['subtitle'] as String,
                              style: GoogleFonts.battambang(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            s['amount'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (s['isActive'] as bool)
                                  ? const Color(0xFFDCFCE7)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              s['status'] as String,
                              style: GoogleFonts.battambang(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: (s['isActive'] as bool)
                                    ? _green
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'បង្កើតកាលវិភាគថ្មីត្រូវបានជ្រើសរើស',
                    style: GoogleFonts.battambang(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              'បង្កើតកាលវិភាគថ្មី',
              style: GoogleFonts.battambang(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPill(String title, int index) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: GoogleFonts.battambang(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? _darkGreen : Colors.white,
          ),
        ),
      ),
    );
  }
}
