import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChequeBookScreen extends StatefulWidget {
  const ChequeBookScreen({super.key});

  @override
  State<ChequeBookScreen> createState() => _ChequeBookScreenState();
}

class _ChequeBookScreenState extends State<ChequeBookScreen>
    with SingleTickerProviderStateMixin {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  late final TabController _tabController;
  int _selectedLeaves = 25;
  String _selectedBranch = 'សាខា Chip Mong Tower (មហាវិថីសហព័ន្ធរុស្ស៊ី)';
  final TextEditingController _chequeNumberController = TextEditingController();

  final List<String> _branches = [
    'សាខា Chip Mong Tower (មហាវិថីសហព័ន្ធរុស្ស៊ី)',
    'សាខា ម៉ៅសេទុង (មហាវិថីម៉ៅសេទុង)',
    'សាខា ព្រះនរោត្តម (មហាវិថីព្រះនរោត្តម)',
    'សាខា សែនសុខ (ផ្លូវ ១០០៣ សែនសុខ)',
    'សាខា បឹងកក់ (ផ្លូវ R8 បឹងកក់)',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chequeNumberController.dispose();
    super.dispose();
  }

  void _onRequestChequeBook() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: _green, size: 28),
            const SizedBox(width: 8),
            Text(
              'សំណើត្រូវបានបញ្ជូន',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'ការស្នើសុំសៀវភៅមូលប្បទានប័ត្រចំនួន $_selectedLeaves សន្លឹក របស់អ្នកត្រូវបានទទួលជោគជ័យ។ ធនាគារនឹងជូនដំណឹងនៅពេលសៀវភៅរួចរាល់សម្រាប់ទៅយកនៅ $_selectedBranch។',
          style: GoogleFonts.battambang(fontSize: 13.5, height: 1.5),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'យល់ព្រម',
              style: GoogleFonts.battambang(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'សៀវភៅមូលប្បទានប័ត្រ',
          style: GoogleFonts.battambang(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.battambang(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.battambang(fontSize: 14),
          tabs: const [
            Tab(text: 'ស្នើសុំសៀវភៅថ្មី'),
            Tab(text: 'ពិនិត្យស្ថានភាព'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestTab(),
          _buildInquiryTab(),
        ],
      ),
    );
  }

  Widget _buildRequestTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account selector card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'គណនីភ្ជាប់',
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: _green,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CURRENT ACCOUNT ••• 5272',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.5,
                            ),
                          ),
                          Text(
                            'សមតុល្យ: \$ 2,540.50',
                            style: GoogleFonts.battambang(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Number of leaves
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ចំនួនសន្លឹកមូលប្បទានប័ត្រ',
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildLeavesChoice(25, '\$ 5.00'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildLeavesChoice(50, '\$ 10.00'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Branch Pickup
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'សាខាសម្រាប់ទៅទទួល',
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedBranch,
                    items: _branches.map((b) {
                      return DropdownMenuItem(
                        value: b,
                        child: Text(
                          b,
                          style: GoogleFonts.battambang(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedBranch = val);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _onRequestChequeBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'ដាក់ស្នើសុំឥឡូវនេះ',
                style: GoogleFonts.battambang(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeavesChoice(int leaves, String price) {
    final isSelected = _selectedLeaves == leaves;
    return GestureDetector(
      onTap: () => setState(() => _selectedLeaves = leaves),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? _green : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              '$leaves សន្លឹក',
              style: GoogleFonts.battambang(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isSelected ? _green : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'តម្លៃ $price',
              style: GoogleFonts.battambang(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInquiryTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ស្វែងរកមូលប្បទានប័ត្រ',
                  style: GoogleFonts.battambang(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _chequeNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'បញ្ចូលលេខមូលប្បទានប័ត្រ (៦ ខ្ទង់)',
                    hintStyle: GoogleFonts.battambang(
                      fontSize: 13,
                      color: Colors.black38,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: _green),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 12),
                Text(
                  'មិនមានទិន្នន័យមូលប្បទានប័ត្រទេ',
                  style: GoogleFonts.battambang(
                    fontSize: 15,
                    color: Colors.black54,
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
