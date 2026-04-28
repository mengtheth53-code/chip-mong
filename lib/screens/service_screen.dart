import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _QuickServiceItem {
  final String title;
  const _QuickServiceItem(this.title);
}

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  static const _green = Color(0xFF0FA958);
  static const _bgGray = Color(0xFFF5F5F5);

  static const _quickItems = <_QuickServiceItem>[
    _QuickServiceItem('ផ្ទេរប្រាក់ក្រៅប្រទេសតាមរយៈប្រព័ន្ធ SWIFT'),
    _QuickServiceItem('អគ្គីសនីកម្ពុជា'),
    _QuickServiceItem('អេហ្វដាប់ប៊ែលយូឌី ខេមបូឌា'),
    _QuickServiceItem('ផ្ទេរប្រាក់ទៅគណនីខ្លួនឯង'),
    _QuickServiceItem('ផ្ទេរប្រាក់ទៅគណនី ជីប​ ម៉ុង​ ណាមួយ'),
    _QuickServiceItem(
      'សហគ្រាសគ្រប់គ្រងសំរាម សំណល់រឹង និងទីប្រជុំជន រាជធានីភ្នំពេញ ( ស.ស.ភ )',
    ),
    _QuickServiceItem('បញ្ចូលលុយទូរស័ព្ទ'),
    _QuickServiceItem('ក្រសួងសាធារណការ និង ដឹកជញ្ជូន'),
    _QuickServiceItem('រដ្ឋាករទឹកស្វយ័តក្រុងភ្នំពេញ'),
    _QuickServiceItem('ក្រសួងការងារ និងបណ្តុះបណ្តាលវិជ្ជាជីវៈ'),
    _QuickServiceItem('ក្រុមហ៊ុន ផ្លូល្បឿនលឿនភ្នំពេញ - ក្រុងព្រះសីហនុ'),
    _QuickServiceItem('lbl_bs_transfer_bank_account_retail'),
    _QuickServiceItem('ផ្ទេរប្រាក់ទៅគណនីធនាគារ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + close button — NO background, just text on gray
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'សេវាកម្មហ័ស',
                      style: GoogleFonts.battambang(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black54,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

             
              Text(
                'អ្នកអាចបន្ថែមសេវាកម្មចំនួន 5 ដែលអ្នកធ្វើប្រតិបត្តិការជាញឹកញាប់',
                style: GoogleFonts.battambang(
                  fontSize: 13,
                  color: Color.fromARGB(255, 100, 99, 99),
                  height: 1.55,
                ),
              ),

              const SizedBox(height: 24),

              
              Text(
                'សេវាកម្ម',
                style: GoogleFonts.notoSansKhmer(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              
              _EmptyStateCard(),
              const SizedBox(height: 28),

              
              Text(
                'សេវាកម្មផ្សេងៗ',
                style: GoogleFonts.battambang(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Grouped tiles card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                 
                ),
                child: Column(
                  children: List.generate(_quickItems.length, (i) {
                    return _QuickTile(
                      item: _quickItems[i],
                      green: _green,
                      showDivider: i != _quickItems.length - 1,
                      isFirst: i == 0,
                      isLast: i == _quickItems.length - 1,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
       
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.north_east_rounded,
              color: Colors.black54,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'មិនទាន់មានការកំណត់សេវាកម្មនៅឡើយទេ',
                  style: GoogleFonts.battambang(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'ចុចប៊ូតុង "+" ដើម្បីធ្វើការដាក់បញ្ចូលសេវាកម្មដែលអ្នកធ្វើប្រតិបត្តិការ ញឹកញាប់ សម្រាប់ចូលដំណើរកាសេវាកម្មរហ័ស',
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    color:  Color.fromARGB(255, 100, 99, 99),
                    height: 1.55,
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

class _QuickTile extends StatelessWidget {
  final _QuickServiceItem item;
  final Color green;
  final bool showDivider;
  final bool isFirst;
  final bool isLast;

  const _QuickTile({
    required this.item,
    required this.green,
    required this.showDivider,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(16) : Radius.zero,
            bottom: isLast ? const Radius.circular(16) : Radius.zero,
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            splashColor: green,
            highlightColor: green,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item.title,
                      style: GoogleFonts.battambang(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            indent: 64,
            color: Color(0xFFF0F0F0),
          ),
      ],
    );
  }
}
