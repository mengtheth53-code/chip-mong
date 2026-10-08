import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'សួស្តី Meng Theth! ខ្ញុំជា AI ជំនួយការហិរញ្ញវត្ថុផ្ទាល់ខ្លួនរបស់អ្នកនៅធនាគារ ជីប ម៉ុង។ តើខ្ញុំអាចជួយអ្វីដល់អ្នកនៅថ្ងៃនេះ?',
      'time': '09:00 AM',
    },
    {
      'isUser': false,
      'text': '⚠️ ការដាស់តឿនឆ្លាតវៃ៖ ការចាយវាយរបស់អ្នកសម្រាប់ខែនេះបានឈានដល់ 85% នៃកញ្ចប់ថវិកាដែលបានកំណត់ហើយ (\$640.70 / \$750.00)។',
      'time': '09:01 AM',
      'isAlert': true,
    },
  ];

  final List<String> _quickPrompts = [
    'វិភាគការចំណាយខែនេះ',
    'តើខ្ញុំអាចសន្សំបានប៉ុន្មាន?',
    'កែសម្រួលកញ្ចប់ថវិកា',
    'គន្លឹះកាត់បន្ថយថ្លៃវិក្កយបត្រ',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'isUser': true,
        'text': text,
        'time': '09:05 AM',
      });
    });
    _messageController.clear();

    // Trigger AI smart response
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        String aiResponse = 'ផ្អែកលើទិន្នន័យប្រតិបត្តិការរបស់អ្នក AI បានវិភាគថាអ្នកចំណាយច្រើនបំផុតលើ «អាហារ និងភេសជ្ជៈ» (42%)។ ប្រសិនបើអ្នកកាត់បន្ថយការញ៉ាំអាហារក្រៅ 2 ដងក្នុងមួយសប្តាហ៍ អ្នកអាចសន្សំបានរហូតដល់ \$65/ខែ!';
        if (text.contains('សន្សំ')) {
          aiResponse = '💡 គន្លឹះសន្សំប្រាក់ AI៖ អ្នកអាចបើកមុខងារ «Daily Auto-Savings» ត្រឹម \$2/ថ្ងៃ។ មួយខែក្រោយអ្នកនឹងមានប្រាក់សន្សំ \$60 ដោយស្វ័យប្រវត្ត!';
        } else if (text.contains('ថវិកា')) {
          aiResponse = '📊 កញ្ចប់ថវិការបស់អ្នកសម្រាប់ខែនេះនៅសល់ \$109.30 ទៀតរហូតដល់ដំណាច់ខែ។ ខ្ញុំសូមណែនាំឱ្យកំណត់កម្រិតចាយប្រចាំថ្ងៃត្រឹម \$15/ថ្ងៃ។';
        }
        _messages.add({
          'isUser': false,
          'text': aiResponse,
          'time': '09:06 AM',
        });
      });
      _scrollToBottom();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0FA958),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 8),
                Text(
                  'AI ជំនួយការហិរញ្ញវត្ថុ',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'AI-Powered Banking Companion',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w400,
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
          labelStyle: GoogleFonts.battambang(fontWeight: FontWeight.w700, fontSize: 14),
          tabs: const [
            Tab(text: 'ជំនួយការសន្ទនា (Chat)'),
            Tab(text: 'វិភាគការចំណាយ (Analytics)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        // AI Feature Highlight Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.darkGreen.withValues(alpha: 0.95),
                const Color(0xFF0FA958),
              ],
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.psychology, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'វិភាគទម្លាប់ & ដាស់តឿនថវិកាស្វ័យប្រវត្ត',
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'AI តាមដានចំណូល-ចំណាយដើម្បីបង្កើនសុខភាពហិរញ្ញវត្ថុរបស់អ្នក',
                      style: GoogleFonts.battambang(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Messages List
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              final isUser = msg['isUser'] as bool;
              final isAlert = msg['isAlert'] == true;

              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.82,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFF0FA958)
                        : isAlert
                            ? const Color(0xFFFFFBEB)
                            : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    border: isAlert
                        ? Border.all(color: const Color(0xFFF59E0B), width: 1.2)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      if (isAlert)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Color(0xFFD97706), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'ការដាស់តឿនកញ្ចប់ថវិកា',
                              style: GoogleFonts.battambang(
                                color: const Color(0xFFD97706),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      if (isAlert) const SizedBox(height: 4),
                      Text(
                        msg['text'] as String,
                        style: GoogleFonts.battambang(
                          color: isUser ? Colors.white : const Color(0xFF1F2937),
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        msg['time'] as String,
                        style: GoogleFonts.roboto(
                          color: isUser ? Colors.white70 : Colors.black45,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Quick prompts carousel
        Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 6),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _quickPrompts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final prompt = _quickPrompts[index];
              return InkWell(
                onTap: () => _sendMessage(prompt),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF0FA958), width: 1),
                  ),
                  child: Text(
                    prompt,
                    style: GoogleFonts.battambang(
                      color: const Color(0xFF0FA958),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Input Field
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: GoogleFonts.battambang(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'សួរសំណួរទៅកាន់ AI...',
                      hintStyle: GoogleFonts.battambang(color: Colors.grey.shade500, fontSize: 13),
                      border: InputBorder.none,
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _sendMessage(_messageController.text),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0FA958),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Budget Warning Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF59E0B), width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.notifications_active, color: Color(0xFFD97706), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'ការដាស់តឿនកញ្ចប់ថវិកា (Budget Limit Alert)',
                      style: GoogleFonts.battambang(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'អ្នកបានចំណាយ \$640.70 នៃកញ្ចប់ថវិកាប្រចាំខែ \$750.00 (85%)។ នៅសល់ \$109.30 សម្រាប់រយៈពេល 24 ថ្ងៃទៀត។',
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    color: const Color(0xFF78350F),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: 0.85,
                    minHeight: 10,
                    backgroundColor: Color(0xFFFDE68A),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEF4444)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Auto-categorization Header
          Text(
            'បែងចែកការចំណាយស្វ័យប្រវត្ត (Auto-Categorization)',
            style: GoogleFonts.battambang(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'AI ធ្វើការបែងចែករាល់ប្រតិបត្តិការដោយស្វ័យប្រវត្តដោយមិនបាច់បញ្ចូលដោយដៃ',
            style: GoogleFonts.battambang(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),

          // Categories Breakdown Cards
          _buildCategoryItem(
            icon: Icons.restaurant_rounded,
            color: const Color(0xFFEF4444),
            categoryName: 'អាហារ & ភេសជ្ជៈ (Food & Dining)',
            amount: '\$340.50',
            percentage: '42%',
            progress: 0.42,
          ),
          _buildCategoryItem(
            icon: Icons.receipt_long_rounded,
            color: const Color(0xFF3B82F6),
            categoryName: 'វិក្កយបត្រ & ទឹកភ្លើង (Utilities)',
            amount: '\$125.00',
            percentage: '22%',
            progress: 0.22,
          ),
          _buildCategoryItem(
            icon: Icons.shopping_bag_rounded,
            color: const Color(0xFF8B5CF6),
            categoryName: 'ទិញទំនិញ & ផ្សារ (Shopping)',
            amount: '\$95.20',
            percentage: '18%',
            progress: 0.18,
          ),
          _buildCategoryItem(
            icon: Icons.local_gas_station_rounded,
            color: const Color(0xFFF59E0B),
            categoryName: 'ការធ្វើដំណើរ (Transportation)',
            amount: '\$48.00',
            percentage: '10%',
            progress: 0.10,
          ),
          _buildCategoryItem(
            icon: Icons.more_horiz_rounded,
            color: const Color(0xFF6B7280),
            categoryName: 'ផ្សេងៗ (Others)',
            amount: '\$32.00',
            percentage: '8%',
            progress: 0.08,
          ),
          const SizedBox(height: 18),

          // AI Personalized Saving Tips Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF0FA958).withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0FA958).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.lightbulb_rounded, color: Color(0xFF0FA958), size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'គន្លឹះសន្សំប្រាក់ AI (Personalized AI Advice)',
                      style: GoogleFonts.battambang(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF065F46),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '• ផ្អែកលើការទិញទំនិញចុងសប្តាហ៍នៅផ្សារទំនើប Chip Mong Supermarket អ្នកអាចសន្សំបាន \$45 បន្ថែមទៀត ប្រសិនបើអ្នកប្រើប័ណ្ណ Chip Mong Visa ដើម្បីទទួលបាន Cashback 1%។\n\n'
                  '• កាត់បន្ថយការចំណាយលើកាហ្វេ និងភេសជ្ជៈត្រឹម 1 កែវក្នុងមួយថ្ងៃ អាចជួយបង្កើនប្រាក់សន្សំបាន \$35/ខែ។',
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    color: const Color(0xFF374151),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required Color color,
    required String categoryName,
    required String amount,
    required String percentage,
    required double progress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: GoogleFonts.battambang(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      percentage,
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                amount,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
