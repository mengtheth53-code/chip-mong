import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'biometric_auth_screen.dart';
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
                  _isKhmer ? 'សំណើគំនិតច្នៃប្រឌិតទាំង ៥' : '5 Product Innovations',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Chip Mong Banking App • Proposal Section 4',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 10.5,
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
                              _isKhmer ? 'ផ្នែកទី ៤៖ សំណើគំនិតច្នៃប្រឌិតផលិតផល ៥' : 'Section 4: 5 Product Innovations',
                              style: GoogleFonts.battambang(
                                color: Colors.white,
                                fontSize: 15.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _isKhmer ? 'សម្រាប់ CHIP MONG BANKING APP' : 'For Chip Mong Banking App',
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
                        ? 'គំនិតទាំង ៥ នេះត្រូវបានរៀបចំឡើងដោយផ្អែកលើការស្វែងរកបញ្ហាដែលអតិថិជនជួបប្រទះ និងការស្វែងរកដំណោះស្រាយដែលអាចបង្កើនភាពងាយស្រួល សុវត្ថិភាព និងតម្លៃបន្ថែម ព្រមទាំងគាំទ្រដល់ការប្រកួតប្រជែងរបស់ធនាគារក្នុងទីផ្សារឌីជីថល (CASA Deposits, DAU, Safe Lending & Gen-Z Ecosystem)។'
                        : 'These 5 product innovation concepts identify core customer pain points and introduce bankable solutions delivering speed, security, and strategic value—elevating CASA growth, DAU engagement, safe credit evaluation, and Gen-Z acquisition via the Chip Mong ecosystem.',
                    style: GoogleFonts.battambang(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4.1 Innovation 1: Biometric Authentication — One-Touch QuickPay
            _buildInnovationCard(
              number: '01',
              sectionTag: '៤.១',
              icon: Icons.fingerprint_rounded,
              color: const Color(0xFF0FA958),
              titleKm: 'Biometric Authentication — One-Touch QuickPay',
              titleEn: 'Biometric Authentication — One-Touch QuickPay',
              problemKm: 'ភាពស្មុគស្មាញ និងការចំណាយពេលក្នុងការផ្ទៀងផ្ទាត់អត្តសញ្ញាណរាល់ពេលទូទាត់ប្រាក់ទំហំតូច (ឧ. ទិញកាហ្វេ \$1.50 ឬទំនិញ \$5 នៅ Chip Mong Supermarket)។ ការបញ្ចូលលេខកូដ PIN នៅទីសាធារណៈបង្កហានិភ័យលួចមើល (Shoulder Surfing)។',
              problemEn: 'Friction and checkout delays when entering PINs for frequent micro-purchases (e.g. \$1.50 coffee, \$5 groceries at Chip Mong Supermarket). Manual public PIN entry exposes users to shoulder-surfing risks.',
              conceptKm: 'បង្កើតមុខងារ One-Touch QuickPay ប្រើប្រាស់ការផ្ទៀងផ្ទាត់អត្តសញ្ញាណតាមរយៈស្នាមមេដៃ ឬផ្ទៃមុខ សម្រួលដល់ការអនុម័តប្រតិបត្តិការទូទាត់ប្រាក់ទំហំតូច (កម្រិតសាកល្បងក្រោម \$10 ឬកម្រិតកំណត់របស់ធនាគារ) ដោយមិនបាច់វាយ PIN រាល់ពេល។',
              conceptEn: 'One-Touch QuickPay leverages on-device fingerprint or facial biometrics to streamline approvals for small transactions (pilot threshold under \$10 or bank-designated limits) without manual PIN entry.',
              howKm: '• គោលការណ៍ Biometric Step-Up Security៖ ប្រតិបត្តិការទំហំតូចប្រើ One-Touch Biometric រហ័ស។ ប្រតិបត្តិការទឹកប្រាក់ខ្ពស់ ឬមានសញ្ញាសង្ស័យ ត្រូវ Step-up ទាមទារ PIN ឬ SMS OTP បន្ថែម។\n'
                     '• Face Liveness Detection៖ ផ្ទៀងផ្ទាត់ភាពរស់រវើកនៃផ្ទៃមុខតាមស្តង់ដារសុវត្ថិភាព។\n'
                     '• ស្តង់ដារ FIDO2 & On-Device Security៖ ទិន្នន័យជីវមាត្រត្រូវបានដំណើរការលើឧបករណ៍អ្នកប្រើប្រាស់ (Secure Enclave / Android Keystore) ដោយមិនបញ្ជូនរូបភាព Biometric ដើមទៅ Server ធនាគារឡើយ។',
              howEn: '• Biometric Step-Up Security: Low-value retail transactions approve with 1-touch. High-value or anomalous transactions step-up to mandatory PIN/OTP.\n'
                     '• Face Liveness Detection: Anti-spoofing presentation attack detection.\n'
                     '• FIDO2 & On-Device Cryptography: Biometric credentials remain strictly in local hardware Secure Enclave; no raw biometric templates are transmitted.',
              valueKm: 'កាត់បន្ថយពេលវេលាទូទាត់ (Checkout Speed), បង្កើនចំនួនប្រតិបត្តិការសកម្ម (DAU), ការពារការលួចគណនី (Anti-Fraud), និងតាមដានសូចនាករ KPIs (ពេលវេលាជាមធ្យម, អត្រាបរាជ័យ, ចំនួនករណីសង្ស័យ)។',
              valueEn: 'Accelerates checkout speed, multiplies Daily Active Users (DAU), prevents fraud, and measures KPIs (average turnaround time, failure rate, security anomalies).',
              demoScreen: const BiometricAuthScreen(),
            ),

            // 4.2 Innovation 2: AI & Smart Credit System
            _buildInnovationCard(
              number: '02',
              sectionTag: '៤.២',
              icon: Icons.bolt_rounded,
              color: const Color(0xFF047857),
              titleKm: 'AI & Smart Credit System — ប្រព័ន្ធវាយតម្លៃឥណទានឆ្លាតវៃ',
              titleEn: 'AI & Smart Credit System (Alternative Scoring & Nano-Loans)',
              problemKm: 'យុវជន និស្សិតទើបបញ្ចប់ការសិក្សា និងអាជីវករខ្នាតតូចមានលំហូរសាច់ប្រាក់ជាក់ស្តែង តែខ្វះប្រវត្តិឥណទាននៅ Credit Bureau Cambodia (CBC) ហៅថា "Thin-file Customers" ធ្វើឱ្យពួកគេពិបាកទទួលបានកម្ចីផ្លូវការ។',
              problemEn: 'Youth, fresh graduates, and micro-merchants generate real cash flows but lack conventional credit bureau files at CBC ("Thin-file Customers"), barring them from formal retail credit.',
              conceptKm: 'បង្កើតប្រព័ន្ធ AI-driven Alternative Credit Scoring វិភាគទិន្នន័យហិរញ្ញវត្ថុដែលមានការអនុញ្ញាត (Consent) ដើម្បីវាយតម្លៃសមត្ថភាពសងជាក់ស្តែង និងផ្តល់កម្ចីខ្នាតតូចឌីជីថល (Digital Nano-Loans) និងសេវា Buy Now Pay Later (BNPL)។',
              conceptEn: 'An AI-driven Alternative Credit Scoring engine analyzing consented transactional footprints to assess true debt serviceability, unlocking Digital Nano-Loans and Buy Now Pay Later (BNPL).',
              howKm: '• វិភាគលំហូរសាច់ប្រាក់ជាក់ស្តែង៖ ពិនិត្យប្រវត្តិទទួលប្រាក់តាម KHQR, ការទូទាត់ចំណាយ និងវិក្កយបត្រ គួបផ្សំនឹងចំណាយប្រចាំខែ និងបំណុលដែលមានស្រាប់។\n'
                     '• Digital Nano-Loans៖ ផ្តល់កម្ចីខ្នាតតូចពី \$50 ដល់ \$1,000 ដោយមិនបាច់មានទ្រព្យបញ្ចាំ ផ្អែកលើការវាយតម្លៃហានិភ័យ។\n'
                     '• Buy Now Pay Later (BNPL)៖ ភ្ជាប់ជាមួយដៃគូពាណិជ្ជករក្នុងបណ្តាញ Chip Mong (ជម្រើសបង់រំលស់ការប្រាក់ 0% ក្នុងយុទ្ធនាការពិសេស)។\n'
                     '• អភិបាលកិច្ច & Responsible Lending៖ មាន Human-in-the-loop, AI Explainability, ការពារទិន្នន័យ (Data Privacy), និងអនុលោមតាមបទប្បញ្ញត្តិធនាគារជាតិនៃកម្ពុជា (NBC)។',
              howEn: '• Multi-factor Cash Flow Analysis: Assesses recurring KHQR merchant inflows, utility payments, living costs, and debt commitments.\n'
                     '• Digital Nano-Loans: Uncollateralized micro-credit from \$50 to \$1,000.\n'
                     '• Buy Now Pay Later (BNPL): Integrated with Chip Mong retail network, featuring 0% interest campaign options.\n'
                     '• Responsible Lending & Governance: Human-in-the-loop supervision, AI explainability, explicit customer consent, and NBC regulatory compliance.',
              valueKm: 'ពង្រីកមូលដ្ឋានអតិថិជនថ្មី (Financial Inclusion), បង្កើនចំណូលការប្រាក់សុវត្ថិភាព, កាត់បន្ថយការងាររដ្ឋបាលដោយដៃ និងគ្រប់គ្រងអត្រាបំណុលខូច (NPL) ឱ្យនៅទាបបំផុត។',
              valueEn: 'Expands financial inclusion to creditworthy thin-file borrowers, grows quality retail net interest margin, minimizes manual underwriting overhead, and safeguards low NPLs.',
              demoScreen: const SmartCreditScreen(),
            ),

            // 4.3 Innovation 3: University Ecosystem Integration
            _buildInnovationCard(
              number: '03',
              sectionTag: '៤.៣',
              icon: Icons.school_rounded,
              color: const Color(0xFF2563EB),
              titleKm: 'University Ecosystem Integration — ប្រព័ន្ធតភ្ជាប់សាកលវិទ្យាល័យ',
              titleEn: 'University Ecosystem Integration (Campus Hub - NUM Pilot)',
              problemKm: 'និស្សិតត្រូវការសេវាហិរញ្ញវត្ថុច្រើន (បង់ថ្លៃសិក្សា ចំណាយប្រចាំថ្ងៃ គ្រប់គ្រងប្រាក់) តែសេវាទាំងនោះនៅបែកខ្ញែកគ្នា ដែលបង្កការលំបាក និងចំណាយពេលតម្រង់ជួរ។',
              problemEn: 'Students manage multiple fragmented financial tasks (tuition fee queues, daily cafeteria expenses, multiple cards), lacking a unified digital student banking hub.',
              conceptKm: 'ភ្ជាប់ Chip Mong Banking App ជាមួយសាកលវិទ្យាល័យដៃគូ ដោយចាប់ផ្តើមគម្រោងសាកល្បង (Pilot Project) ជាមួយសាកលវិទ្យាល័យជាតិគ្រប់គ្រង (NUM) មុននឹងពង្រីកទៅកាន់ស្ថាប័នអប់រំដទៃទៀត។',
              conceptEn: 'Connecting the banking app directly with higher education institutions, kicking off an inaugural pilot with the National University of Management (NUM) before scaling across Cambodia.',
              howKm: '• ទី១. Digital Student ID (កាតនិស្សិតឌីជីថល)៖ បង្ហាញអត្តសញ្ញាណនិស្សិត និងភ្ជាប់ប្រព័ន្ធស្រង់វត្តមានក្នុងសាកលវិទ្យាល័យដៃគូ។\n'
                     '• ទី២. Tuition Payment & 0% Installment៖ បង់ថ្លៃសិក្សាដោយផ្ទាល់តាម App យ៉ាងរហ័ស ជាមួយជម្រើសបង់រំលស់ថ្លៃសិក្សាការប្រាក់ 0%។\n'
                     '• ទី៣. Student Perks៖ បញ្ចុះតម្លៃពិសេសនៅ Chip Mong Supermarket, Chip Mong Malls, និងរោងភាពយន្ត Legend Cinemas។',
              howEn: '• 1. Digital Student ID: In-app verified student credential with campus access & attendance logging.\n'
                     '• 2. Tuition Payments & 0% Installments: Direct 1-tap tuition settlement and flexible 0% interest semester installment plans.\n'
                     '• 3. Student Perks: Exclusive student discounts across Chip Mong Supermarkets, Megamalls, and Legend Cinemas.',
              valueKm: 'កសាងទំនាក់ទំនងជាមួយ Gen-Z តាំងពីពេលកំពុងសិក្សា ដែលនឹងក្លាយជាអតិថិជនស្នូលនៃគណនីប្រាក់បៀវត្សរ៍ (Payroll Account), ប្រាក់បញ្ញើ និងឥណទានរយៈពេលវែង (High Customer Lifetime Value - LTV)។',
              valueEn: 'Captures Gen-Z youth early, cultivating brand loyalty that transitions seamlessly into post-graduation payroll accounts, long-term CASA deposits, and auto/home loans (High LTV).',
              demoScreen: const CampusHubScreen(),
            ),

            // 4.4 Innovation 4: Smart Shared Savings
            _buildInnovationCard(
              number: '04',
              sectionTag: '៤.៤',
              icon: Icons.groups_rounded,
              color: const Color(0xFF0F766E),
              titleKm: 'Smart Shared Savings — គណនីសន្សំរួមគ្នាឌីជីថលតាមគោលដៅ',
              titleEn: 'Smart Shared Savings (Collaborative Goal Vault)',
              problemKm: 'គូស្នេហ៍ (រៀបការ), មិត្តភក្តិ (ដំណើរកម្សាន្ត), ឬដៃគូអាជីវកម្ម (ទុនទិញសម្ភារៈ) ពិបាកតាមដានការសន្សំរួមគ្នា។ ការកត់ត្រាដោយដៃ ឬផ្ញើសារប្រាប់គ្នាងាយបង្កការយល់ច្រឡំ និងខ្វះតម្លាភាព។',
              problemEn: 'Groups (couples saving for weddings, friends funding travel, micro-partners pooling startup capital) struggle with manual tracking, opaque contribution ledgers, and awkward follow-ups.',
              conceptKm: 'បង្កើតមុខងារ Smart Shared Savings Vault ក្នុង App អនុញ្ញាតឱ្យមនុស្សចាប់ពី ២ នាក់ឡើងទៅ បង្កើតគោលដៅសន្សំរួមគ្នា មានតម្លាភាព ១០០% និងមានប្រព័ន្ធអនុម័តដកប្រាក់រួម។',
              conceptEn: 'A digital Smart Shared Savings Vault enabling 2 or more participants to set transparent joint savings milestones with democratic multi-party withdrawal approvals.',
              howKm: '• បង្កើតគោលដៅរួមជាក់ស្តែង៖ ឧទាហរណ៍ មិត្តភក្តិ ៣ នាក់ សន្សំ \$600 សម្រាប់ដំណើរកម្សាន្ត កំណត់ចំនួនប្រាក់ត្រូវដាក់ និងរយៈពេលច្បាស់លាស់។\n'
                     '• Transparent Shared Dashboard៖ បង្ហាញសមតុល្យរួម និង % វឌ្ឍនភាព (ឧ. សន្សំបាន \$300 = 50% សម្រេច) ព្រមទាំងការរួមចំណែករបស់សមាជិកម្នាក់ៗតាម Real-time។\n'
                     '• Social Notifications & Reminders៖ ជូនដំណឹងរាល់ពេលមានសមាជិកដាក់ប្រាក់ និងរំលឹកតាមកាលកំណត់។\n'
                     '• Multi-Party Withdrawal Approval៖ ការដកប្រាក់ត្រូវឆ្លងកាត់ការអនុម័តយល់ព្រមពីសមាជិកដែលមានសិទ្ធិ ដើម្បីការពារផលប្រយោជន៍រួម។',
              howEn: '• Real-world Target Example: 3 friends pooling \$600 for a holiday trip with scheduled member pledges.\n'
                     '• Live Transparent Dashboard: Tracks total balance and milestone progression (e.g. \$300 / \$600 = 50% achieved) with individual member contribution visibility.\n'
                     '• Social Feed & Deposit Alerts: Real-time celebration alerts and automated recurring reminders.\n'
                     '• Multi-Party Authorization: Withdrawals require cryptographic co-sign approval from authorized members, preventing unilateral fund depletion.',
              valueKm: 'បង្កើតឥទ្ធិពល Viral Network Effect ទាក់ទាញអ្នកប្រើប្រាស់បន្តគ្នា, បង្កើនការចូលប្រើប្រាស់ App ជាប្រចាំ (Engagement), និងកៀរគរទំហំប្រាក់បញ្ញើ CASA រយៈពេលវែង។',
              valueEn: 'Triggers viral word-of-mouth user acquisition, fuels habitual daily app interactions, and aggregates "sticky", low-cost retail CASA deposits.',
              demoScreen: const SharedSavingsScreen(),
            ),

            // 4.5 Innovation 5: Daily Auto-Savings
            _buildInnovationCard(
              number: '05',
              sectionTag: '៤.៥',
              icon: Icons.savings_rounded,
              color: const Color(0xFF059669),
              titleKm: 'Daily Auto-Savings — ការសន្សំប្រាក់ខ្នាតតូចប្រចាំថ្ងៃ',
              titleEn: 'Daily Auto-Savings (Micro-Savings & Streaks)',
              problemKm: 'មនុស្សភាគច្រើនចង់សន្សំប្រាក់តែអនុវត្តមិនបានជោគជ័យ ដោយសារភ្លេចសន្សំ, ចាយលុយអស់មុនសន្សំ, គិតថាលុយតិចតួចមិនសំខាន់, ឬពិបាកបើក App ផ្ទេរ \$1-\$2 ដោយដៃរៀងរាល់ថ្ងៃ។',
              problemEn: 'Many aspire to save but fail due to cognitive friction: forgetting daily transfers, spending before saving, or dismissing small amounts as insignificant.',
              conceptKm: 'មុខងារ Daily Auto-Savings កំណត់តែម្តង ប្រព័ន្ធជួយកាត់ប្រាក់ខ្នាតតូចស្វ័យប្រវត្ត (\$1, \$2, ឬ 4,000៛/ថ្ងៃ) ចូលកាតាបសន្សំ ជាមួយប្រព័ន្ធការពារ Smart Balance Guard និងកម្មវិធីលើកទឹកចិត្ត Streaks។',
              conceptEn: 'A frictionless set-and-forget daily micro-deposit mechanism (\$1, \$2, or 4,000 KHR/day) fortified by Smart Balance Guard and rewarding Gamification Streaks.',
              howKm: '• ជម្រើសកញ្ចប់សន្សំងាយៗ៖ \$1/ថ្ងៃ (4,000៛), \$2/ថ្ងៃ (8,000៛), ឬ \$5/ថ្ងៃ ជាមួយសិទ្ធិផ្អាក ឬកែប្រែបានគ្រប់ពេល។\n'
                     '• Smart Balance Guard៖ ប្រសិនបើសមតុល្យក្នុងគណនីចម្បងធ្លាក់ក្រោម \$5 ប្រព័ន្ធផ្អាកការកាត់ប្រាក់សន្សំស្វ័យប្រវត្ត ដើម្បីកុំឱ្យប៉ះពាល់ការចំណាយចាំបាច់ប្រចាំថ្ងៃ។\n'
                     '• Gamification Streaks & Rewards៖ សន្សំបានជាប់លាប់ 30, 60, 90 ថ្ងៃ ទទួលបាន Badges, Chip Mong Rewards Points ឬអត្រាការប្រាក់បន្ថែម។\n'
                     '• ការគណនាផលចំណេញហិរញ្ញវត្ថុជាក់ស្តែង៖\n'
                     '  - សម្រាប់អតិថិជន៖ សន្សំ \$2/ថ្ងៃ x 365 ថ្ងៃ = \$730/ឆ្នាំ (មិនទាន់គិតការប្រាក់)។\n'
                     '  - សម្រាប់ធនាគារ Chip Mong Bank៖ អតិថិជន 100,000 នាក់ x \$1/ថ្ងៃ = \$36.5 លានដុល្លារ/ឆ្នាំ ក្នុងលំហូរប្រាក់បញ្ញើ CASA!',
              howEn: '• Flexible Daily Options: \$1/day (4,000 KHR), \$2/day (8,000 KHR), or \$5/day with instant pause/resume toggles.\n'
                     '• Smart Balance Guard: Safety net that automatically halts daily micro-transfers if the main balance dips below \$5, preventing overdrafts.\n'
                     '• Gamification Streaks: Badges, Chip Mong Rewards points, and bonus interest boosts at 30, 60, and 90-day milestones.\n'
                     '• Compelling Financial Math:\n'
                     '  - For Customers: \$2/day x 365 days = \$730/year principal savings.\n'
                     '  - For Chip Mong Bank: 100,000 active users x \$1/day = \$36.5 Million/year continuous CASA liquidity pool!',
              valueKm: 'បង្កើតទម្លាប់ហិរញ្ញវត្ថុវិជ្ជមានដោយគ្មានសម្ពាធដល់អតិថិជន និងបង្កើតលំហូរប្រាក់បញ្ញើចរន្តចូលធនាគារជារៀងរាល់ថ្ងៃ (Consistent Daily Liquidity) ប្រកបដោយនិរន្តរភាព។',
              valueEn: 'Instills effortless saving habits for customers while anchoring massive, highly predictable recurring retail CASA deposit inflows for the bank.',
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
    required String sectionTag,
    required IconData icon,
    required Color color,
    required String titleKm,
    required String titleEn,
    required String problemKm,
    required String problemEn,
    required String conceptKm,
    required String conceptEn,
    required String howKm,
    required String howEn,
    required String valueKm,
    required String valueEn,
    required Widget demoScreen,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with number, tag, and icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              sectionTag,
                              style: GoogleFonts.roboto(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'INNOVATION $number',
                            style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: color,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _isKhmer ? titleKm : titleEn,
                        style: GoogleFonts.battambang(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                          height: 1.35,
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
                // 1. Problem Addressed
                _buildSectionRow(
                  tag: _isKhmer ? '⚠️ បញ្ហាដែលត្រូវដោះស្រាយ (Problem Addressed)' : '⚠️ Problem Addressed',
                  tagColor: const Color(0xFFDC2626),
                  content: _isKhmer ? problemKm : problemEn,
                  bgColor: const Color(0xFFFEF2F2),
                  borderColor: const Color(0xFFFECACA),
                ),
                const SizedBox(height: 12),

                // 2. Proposed Concept / Solution
                _buildSectionRow(
                  tag: _isKhmer ? '💡 ដំណោះស្រាយស្នើឡើង (Proposed Solution)' : '💡 Proposed Solution',
                  tagColor: const Color(0xFFD97706),
                  content: _isKhmer ? conceptKm : conceptEn,
                  bgColor: const Color(0xFFFFFBEB),
                  borderColor: const Color(0xFFFDE68A),
                ),
                const SizedBox(height: 12),

                // 3. How it works & Technology
                _buildSectionRow(
                  tag: _isKhmer ? '⚙️ របៀបដំណើរការ & បច្ចេកវិទ្យា (How it Works & Tech)' : '⚙️ How it Works & Tech Architecture',
                  tagColor: const Color(0xFF2563EB),
                  content: _isKhmer ? howKm : howEn,
                  bgColor: const Color(0xFFEFF6FF),
                  borderColor: const Color(0xFFBFDBFE),
                ),
                const SizedBox(height: 12),

                // 4. Strategic Value to Bank & KPIs
                _buildSectionRow(
                  tag: _isKhmer ? '📈 តម្លៃជាយុទ្ធសាស្ត្រ & KPIs (Strategic Value to Bank)' : '📈 Strategic Value to Bank & KPIs',
                  tagColor: const Color(0xFF0FA958),
                  content: _isKhmer ? valueKm : valueEn,
                  bgColor: const Color(0xFFF0FDF4),
                  borderColor: const Color(0xFFBBF7D0),
                ),
                const SizedBox(height: 16),

                // Interactive Demo Button
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 1.5,
                    ),
                    icon: const Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 20),
                    label: Text(
                      _isKhmer ? 'សាកល្បងមុខងារផ្ទាល់ (Launch Interactive Demo)' : 'Launch Interactive Demo',
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
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 14,
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  tag,
                  style: GoogleFonts.battambang(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: tagColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: GoogleFonts.battambang(
              fontSize: 12,
              color: const Color(0xFF1F2937),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
