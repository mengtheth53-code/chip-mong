import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'ai_assistant_screen.dart';
import 'smart_credit_screen.dart';
import 'campus_hub_screen.dart';
import 'shared_savings_screen.dart';
import 'daily_auto_savings_screen.dart';

class InnovationHubScreen extends StatefulWidget {
  const InnovationHubScreen({super.key});

  @override
  State<InnovationHubScreen> createState() => _InnovationHubScreenState();
}

class _InnovationHubScreenState extends State<InnovationHubScreen> {
  bool _isKhmer = true;

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
                const Icon(Icons.lightbulb_rounded, color: Color(0xFFFBBF24), size: 20),
                const SizedBox(width: 8),
                Text(
                  _isKhmer ? 'គំនិតនវានុវត្តន៍ទាំង ៥' : '5 Product Innovations',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Chip Mong Bank Innovation Hub',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
        actions: [
          // Language Switcher Toggle Pill
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _isKhmer = !_isKhmer),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white60, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isKhmer ? '🇰🇭 ខ្មែរ' : '🇬🇧 EN',
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.swap_horiz, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Executive Pitch Header Card
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.rocket_launch, color: Color(0xFF6EE7B7), size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isKhmer ? 'យុទ្ធសាស្ត្រនវានុវត្តន៍ឌីជីថល' : 'Digital Innovation Strategy',
                              style: GoogleFonts.battambang(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _isKhmer ? 'រៀបចំជូនគណៈគ្រប់គ្រង និង HR ធនាគារ ជីប ម៉ុង' : 'Prepared for Chip Mong Bank Leadership & HR',
                              style: GoogleFonts.battambang(
                                color: Colors.white70,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _isKhmer
                        ? 'គំនិតនវានុវត្តន៍ផលិតផលទាំង ៥ នេះត្រូវបានរចនាឡើងដើម្បីជំរុញចំនួនអ្នកប្រើប្រាស់សកម្ម (DAU), បង្កើនទំហំប្រាក់បញ្ញើ CASA, ពន្លឿនការបញ្ចេញឥណទានសុវត្ថិភាព និងទាក់ទាញអតិថិជនវ័យក្មេង Gen-Z តាមរយៈ Ecosystem របស់ក្រុមហ៊ុន ជីប ម៉ុង។'
                        : 'These 5 product innovation concepts are designed to elevate Daily Active Users (DAU), accelerate low-cost CASA deposit growth, streamline safe AI credit evaluations, and acquire Gen-Z customers via the Chip Mong Group ecosystem.',
                    style: GoogleFonts.battambang(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Innovation 1: AI Banking Assistant
            _buildInnovationCard(
              number: '01',
              icon: Icons.psychology_rounded,
              color: const Color(0xFF0FA958),
              titleKm: 'AI-Powered Banking Assistant\n(ជំនួយការហិរញ្ញវត្ថុឆ្លាតវៃ AI)',
              titleEn: 'AI-Powered Banking Assistant',
              conceptKm: 'ប្រព័ន្ធបញ្ញាសិប្បនិម្មិត (AI) បញ្ចូលក្នុង App ដើរតួជា "ទីប្រឹក្សាហិរញ្ញវត្ថុផ្ទាល់ខ្លួន" ជួយអតិថិជនគ្រប់គ្រង និងតាមដានសុខភាពហិរញ្ញវត្ថុ។',
              conceptEn: 'An embedded AI financial companion designed to assist customers in managing daily personal finances and improving financial literacy.',
              howKm: '• បែងចែកប្រភេទទិន្នន័យចំណាយស្វ័យប្រវត្ត (Auto-categorization) ដូចជា៖ អាហារ, វិក្កយបត្រ, ការទិញទំនិញ...\n'
                     '• ផ្ញើការដាស់តឿនឆ្លាតវៃនៅពេលការចាយវាយជិតលើសកញ្ចប់ថវិកាប្រចាំខែ (Budget limit alert)។\n'
                     '• ផ្តល់ការណែនាំពីវិធីសន្សំប្រាក់ផ្អែកលើទម្លាប់ជាក់ស្តែងរបស់អតិថិជនម្នាក់ៗ។',
              howEn: '• Automatically categorizes transactions (Food & Dining, Utilities, Shopping).\n'
                     '• Sends proactive alerts when users approach monthly budget limits.\n'
                     '• Delivers personalized conversational tips on saving based on spending patterns.',
              valueKm: 'បង្កើនចំនួនអ្នកចូលប្រើប្រាស់ App ប្រចាំថ្ងៃ (Daily Active Users - DAU) និងធ្វើឱ្យ App ក្លាយជាផ្នែកមួយនៃជីវិតរស់នៅរបស់អតិថិជន (Lifestyle Banking)។',
              valueEn: 'Significantly boosts Daily Active Users (DAU) and transforms the app from a simple transactional utility into an indispensable lifestyle banking companion.',
              demoScreen: const AiAssistantScreen(),
            ),

            // Innovation 2: AI & Smart Credit System
            _buildInnovationCard(
              number: '02',
              icon: Icons.bolt_rounded,
              color: const Color(0xFF047857),
              titleKm: 'AI & Smart Credit System\n(ប្រព័ន្ធវាយតម្លៃឥណទានឆ្លាតវៃ)',
              titleEn: 'AI & Smart Credit System',
              conceptKm: 'ប្រើប្រាស់ AI ដើម្បីវិភាគទិន្នន័យប្រតិបត្តិការហិរញ្ញវត្ថុ និងលំហូរសាច់ប្រាក់ (Cash Flow) ដែលអតិថិជនបានអនុញ្ញាត ដើម្បីពន្លឿនការវាយតម្លៃឥណទាន ដោយរក្សាការត្រួតពិនិត្យចុងក្រោយដោយមនុស្ស (Human-in-the-loop)។',
              conceptEn: 'Leveraging AI to analyze consented customer transaction flows and cash patterns to accelerate loan evaluations, while keeping mandatory "Human-in-the-loop" for final approvals.',
              howKm: '• ម៉ាស៊ីន AI គណនាពិន្ទុឥណទានបឋម (Pre-scoring) ដោយពិនិត្យលើស្ថេរភាពចំណូល-ចំណាយក្នុងគណនី។\n'
                     '• ជួយកាត់បន្ថយពេលវេលាវាយតម្លៃកម្ចីខ្នាតតូចពីច្រើនថ្ងៃ មកត្រឹមប៉ុន្មាននាទី។\n'
                     '• បញ្ជូនរបាយការណ៍សង្ខេបទៅកាន់មន្ត្រីឥណទាន ដើម្បីធ្វើការសម្រេចចិត្តអនុម័តជាផ្លូវការចុងក្រោយ ធានាភាពត្រឹមត្រូវ និងសុវត្ថិភាព។',
              howEn: '• Analyzes recurring cash flows to generate an instant pre-qualification credit score.\n'
                     '• Reduces loan turnaround time from days to minutes for qualified retail customers.\n'
                     '• Forwards summarized risk assessments to loan officers for verified final decisions.',
              valueKm: 'កាត់បន្ថយចំណាយប្រតិបត្តិការរដ្ឋបាល (Operational Cost), ពន្លឿនការបញ្ចេញកម្ចី និងរក្សាអត្រាបំណុលខូច (NPL) ឱ្យនៅកម្រិតទាបបំផុត។',
              valueEn: 'Lowers operational overhead, shortens retail loan turnaround, and maintains an exceptionally low Non-Performing Loan (NPL) ratio.',
              demoScreen: const SmartCreditScreen(),
            ),

            // Innovation 3: University Ecosystem Integration
            _buildInnovationCard(
              number: '03',
              icon: Icons.school_rounded,
              color: const Color(0xFF2563EB),
              titleKm: 'University Ecosystem Integration\n(ប្រព័ន្ធធនាគារតភ្ជាប់សាកលវិទ្យាល័យ)',
              titleEn: 'University Ecosystem Integration (Campus Hub)',
              conceptKm: 'បង្កើតបណ្តាញតភ្ជាប់រវាង App ធនាគារ ជាមួយសាកលវិទ្យាល័យដៃគូនានាក្នុងប្រទេសកម្ពុជា ដើម្បីបង្កើតសហគមន៍ហិរញ្ញវត្ថុសម្រាប់និស្សិត។',
              conceptEn: 'Connecting the banking app directly with higher education institutions to build an end-to-end student campus banking ecosystem.',
              howKm: '• បង្កើតផ្ទាំងមុខងារ "Campus Hub" ក្នុង App សម្រាប់៖ បង់ថ្លៃសិក្សាដោយផ្ទាល់, ស្កេនទូទាត់ KHQR នៅអាហារដ្ឋាន និងបណ្ណាគារក្នុងសាលា។\n'
                     '• ភ្ជាប់អត្តសញ្ញាណប័ណ្ណនិស្សិតឌីជីថល (Digital Student ID) ក្នុង App ជាមួយការបញ្ចុះតម្លៃពិសេសនៅផ្សារទំនើប Chip Mong Supermarket ឬរោងកុន Legend។',
              howEn: '• Introduces an in-app "Campus Hub" for seamless tuition payments, cafeteria KHQR payments, and student services.\n'
                     '• Links digital student profiles with exclusive privileges across the Chip Mong retail ecosystem (Supermarkets, Malls, Legend Cinemas).',
              valueKm: 'ទាក់ទាញមូលដ្ឋានអតិថិជនវ័យក្មេង (Gen-Z) តាំងពីពេលកំពុងសិក្សា ដែលនឹងក្លាយជាអតិថិជនស្នូលនៃប្រាក់បញ្ញើ និងប្រាក់កម្ចីនៅពេលពួកគេចេញធ្វើការ (High Lifetime Value)។',
              valueEn: 'Early acquisition of tech-savvy Gen-Z youth with high customer lifetime value (LTV) and long-term deposit and lending growth.',
              demoScreen: const CampusHubScreen(),
            ),

            // Innovation 4: Smart Shared Savings
            _buildInnovationCard(
              number: '04',
              icon: Icons.groups_rounded,
              color: const Color(0xFF0F766E),
              titleKm: 'Smart Shared Savings\n(គណនីសន្សំរួមគ្នាឆ្លាតវៃតាមគោលដៅ)',
              titleEn: 'Smart Shared Savings (Group Goals)',
              conceptKm: 'បង្កើតគោលដៅសន្សំប្រាក់រួមគ្នាជាក្រុមសម្រាប់ មិត្តភក្តិ, គូស្នេហ៍, គ្រួសារ ឬដៃគូអាជីវកម្ម ដោយមិនចាំបាច់ទៅបើកគណនីរួម (Joint Account) ស្មុគស្មាញនៅសាខា។',
              conceptEn: 'A digital goal-oriented collaborative savings feature enabling groups (couples, friends, families, partners) to save together without branch paperwork.',
              howKm: '• អ្នកបង្កើតអាចកំណត់គោលដៅ (ឧ. «ដំណើរកម្សាន្តទៅសៀមរាប», «លុយរៀបការ», «ទុនអាជីវកម្ម») និងអញ្ជើញសមាជិកតាមលេខទូរស័ព្ទ។\n'
                     '• សមាជិកម្នាក់ៗអាចដាក់ប្រាក់ចូលតាមការកំណត់ ហើយគ្រប់គ្នាអាចមើលឃើញសមតុល្យ និងការរួមចំណែក (Contribution) យ៉ាងច្បាស់លាស់ និងមានតម្លាភាព។',
              howEn: '• Users create a shared target ("Siem Reap Trip", "Wedding Fund", "Startup") and invite participants via phone number.\n'
                     '• All participants contribute with real-time transparent contribution tracking.',
              valueKm: 'បង្កើតឥទ្ធិពលទាក់ទាញបន្តគ្នាពីមាត់មួយទៅមាត់មួយ (Viral Network Effect) ជំរុញឱ្យមានការទាញយក App និងបង្កើនទំហំប្រាក់បញ្ញើសន្សំ (CASA) យ៉ាងច្រើន។',
              valueEn: 'Generates viral organic user acquisition through peer invitations and significantly multiplies low-cost retail CASA deposits.',
              demoScreen: const SharedSavingsScreen(),
            ),

            // Innovation 5: Daily Auto-Savings
            _buildInnovationCard(
              number: '05',
              icon: Icons.savings_rounded,
              color: const Color(0xFF059669),
              titleKm: 'Daily Auto-Savings\n(ការសន្សំប្រាក់ខ្នាតតូចប្រចាំថ្ងៃដោយស្វ័យប្រវត្ត)',
              titleEn: 'Daily Auto-Savings (Micro-Savings)',
              conceptKm: 'ជួយអតិថិជនបង្កើតទម្លាប់សន្សំប្រាក់ជាប្រចាំ ដោយមិនមានសម្ពាធ តាមរយៈការកាត់ប្រាក់ខ្នាតតូច (Micro-Savings) ចូលគណនីសន្សំស្វ័យប្រវត្តជារៀងរាល់ថ្ងៃ។',
              conceptEn: 'A frictionless micro-saving mechanism enabling users to cultivate consistent daily saving habits without financial strain.',
              howKm: '• អតិថិជនជ្រើសរើសទំហំទឹកប្រាក់សន្សំប្រចាំថ្ងៃ៖\n'
                     '  - \$1 / ថ្ងៃ ➔ សន្សំបាន ~\$30 / ខែ\n'
                     '  - \$2 / ថ្ងៃ ➔ សន្សំបាន ~\$60 / ខែ\n'
                     '  - \$5 / ថ្ងៃ ➔ សន្សំបាន ~\$150 / ខែ\n'
                     '• ប្រព័ន្ធនឹងកាត់ប្រាក់ស្វ័យប្រវត្តជារៀងរាល់ថ្ងៃចូលកាតាបសន្សំដាច់ដោយឡែក។ អតិថិជនមានសិទ្ធិផ្អាក (Pause) ឬដកប្រាក់ចេញវិញបានគ្រប់ពេលវេលា។',
              howEn: '• Users set a daily automated micro-deposit based on budget:\n'
                     '  - Save \$1/day ➔ Accumulates ~\$30/month\n'
                     '  - Save \$2/day ➔ Accumulates ~\$60/month\n'
                     '  - Save \$5/day ➔ Accumulates ~\$150/month\n'
                     '• The app transfers selected amounts daily into a dedicated pocket, with full flexibility to pause or withdraw anytime.',
              valueKm: 'បង្កើតលំហូរប្រាក់បញ្ញើចរន្តចូលធនាគារជារៀងរាល់ថ្ងៃ (Consistent Daily Liquidity) និងបង្កើតភាពស្និទ្ធស្នាលរវាងអតិថិជន និងធនាគារ។',
              valueEn: 'Secures continuous daily low-cost deposit growth (CASA) and fosters strong customer loyalty and daily brand touchpoints.',
              demoScreen: const DailyAutoSavingsScreen(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInnovationCard({
    required String number,
    required IconData icon,
    required Color color,
    required String titleKm,
    required String titleEn,
    required String conceptKm,
    required String conceptEn,
    required String howKm,
    required String howEn,
    required String valueKm,
    required String valueEn,
    required Widget demoScreen,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with number and icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'INNOVATION $number',
                        style: GoogleFonts.roboto(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: color,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _isKhmer ? titleKm : titleEn,
                        style: GoogleFonts.battambang(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Concept
                _buildSectionRow(
                  tag: _isKhmer ? '💡 ទស្សនទាន (Concept)' : '💡 The Concept',
                  tagColor: const Color(0xFFF59E0B),
                  content: _isKhmer ? conceptKm : conceptEn,
                ),
                const SizedBox(height: 12),

                // 2. How it works
                _buildSectionRow(
                  tag: _isKhmer ? '⚙️ របៀបដំណើរការ (How it Works)' : '⚙️ How it Works',
                  tagColor: const Color(0xFF3B82F6),
                  content: _isKhmer ? howKm : howEn,
                ),
                const SizedBox(height: 12),

                // 3. Value to Bank
                _buildSectionRow(
                  tag: _isKhmer ? '📈 ផលចំណេញដល់ធនាគារ (Value to Bank)' : '📈 Value to Bank',
                  tagColor: const Color(0xFF0FA958),
                  content: _isKhmer ? valueKm : valueEn,
                  isHighlight: true,
                ),
                const SizedBox(height: 18),

                // Interactive Demo Button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 1,
                    ),
                    icon: const Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 20),
                    label: Text(
                      _isKhmer ? 'សាកល្បងមុខងារផ្ទាល់ (Live Interactive Demo)' : 'Launch Interactive Demo',
                      style: GoogleFonts.battambang(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => demoScreen),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionRow({
    required String tag,
    required Color tagColor,
    required String content,
    bool isHighlight = false,
  }) {
    return Container(
      width: double.infinity,
      padding: isHighlight ? const EdgeInsets.all(12) : EdgeInsets.zero,
      decoration: isHighlight
          ? BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFBBF7D0)),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: GoogleFonts.battambang(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: isHighlight ? const Color(0xFF166534) : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: GoogleFonts.battambang(
              fontSize: 12,
              color: isHighlight ? const Color(0xFF14532D) : const Color(0xFF4B5563),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
