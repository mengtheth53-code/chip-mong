import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class _ServiceItem {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  const _ServiceItem({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });
}


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  static const _green = Color(0xFF0FA958);
  static const _bgGray = Color(0xFFF2F2F7);

  late final TabController _tabController;
  final _searchController = TextEditingController();

  final List<_ServiceItem> _services = const [
    _ServiceItem(
      icon: Icons.phone_android_rounded,
      iconBg: Color(0xFF0FA958),
      title: 'បញ្ចូលលុយទូរស័ព្ទ',
      subtitle: 'ប្រព័ន្ធទូរស័ព្ទ Smart, Cellcard, Metfone',
    ),
    _ServiceItem(
      icon: Icons.lightbulb_outline_rounded,
      iconBg: Color(0xFF4CAF50),
      title: 'ទឹក ភ្លើង និងសំរាម',
      subtitle: 'ទូទាត់វិក្កយបត្រទឹក ភ្លើង និងសំរាម',
    ),
    _ServiceItem(
      icon: Icons.apartment_rounded,
      iconBg: Color(0xFFB8860B),
      title: 'សេវាសាធារណៈ',
      subtitle: 'បង់ពន្ធ ឬសេវាសាធារណៈរបស់អ្នក',
    ),
    _ServiceItem(
      icon: Icons.autorenew_rounded,
      iconBg: Color(0xFF0FA958),
      title: 'ពាណិជ្ជកម្មរបស់ក្រុមហ៊ុន ជីប ម៉ុង',
      subtitle: 'ទូទាត់វិក្កយបត្រពាណិជ្ជកម្មក្រុមហ៊ុន ជីប ម៉ុង...',
    ),
    _ServiceItem(
      icon: Icons.savings_rounded,
      iconBg: Color(0xFFE91E8C),
      title: 'សហប្រតិបត្តិ និងការទូទាត់',
      subtitle: 'ទូទាត់សហប្រតិបត្តិ និងសេវា...',
    ),
  ];

  List<_ServiceItem> get _filtered {
    final q = _searchController.text.toLowerCase();
    if (q.isEmpty) return _services;
    return _services
        .where(
          (e) =>
              e.title.toLowerCase().contains(q) ||
              e.subtitle.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      body: Column(
        children: [
          
          _PaymentHeader(green: _green, tabController: _tabController),

          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                 
                  _SearchBar(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 12),

               
                  ..._filtered.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ServiceTile(item: item),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentHeader extends StatelessWidget {
  final Color green;
  final TabController tabController;
  const _PaymentHeader({required this.green, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: green,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  Text(
                    'ទូទាត់',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(4),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: green,
                  unselectedLabelColor: Colors.white,
                  labelStyle: GoogleFonts.battambang(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),

                  tabs:  [
                    Tab(text: 'ទូទាត់'),
                    Tab(text: 'កាលវិភាគ'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

           
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon box
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.workspace_premium_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Text block
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'បន្ថែមគំរូទូទាត់ថ្មី',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                         Text(
                          'បង្កើតគំរូថ្មីរបស់អ្នកសម្រាប់ការផ្ទេរ\nប្រតិបត្តិការរាប់រហាស និងងាយស្រួល',
                          style: GoogleFonts.battambang(
                            color: Color(0xFFF1FFF7),
                            fontSize: 17,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'បង្កើតគំរូទូទាត់ថ្មី',
                              style: GoogleFonts.battambang(
                                color: Colors.white,
                                fontSize: 17,
                                
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              height: 22,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.battambang(
          fontSize: 15,
          color: const Color(0xFF1A1A1A),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'ស្វែងរក',
          hintStyle: GoogleFonts.battambang(
            color:  Color(0xFFB0B0B0),
            fontSize: 17,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFAAAAAA),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final _ServiceItem item;
  const _ServiceTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: item.iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.battambang(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color:  Color(0xFF202020),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.battambang(
                        fontSize: 17,
                        color:  Color(0xFF7A7A7A),
                        height: 1.35,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Color(0xFFCCCCCC),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
