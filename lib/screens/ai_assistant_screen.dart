import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/app_language.dart';

class AiAssistantScreen extends StatefulWidget {
  final int initialIndex;
  const AiAssistantScreen({super.key, this.initialIndex = 0});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Smart Credit State
  int _selectedMode = 0; // 0 for Nano-Loans, 1 for BNPL
  double _loanAmount = 300;
  int _selectedTenure = 6; // months
  final String _selectedBnplMerchant = 'Chip Mong Supermarket (ផ្សារទំនើប ជីប ម៉ុង)';
  double _bnplAmount = 120.00;
  int _bnplMonths = 3; // 3 months 0% interest

  double get _monthlyRepayment {
    if (_selectedMode == 0) {
      const monthlyRate = 0.011;
      final totalInterest = _loanAmount * monthlyRate * _selectedTenure;
      return (_loanAmount + totalInterest) / _selectedTenure;
    } else {
      return _bnplAmount / _bnplMonths;
    }
  }

  // AI Chat Messages
  late List<Map<String, dynamic>> _messages;

  final List<String> _quickPromptsKm = [
    'វិភាគការចំណាយខែនេះ',
    'តើខ្ញុំអាចសន្សំបានប៉ុន្មាន?',
    'កែសម្រួលកញ្ចប់ថវិកា',
    'គន្លឹះកាត់បន្ថយថ្លៃវិក្កយបត្រ',
  ];

  final List<String> _quickPromptsEn = [
    'Analyze my expenses',
    'How much can I save?',
    'Adjust my budget',
    'Tips to lower bills',
  ];

  bool get _isKhmer => AppLanguage.isKhmer;

  @override
  void initState() {
    super.initState();
    final clampedIndex = widget.initialIndex.clamp(0, 2);
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: clampedIndex,
    );

    _messages = [
      {
        'isUser': false,
        'text': _isKhmer
            ? 'សួស្តី Meng Theth! ខ្ញុំជា AI ជំនួយការហិរញ្ញវត្ថុ & ឥណទានឆ្លាតវៃរបស់អ្នកនៅធនាគារ ជីប ម៉ុង។ តើខ្ញុំអាចជួយអ្វីដល់អ្នកនៅថ្ងៃនេះ?'
            : 'Hello Meng Theth! I am your AI Financial Assistant & Smart Credit companion at Chip Mong Bank. How may I help you today?',
        'time': '09:00 AM',
      },
      {
        'isUser': false,
        'text': _isKhmer
            ? '⚠️ ការដាស់តឿនឆ្លាតវៃ៖ ការចាយវាយរបស់អ្នកសម្រាប់ខែនេះបានឈានដល់ 85% នៃកញ្ចប់ថវិកាដែលបានកំណត់ហើយ (\$640.70 / \$750.00)។'
            : '⚠️ Smart Alert: Your spending this month has reached 85% of your set monthly budget (\$640.70 / \$750.00).',
        'time': '09:01 AM',
        'isAlert': true,
      },
    ];
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

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        String aiResponse = _isKhmer
            ? 'ផ្អែកលើទិន្នន័យប្រតិបត្តិការរបស់អ្នក AI បានវិភាគថាអ្នកចំណាយច្រើនបំផុតលើ «អាហារ និងភេសជ្ជៈ» (42%)។ ប្រសិនបើអ្នកកាត់បន្ថយការញ៉ាំអាហារក្រៅ 2 ដងក្នុងមួយសប្តាហ៍ អ្នកអាចសន្សំបានរហូតដល់ \$65/ខែ!'
            : 'Based on your transaction data, AI analyzed that your highest expense is "Dining & Food" (42%). Reducing outside dining twice a week can save up to \$65/month!';

        if (text.contains('សន្សំ') || text.toLowerCase().contains('save')) {
          aiResponse = _isKhmer
              ? '💡 គន្លឹះសន្សំប្រាក់ AI៖ អ្នកអាចបើកមុខងារ «Daily Auto-Savings» ត្រឹម \$2/ថ្ងៃ។ មួយខែក្រោយអ្នកនឹងមានប្រាក់សន្សំ \$60 ដោយស្វ័យប្រវត្ត!'
              : '💡 AI Saving Tip: Enable "Daily Auto-Savings" with just \$2/day. You will automatically save \$60 every month!';
        } else if (text.contains('ថវិកា') || text.toLowerCase().contains('budget')) {
          aiResponse = _isKhmer
              ? '📊 កញ្ចប់ថវិការបស់អ្នកសម្រាប់ខែនេះនៅសល់ \$109.30 ទៀតរហូតដល់ដំណាច់ខែ។ ខ្ញុំសូមណែនាំឱ្យកំណត់កម្រិតចាយប្រចាំថ្ងៃត្រឹម \$15/ថ្ងៃ។'
              : '📊 Your remaining budget this month is \$109.30. I recommend capping your daily spending at \$15/day.';
        } else if (text.contains('កម្ចី') || text.contains('credit') || text.toLowerCase().contains('loan')) {
          aiResponse = _isKhmer
              ? '⚡ ពិន្ទុ Alternative Credit របស់អ្នកគឺ 785/850 (គុណភាពខ្ពស់)! អ្នកមានសិទ្ធិទទួលបាន Digital Nano-Loan \$300 ភ្លាមៗក្នុងផ្ទាំង «ឥណទានឆ្លាតវៃ»។'
              : '⚡ Your Alternative Credit score is 785/850 (Eligible)! You qualify for an instant \$300 Digital Nano-Loan in the "Smart Credit" tab.';
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

  void _submitCreditApplication() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFDFF5EA),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: Color(0xFF0FA958), size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              _selectedMode == 0
                  ? (_isKhmer ? 'សំណើកម្ចីខ្នាតតូចត្រូវបានបញ្ជូន!' : 'Nano-Loan Request Submitted!')
                  : (_isKhmer ? 'សំណើបង់រំលស់ BNPL 0% ត្រូវបានអនុម័ត!' : 'BNPL 0% Installment Approved!'),
              textAlign: TextAlign.center,
              style: GoogleFonts.battambang(
                fontSize: 17.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedMode == 0
                  ? (_isKhmer
                      ? 'ពិន្ទុ Alternative Credit របស់អ្នកបានឆ្លងកាត់ការវាយតម្លៃបឋម (Pre-Approved \$${_loanAmount.toInt()}) ដោយមិនបាច់មានទ្រព្យបញ្ចាំ។ ទិន្នន័យត្រូវបានបញ្ជូនទៅកាន់ប្រព័ន្ធឥណទានស្របតាមបទប្បញ្ញត្តិ NBC។'
                      : 'Your Alternative Credit score has pre-approved \$${_loanAmount.toInt()} without collateral. Application submitted under NBC responsible lending guidelines.')
                  : (_isKhmer
                      ? 'ការបង់រំលស់ BNPL \$${_bnplAmount.toStringAsFixed(0)} ជាមួយការប្រាក់ 0% ត្រូវបានភ្ជាប់ជាមួយ $_selectedBnplMerchant ដោយជោគជ័យ។'
                      : 'BNPL installment of \$${_bnplAmount.toStringAsFixed(0)} with 0% interest is successfully activated with $_selectedBnplMerchant.'),
              textAlign: TextAlign.center,
              style: GoogleFonts.battambang(
                fontSize: 12.5,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0FA958),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  _isKhmer ? 'យល់ព្រម' : 'Done',
                  style: GoogleFonts.battambang(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
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
                  _isKhmer ? 'AI ជំនួយការ & Smart Credit' : 'AI Assistant & Smart Credit',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              _isKhmer
                  ? 'AI-Powered Banking Companion & Smart Credit'
                  : 'AI-Powered Banking Companion & Smart Credit',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 10.5,
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
          labelStyle: GoogleFonts.battambang(fontWeight: FontWeight.w700, fontSize: 13),
          tabs: [
            Tab(text: _isKhmer ? 'ជំនួយការសន្ទនា (Chat)' : 'AI Chat'),
            Tab(text: _isKhmer ? 'ឥណទានឆ្លាតវៃ (Credit)' : 'Smart Credit'),
            Tab(text: _isKhmer ? 'វិភាគការចំណាយ (Analytics)' : 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatTab(),
          _buildSmartCreditTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  // TAB 1: AI CHAT ASSISTANT
  Widget _buildChatTab() {
    final quickPrompts = _isKhmer ? _quickPromptsKm : _quickPromptsEn;
    return Column(
      children: [
        // Quick Prompts list
        Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: quickPrompts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  label: Text(
                    quickPrompts[index],
                    style: GoogleFonts.battambang(
                      fontSize: 12,
                      color: const Color(0xFF065F46),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: const Color(0xFFDFF5EA),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () => _sendMessage(quickPrompts[index]),
                ),
              );
            },
          ),
        ),

        // Chat message list
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    maxWidth: MediaQuery.of(context).size.width * 0.78,
                  ),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFF0FA958)
                        : (isAlert ? const Color(0xFFFFFBEB) : Colors.white),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    border: isAlert ? Border.all(color: const Color(0xFFFDE68A)) : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg['text'] as String,
                        style: GoogleFonts.battambang(
                          fontSize: 13.5,
                          color: isUser
                              ? Colors.white
                              : (isAlert ? const Color(0xFF92400E) : const Color(0xFF1F2937)),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          msg['time'] as String,
                          style: GoogleFonts.roboto(
                            fontSize: 10,
                            color: isUser ? Colors.white70 : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Message input bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F6F4),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: _isKhmer ? 'សួរ AI អំពីការចំណាយ ឬឥណទាន...' : 'Ask AI about spending or credit...',
                        hintStyle: GoogleFonts.battambang(fontSize: 13, color: Colors.grey.shade500),
                        border: InputBorder.none,
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF0FA958),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    onPressed: () => _sendMessage(_messageController.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // TAB 2: AI & SMART CREDIT SYSTEM
  Widget _buildSmartCreditTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Alternative Credit Score Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF064E3B), Color(0xFF047857)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF047857).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  _isKhmer ? 'ពិន្ទុ Alternative Credit' : 'Alternative Credit Score',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.battambang(
                                    color: Colors.white70,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Thin-File CBC',
                                  style: GoogleFonts.roboto(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFDE68A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '785',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '/ 850',
                                style: GoogleFonts.roboto(
                                  color: Colors.white54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF34D399), width: 1.2),
                      ),
                      child: Text(
                        _isKhmer ? 'គុណភាពខ្ពស់ (Eligible)' : 'Excellent (Eligible)',
                        style: GoogleFonts.battambang(
                          color: const Color(0xFFD1FAE5),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.bolt, color: Color(0xFFFBBF24), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _isKhmer
                              ? 'ដំណោះស្រាយសម្រាប់ Thin-file Customers (និស្សិត និងអាជីវករខ្នាតតូច)'
                              : 'Solution for Thin-file Customers (Students & Micro-merchants)',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Mode Selector: Nano-Loans vs BNPL
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedMode = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedMode == 0 ? AppColors.primaryGreen : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedMode == 0 ? AppColors.primaryGreen : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Digital Nano-Loans (\$50-\$1k)',
                        style: GoogleFonts.battambang(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: _selectedMode == 0 ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedMode = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedMode == 1 ? AppColors.primaryGreen : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedMode == 1 ? AppColors.primaryGreen : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Buy Now Pay Later (BNPL 0%)',
                        style: GoogleFonts.battambang(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: _selectedMode == 1 ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Cash Flow Analysis Metrics
          Text(
            _isKhmer ? 'ទិន្នន័យវាយតម្លៃលំហូរសាច់ប្រាក់ (Consented Cash Flow)' : 'Consented Cash Flow Analytics',
            style: GoogleFonts.battambang(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  label: _isKhmer ? 'ចំណូល KHQR ចូល' : 'KHQR Merchant Inflow',
                  value: '+\$980',
                  subtext: _isKhmer ? 'មធ្យមប្រចាំខែ' : 'Monthly Avg',
                  color: const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  label: _isKhmer ? 'ស្ថេរភាពសាច់ប្រាក់' : 'Cash Flow Stability',
                  value: '94%',
                  subtext: _isKhmer ? 'មានស្ថេរភាពល្អ' : 'Consistent',
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  label: _isKhmer ? 'ប្រវត្តិបង់វិក្កយបត្រ' : 'Utility Payment History',
                  value: '100%',
                  subtext: _isKhmer ? 'ទាន់ពេល 12 ខែ' : 'On-time 12 mos',
                  color: const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  label: _isKhmer ? 'កម្រិតសមាមាត្រ DTI' : 'Debt-to-Income (DTI)',
                  value: '15%',
                  subtext: _isKhmer ? 'ហានិភ័យទាបបំផុត' : 'Low risk profile',
                  color: const Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Interactive Simulator
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _selectedMode == 0 ? _buildNanoLoanSimulator() : _buildBnplSimulator(),
          ),
          const SizedBox(height: 16),

          // Governance & Responsible Lending Reassurance Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF93C5FD)),
            ),
            child: Row(
              children: [
                const Icon(Icons.gavel_rounded, color: Color(0xFF2563EB), size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _isKhmer
                        ? 'អភិបាលកិច្ច & Responsible Lending៖ ការផ្តល់កម្ចីស្ថិតក្រោមការត្រួតពិនិត្យដោយមនុស្ស (Human-in-the-loop), AI Explainability, និងអនុលោមតាមបទប្បញ្ញត្តិធនាគារជាតិនៃកម្ពុជា (NBC)។'
                        : 'Governance & Responsible Lending: Underwriting supervised by human-in-the-loop, AI explainability, and strictly compliant with NBC regulations.',
                    style: GoogleFonts.battambang(
                      fontSize: 11.5,
                      color: const Color(0xFF1E40AF),
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0FA958),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 2,
              ),
              onPressed: _submitCreditApplication,
              child: Text(
                _selectedMode == 0
                    ? (_isKhmer ? 'ស្នើសុំ Digital Nano-Loan ភ្លាមៗ (គ្មានទ្រព្យបញ្ចាំ)' : 'Apply for Digital Nano-Loan (No Collateral)')
                    : (_isKhmer ? 'ស្នើសុំបង់រំលស់ BNPL 0% ភ្លាមៗ' : 'Apply for BNPL 0% Installment'),
                style: GoogleFonts.battambang(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNanoLoanSimulator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Digital Nano-Loan', style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD1FAE5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _isKhmer ? 'គ្មានទ្រព្យបញ្ចាំ' : 'No Collateral',
                style: GoogleFonts.battambang(fontSize: 11, color: const Color(0xFF065F46), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_isKhmer ? 'ទំហំកម្ចីស្នើសុំ (\$50 - \$1,000)' : 'Loan Request Amount (\$50 - \$1,000)', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
            Text(
              '\$${_loanAmount.toInt()}',
              style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958)),
            ),
          ],
        ),
        Slider(
          value: _loanAmount,
          min: 50,
          max: 1000,
          divisions: 19,
          activeColor: const Color(0xFF0FA958),
          onChanged: (val) => setState(() => _loanAmount = val),
        ),
        const SizedBox(height: 8),
        Text(_isKhmer ? 'រយៈពេលសង (Tenure)' : 'Repayment Tenure', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        Row(
          children: [3, 6, 12].map((tenure) {
            final isSelected = _selectedTenure == tenure;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedTenure = tenure),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF0FA958) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _isKhmer ? '$tenure ខែ' : '$tenure mos',
                      style: GoogleFonts.battambang(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_isKhmer ? 'ប្រាក់ត្រូវសងប្រចាំខែប៉ាន់ស្មាន' : 'Estimated Monthly Payment', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.black87)),
            Text(
              '\$${_monthlyRepayment.toStringAsFixed(2)} / ${_isKhmer ? 'ខែ' : 'mo'}',
              style: GoogleFonts.roboto(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF065F46),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBnplSimulator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Buy Now Pay Later (BNPL 0%)', style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _isKhmer ? 'ការប្រាក់ 0%' : '0% Interest',
                style: GoogleFonts.battambang(fontSize: 11, color: const Color(0xFFB45309), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(_isKhmer ? 'ដៃគូពាណិជ្ជករក្នុងបណ្តាញ Chip Mong:' : 'Chip Mong Partner Merchant:', style: GoogleFonts.battambang(fontSize: 12, color: Colors.grey.shade700)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.storefront_rounded, size: 18, color: Color(0xFF0F172A)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _selectedBnplMerchant,
                  style: GoogleFonts.battambang(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_isKhmer ? 'តម្លៃទំនិញបង់រំលស់' : 'Installment Purchase Amount', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
            Text(
              '\$${_bnplAmount.toStringAsFixed(0)}',
              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958)),
            ),
          ],
        ),
        Slider(
          value: _bnplAmount,
          min: 30,
          max: 300,
          divisions: 9,
          activeColor: const Color(0xFF0FA958),
          onChanged: (val) => setState(() => _bnplAmount = val),
        ),
        const SizedBox(height: 8),
        Text(_isKhmer ? 'ដំណាក់កាលបង់រំលស់ (0% Interest)' : 'Installment Schedule (0% APR)', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        Row(
          children: [3, 6].map((months) {
            final isSelected = _bnplMonths == months;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _bnplMonths = months),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF0FA958) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _isKhmer ? '$months ខែ (0% APR)' : '$months mos (0% APR)',
                      style: GoogleFonts.battambang(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_isKhmer ? 'បង់ប្រចាំខែ (គ្មានការប្រាក់)' : 'Monthly Payment (0% APR)', style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.black87)),
            Text(
              '\$${_monthlyRepayment.toStringAsFixed(2)} / ${_isKhmer ? 'ខែ' : 'mo'}',
              style: GoogleFonts.roboto(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF065F46),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required String subtext,
    required Color color,
  }) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.battambang(fontSize: 11.5, color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(subtext, style: GoogleFonts.battambang(fontSize: 10.5, color: Colors.grey.shade500)),
        ],
      ),
    );
  }

  // TAB 3: SPENDING & FINANCIAL ANALYTICS
  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnalyticsSummaryCard(),
          const SizedBox(height: 18),
          _buildBudgetProgressBar(),
          const SizedBox(height: 18),
          Text(
            _isKhmer ? 'ប្រភេទចំណាយច្រើនបំផុត (Top Categories)' : 'Top Expense Categories',
            style: GoogleFonts.battambang(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          _buildCategoryItem(
            icon: Icons.restaurant_rounded,
            color: const Color(0xFFF59E0B),
            categoryName: _isKhmer ? 'អាហារ និងភេសជ្ជៈ (Food & Dining)' : 'Food & Dining',
            amount: '\$269.10',
            percentage: '42%',
            progress: 0.42,
          ),
          _buildCategoryItem(
            icon: Icons.local_grocery_store_rounded,
            color: const Color(0xFF10B981),
            categoryName: _isKhmer ? 'ទិញទំនិញ Chip Mong Supermarket' : 'Chip Mong Supermarket',
            amount: '\$153.75',
            percentage: '24%',
            progress: 0.24,
          ),
          _buildCategoryItem(
            icon: Icons.electric_bolt_rounded,
            color: const Color(0xFF3B82F6),
            categoryName: _isKhmer ? 'វិក្កយបត្រទឹក ភ្លើង អ៊ីនធឺណិត (Bills)' : 'Utility Bills & Internet',
            amount: '\$115.30',
            percentage: '18%',
            progress: 0.18,
          ),
          _buildCategoryItem(
            icon: Icons.directions_car_rounded,
            color: const Color(0xFF8B5CF6),
            categoryName: _isKhmer ? 'ការធ្វើដំណើរ & ប្រេងឥន្ធនៈ (Transport)' : 'Transport & Fuel',
            amount: '\$51.25',
            percentage: '8%',
            progress: 0.08,
          ),
          const SizedBox(height: 18),
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
                      _isKhmer ? 'គន្លឹះសន្សំប្រាក់ AI (Personalized AI Advice)' : 'Personalized AI Saving Tips',
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
                  _isKhmer
                      ? '• ផ្អែកលើការទិញទំនិញចុងសប្តាហ៍នៅផ្សារទំនើប Chip Mong Supermarket អ្នកអាចសន្សំបាន \$45 បន្ថែមទៀត ប្រសិនបើអ្នកប្រើប័ណ្ណ Chip Mong Visa ដើម្បីទទួលបាន Cashback 1%។\n\n'
                        '• កាត់បន្ថយការចំណាយលើកាហ្វេ និងភេសជ្ជៈត្រឹម 1 កែវក្នុងមួយថ្ងៃ អាចជួយបង្កើនប្រាក់សន្សំបាន \$35/ខែ។'
                      : '• Based on your weekend groceries at Chip Mong Supermarket, earn \$45 extra cashback with Chip Mong Visa card.\n\n'
                        '• Lowering daily café beverages by 1 cup saves approximately \$35/month.',
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

  Widget _buildAnalyticsSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF064E3B), Color(0xFF0FA958)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0FA958).withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isKhmer ? 'សរុបការចំណាយខែនេះ (October 2026)' : 'Total Spending (October 2026)',
            style: GoogleFonts.battambang(
              color: Colors.white70,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$640.70',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_down_rounded, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '-12%',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            _isKhmer ? 'ចំណាយតិចជាងខែមុន \$87.30 (ល្អប្រសើរ 👍)' : 'Decreased by \$87.30 compared to last month (Great 👍)',
            style: GoogleFonts.battambang(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetProgressBar() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isKhmer ? 'កញ្ចប់ថវិកាប្រចាំខែ (Monthly Budget)' : 'Monthly Budget',
                style: GoogleFonts.battambang(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                '\$640.70 / \$750.00',
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0FA958),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.854,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFEAB308)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isKhmer ? 'បានប្រើប្រាស់ 85%' : '85% Utilized',
                style: GoogleFonts.battambang(fontSize: 11.5, color: Colors.grey.shade600),
              ),
              Text(
                _isKhmer ? 'នៅសល់ \$109.30' : 'Remaining \$109.30',
                style: GoogleFonts.battambang(
                  fontSize: 11.5,
                  color: const Color(0xFF0FA958),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
