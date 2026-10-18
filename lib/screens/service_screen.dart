import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_language.dart';

void showQuickServicesSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const ServiceScreen(),
  );
}

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  static const Color _green = Color(0xFF0FA958);
  static const Color _red = Color(0xFFE52329);

  // Active / selected quick services (max 5)
  final List<String> _selectedServices = [
    'អគ្គិសនីកម្ពុជា',
    'ផ្ទេរប្រាក់ក្រៅប្រទេសតាមរយៈប្រព័ន្ធ SWIFT',
    'ក្រុមហ៊ុន ជីប ម៉ុង លែន',
  ];

  // Available services
  final List<String> _availableServices = [
    'អេហ្វដាប់ប៊ែលយូឌី ខេមបូឌា',
    'ផ្ទេរប្រាក់ទៅគណនីខ្លួនឯង',
    'សហគ្រាសគ្រប់គ្រងសំរាម សំណល់រឹង ទីប្រជុំជន រាជធានីភ្នំពេញ ( ស.ស.ភ )',
    'ការទូទាត់សងប័ណ្ណឥណទាន',
    'បញ្ចូលលុយទូរសព្ទ',
    'រដ្ឋាករទឹកស្វយ័តក្រុងភ្នំពេញ',
    'ក្រសួងសាធារណការ និងដឹកជញ្ជូន',
  ];

  void _addService(String service) {
    if (_selectedServices.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('អ្នកអាចបន្ថែមសេវាកម្មបានត្រឹមតែ ៥ ប៉ុណ្ណោះ'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      _availableServices.remove(service);
      _selectedServices.add(service);
    });
  }

  void _removeService(String service) {
    setState(() {
      _selectedServices.remove(service);
      _availableServices.insert(0, service);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F4F2),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Title and Close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguage.tr(
                        km: 'សេវាកម្មរហ័ស',
                        en: 'Quick Services',
                      ),
                      style: AppLanguage.isKhmer
                          ? GoogleFonts.battambang(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            )
                          : GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLanguage.tr(
                        km: 'អ្នកអាចបន្ថែមសេវាកម្មចំនួន 5 ដែលអ្នកធ្វើប្រតិបត្តិការជាញឹកញាប់',
                        en: 'You can add up to 5 frequently used services for quick access',
                      ),
                      style: AppLanguage.isKhmer
                          ? GoogleFonts.battambang(
                              fontSize: 13,
                              color: const Color(0xFF64748B),
                              height: 1.4,
                            )
                          : GoogleFonts.roboto(
                              fontSize: 12.5,
                              color: const Color(0xFF64748B),
                              height: 1.35,
                            ),
                    ),
                  ],
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
          const SizedBox(height: 20),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: សេវាកម្ម
                  Text(
                    AppLanguage.tr(
                      km: 'សេវាកម្ម',
                      en: 'Selected Services',
                    ),
                    style: AppLanguage.isKhmer
                        ? GoogleFonts.battambang(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          )
                        : GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                  ),
                  const SizedBox(height: 10),
                  _buildSelectedServicesSection(),
                  const SizedBox(height: 24),

                  // Section 2: សេវាកម្មផ្សេងៗ
                  Text(
                    AppLanguage.tr(
                      km: 'សេវាកម្មផ្សេងៗ',
                      en: 'Other Services',
                    ),
                    style: AppLanguage.isKhmer
                        ? GoogleFonts.battambang(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          )
                        : GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                  ),
                  const SizedBox(height: 10),
                  _buildAvailableServicesSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedServicesSection() {
    if (_selectedServices.isEmpty) {
      // Empty state from Screenshot 1
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.open_in_new_rounded,
                color: Color(0xFF64748B),
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLanguage.tr(
                      km: 'មិនទាន់មានការកំណត់សេវាកម្ម\nនៅឡើយទេ',
                      en: 'No quick services configured yet',
                    ),
                    style: AppLanguage.isKhmer
                        ? GoogleFonts.battambang(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                            height: 1.35,
                          )
                        : GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                            height: 1.25,
                          ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLanguage.tr(
                      km: 'ចុចប៊ូតុង "+" ដើម្បីធ្វើការដាក់បញ្ចូលសេវាកម្មដែលអ្នកធ្វើប្រតិបត្តិការ ញឹកញាប់ សម្រាប់ចូលដំណើរការសេវាកម្មរហ័ស',
                      en: 'Tap the "+" button below to add your frequently used services for faster access',
                    ),
                    style: AppLanguage.isKhmer
                        ? GoogleFonts.battambang(
                            fontSize: 13,
                            color: const Color(0xFF64748B),
                            height: 1.45,
                          )
                        : GoogleFonts.roboto(
                            fontSize: 12.5,
                            color: const Color(0xFF64748B),
                            height: 1.35,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Filled state from Screenshot 2
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _selectedServices.length,
        onReorderItem: (oldIndex, newIndex) {
          setState(() {
            final item = _selectedServices.removeAt(oldIndex);
            _selectedServices.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final service = _selectedServices[index];
          final isLast = index == _selectedServices.length - 1;
          return Column(
            key: ValueKey(service),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _removeService(service),
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: _red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        service,
                        style: GoogleFonts.battambang(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                          height: 1.35,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.menu_rounded,
                      color: Color(0xFFCBD5E1),
                      size: 22,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                const Padding(
                  padding: EdgeInsets.only(left: 54, right: 16),
                  child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAvailableServicesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _availableServices.length,
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(left: 54, right: 16),
          child: Divider(height: 1, color: Color(0xFFF1F5F9)),
        ),
        itemBuilder: (context, index) {
          final service = _availableServices[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _addService(service),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: _green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    service,
                    style: GoogleFonts.battambang(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
