import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SharedSavingsScreen extends StatefulWidget {
  const SharedSavingsScreen({super.key});

  @override
  State<SharedSavingsScreen> createState() => _SharedSavingsScreenState();
}

class _SharedSavingsScreenState extends State<SharedSavingsScreen> {
  final List<Map<String, dynamic>> _goals = [
    {
      'id': 'g1',
      'title': 'ដំណើរកម្សាន្តមិត្តភក្តិ ៣ នាក់ (Trip Fund)',
      'target': 600.0,
      'current': 300.0,
      'category': 'Travel',
      'deadline': '30 វិច្ឆិកា 2026',
      'icon': Icons.flight_takeoff_rounded,
      'color': const Color(0xFF0FA958),
      'pendingWithdrawal': 150.0,
      'withdrawalReason': 'កក់បន្ទប់សណ្ឋាគារ & សំបុត្រធ្វើដំណើរ',
      'members': [
        {
          'name': 'Meng Theth (អ្នកផ្តួចផ្តើម)',
          'amount': 100.0,
          'avatar': 'assets/images/profile.jpg',
          'approved': true,
          'role': 'Admin',
        },
        {
          'name': 'Bun Phanit',
          'amount': 100.0,
          'avatar': '',
          'approved': true,
          'role': 'Member',
        },
        {
          'name': 'Sokha',
          'amount': 100.0,
          'avatar': '',
          'approved': false,
          'role': 'Member',
        },
      ],
      'recentActivities': [
        'Bun Phanit បានដាក់ប្រាក់ \$50 (2 ម៉ោងមុន)',
        'Sokha បានដាក់ប្រាក់ \$50 (ម្សិលមិញ)',
        'Meng Theth បានដាក់ប្រាក់ \$100 (3 ថ្ងៃមុន)',
      ],
    },
    {
      'id': 'g2',
      'title': 'លុយរៀបការ (Wedding Fund)',
      'target': 10000.0,
      'current': 4200.0,
      'category': 'Family',
      'deadline': '14 កុម្ភៈ 2027',
      'icon': Icons.favorite_rounded,
      'color': const Color(0xFFEC4899),
      'pendingWithdrawal': 0.0,
      'withdrawalReason': '',
      'members': [
        {'name': 'Meng Theth', 'amount': 2500.0, 'avatar': 'assets/images/profile.jpg', 'approved': true, 'role': 'Admin'},
        {'name': 'Sreynich', 'amount': 1700.0, 'avatar': '', 'approved': true, 'role': 'Member'},
      ],
      'recentActivities': [
        'Meng Theth បានដាក់ប្រាក់ \$200 (ម្សិលមិញ)',
        'Sreynich បានដាក់ប្រាក់ \$150 (4 ថ្ងៃមុន)',
      ],
    },
    {
      'id': 'g3',
      'title': 'ទុនអាជីវកម្មខ្នាតតូច (Startup Fund)',
      'target': 3000.0,
      'current': 1500.0,
      'category': 'Business',
      'deadline': '31 ធ្នូ 2026',
      'icon': Icons.rocket_launch_rounded,
      'color': const Color(0xFF3B82F6),
      'pendingWithdrawal': 0.0,
      'withdrawalReason': '',
      'members': [
        {'name': 'Meng Theth', 'amount': 800.0, 'avatar': 'assets/images/profile.jpg', 'approved': true, 'role': 'Admin'},
        {'name': 'Dara', 'amount': 400.0, 'avatar': '', 'approved': true, 'role': 'Member'},
        {'name': 'Vichea', 'amount': 300.0, 'avatar': '', 'approved': true, 'role': 'Member'},
      ],
      'recentActivities': [
        'Dara បានដាក់ប្រាក់ \$100 (សប្តាហ៍មុន)',
        'Vichea បានដាក់ប្រាក់ \$100 (សប្តាហ៍មុន)',
      ],
    },
  ];

  void _showCreateGoalSheet() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'បង្កើតគោលដៅសន្សំរួមគ្នាថ្មី',
                style: GoogleFonts.battambang(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'ឈ្មោះគោលដៅ (ឧ. ដំណើរកម្សាន្ត)',
                  labelStyle: GoogleFonts.battambang(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ទំហំទឹកប្រាក់គោលដៅ (USD)',
                  labelStyle: GoogleFonts.battambang(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'អញ្ជើញសមាជិក (លេខទូរស័ព្ទ)',
                  labelStyle: GoogleFonts.battambang(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0FA958),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    final title = titleController.text.trim();
                    final amount = double.tryParse(amountController.text) ?? 500;
                    if (title.isNotEmpty) {
                      setState(() {
                        _goals.insert(0, {
                          'title': title,
                          'target': amount,
                          'current': 50.0,
                          'category': 'General',
                          'deadline': '31 ធ្នូ 2026',
                          'icon': Icons.savings_rounded,
                          'color': const Color(0xFF10B981),
                          'members': [
                            {'name': 'Meng Theth (អ្នកបង្កើត)', 'amount': 50.0, 'avatar': 'assets/images/profile.jpg'},
                          ],
                        });
                      });
                    }
                    Navigator.of(ctx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('គោលដៅសន្សំរួមគ្នាត្រូវបានបង្កើត!', style: GoogleFonts.battambang())),
                    );
                  },
                  child: Text(
                    'បង្កើតគោលដៅ',
                    style: GoogleFonts.battambang(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDepositSheet(Map<String, dynamic> goal) {
    double depositAmount = 50.0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          padding: const EdgeInsets.all(22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ដាក់ប្រាក់ចូល «${goal['title']}»',
                style: GoogleFonts.battambang(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'ជ្រើសរើសទឹកប្រាក់ដែលចង់ដាក់ចូល៖',
                style: GoogleFonts.battambang(fontSize: 13, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 10),
              Row(
                children: [10.0, 20.0, 50.0, 100.0].map((amt) {
                  final isSelected = depositAmount == amt;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setModalState(() => depositAmount = amt),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF0FA958) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '\$${amt.toInt()}',
                            style: GoogleFonts.roboto(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0FA958),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    setState(() {
                      goal['current'] = (goal['current'] as double) + depositAmount;
                      final members = goal['members'] as List<dynamic>;
                      members[0]['amount'] = (members[0]['amount'] as double) + depositAmount;
                    });
                    Navigator.of(ctx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF0FA958),
                        content: Text('បានដាក់ប្រាក់ \$${depositAmount.toInt()} ចូលគោលដៅជោគជ័យ!', style: GoogleFonts.battambang()),
                      ),
                    );
                  },
                  child: Text(
                    'បញ្ជាក់ការដាក់ប្រាក់ (\$${depositAmount.toInt()})',
                    style: GoogleFonts.battambang(fontSize: 14.5, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMultiPartyApprovalSheet(Map<String, dynamic> goal) {
    final members = (goal['members'] as List<dynamic>).cast<Map<String, dynamic>>();
    final totalMembers = members.length;
    final hasPendingWithdrawal = (goal['pendingWithdrawal'] as double) > 0;
    final withdrawalAmount = (goal['pendingWithdrawal'] as double);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          final currentApprovedCount = members.where((m) => m['approved'] == true).length;
          final allApproved = currentApprovedCount == totalMembers;

          return Container(
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0FA958).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.shield_rounded, color: Color(0xFF0FA958), size: 22),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Multi-Party Withdrawal Approval',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'ប្រព័ន្ធអនុម័តដកប្រាក់រួមគ្នា',
                              style: GoogleFonts.battambang(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Rule explanation banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF86EFAC)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_user_rounded, color: Color(0xFF16A34A), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'ការពារមូលនិធិក្រុម៖ គ្មានបុគ្គលណាម្នាក់អាចដកប្រាក់បានដោយឯកតោភាគីឡើយ។ តម្រូវឱ្យមានការយល់ព្រមពីសមាជិកទាំង $totalMembers នាក់។',
                          style: GoogleFonts.battambang(
                            fontSize: 11.5,
                            color: const Color(0xFF166534),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Pending Withdrawal Info
                if (hasPendingWithdrawal) ...[
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFBBF24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'សំណើដកប្រាក់ដែលកំពុងរង់ចាំ',
                              style: GoogleFonts.battambang(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF92400E),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF59E0B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '\$$withdrawalAmount',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'គោលបំណង៖ ${goal['withdrawalReason']}',
                          style: GoogleFonts.battambang(fontSize: 12, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ស្ថានភាព៖ $currentApprovedCount / $totalMembers នាក់បានយល់ព្រម ${allApproved ? '(គ្រប់ចំនួន)' : '(ខ្វះ ${totalMembers - currentApprovedCount} សំឡេង)'}',
                          style: GoogleFonts.battambang(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: allApproved ? const Color(0xFF16A34A) : const Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Members Approval Status List
                Text(
                  'ស្ថានភាពការយល់ព្រមរបស់សមាជិក (Signatures)៖',
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                ...members.map((mem) {
                  final isApproved = mem['approved'] == true;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isApproved ? const Color(0xFF86EFAC) : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: isApproved ? const Color(0xFFDCFCE7) : Colors.grey.shade200,
                          child: Icon(
                            isApproved ? Icons.check_circle_rounded : Icons.pending_rounded,
                            color: isApproved ? const Color(0xFF16A34A) : Colors.grey.shade600,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mem['name'] as String,
                                style: GoogleFonts.battambang(fontSize: 12.5, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'បានដាក់ប្រាក់ \$${(mem['amount'] as double).toStringAsFixed(0)}',
                                style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isApproved ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isApproved ? 'បានយល់ព្រម' : 'រង់ចាំការយល់ព្រម',
                            style: GoogleFonts.battambang(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isApproved ? const Color(0xFF15803D) : const Color(0xFFB45309),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 18),

                // Simulated Member Approval Action
                if (hasPendingWithdrawal && !allApproved) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0FA958),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        setState(() {
                          final pendingMember = members.firstWhere((m) => m['approved'] == false, orElse: () => members[0]);
                          pendingMember['approved'] = true;
                          final newApprovedCount = members.where((m) => m['approved'] == true).length;
                          if (newApprovedCount == totalMembers) {
                            goal['current'] = ((goal['current'] as double) - withdrawalAmount).clamp(0.0, double.infinity);
                            goal['pendingWithdrawal'] = 0.0;
                            (goal['recentActivities'] as List<dynamic>).insert(0, 'បានដកប្រាក់ \$${withdrawalAmount.toInt()} ជោគជ័យ (សមាជិកទាំងអស់យល់ព្រម)');
                          }
                        });
                        setSheetState(() {});
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFF0FA958),
                            content: Text(
                              'Sokha បានយល់ព្រម! សមាជិកទាំង 3 នាក់បានអនុម័តដកប្រាក់ \$${withdrawalAmount.toInt()} ដោយជោគជ័យ!',
                              style: GoogleFonts.battambang(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'អនុម័តការដកប្រាក់ជា Sokha (Simulate Approval)',
                        style: GoogleFonts.battambang(fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ] else if (allApproved || !hasPendingWithdrawal) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF0FA958)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        setState(() {
                          goal['pendingWithdrawal'] = 100.0;
                          goal['withdrawalReason'] = 'ទិញសម្ភាររួមគ្នា';
                          for (var i = 1; i < members.length; i++) {
                            members[i]['approved'] = false;
                          }
                        });
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFF0FA958),
                            content: Text('បានផ្ញើសំណើដកប្រាក់ \$100 ទៅកាន់សមាជិកទាំងអស់!', style: GoogleFonts.battambang()),
                          ),
                        );
                      },
                      child: Text(
                        '+ បង្កើតសំណើដកប្រាក់ថ្មី (\$100)',
                        style: GoogleFonts.battambang(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0FA958),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalShared = _goals.fold(0.0, (sum, item) => sum + (item['current'] as double));

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
                const Icon(Icons.groups_rounded, color: Color(0xFF6EE7B7), size: 20),
                const SizedBox(width: 8),
                Text(
                  'គណនីសន្សំរួមគ្នាឆ្លាតវៃ',
                  style: GoogleFonts.battambang(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Smart Shared Savings (Group Goals)',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F766E).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ប្រាក់សន្សំរួមគ្នាសរុប (Total Pooled)',
                    style: GoogleFonts.battambang(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${totalShared.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_goals.length} គោលដៅសកម្ម',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• គ្មានឯកសារស្មុគស្មាញនៅសាខា',
                        style: GoogleFonts.battambang(color: Colors.white70, fontSize: 11.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Section Header + Create Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'គោលដៅសន្សំរួមគ្នារបស់អ្នក',
                  style: GoogleFonts.battambang(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: _showCreateGoalSheet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0FA958),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'បង្កើតគោលដៅ',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Goals List
            ..._goals.map((goal) => _buildGoalCard(goal)),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(Map<String, dynamic> goal) {
    final target = goal['target'] as double;
    final current = goal['current'] as double;
    final progress = (current / target).clamp(0.0, 1.0);
    final percentage = (progress * 100).toInt();
    final color = goal['color'] as Color;
    final members = goal['members'] as List<dynamic>;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(goal['icon'] as IconData, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal['title'] as String,
                      style: GoogleFonts.battambang(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'កាលបរិច្ឆេទ៖ ${goal['deadline']}',
                      style: GoogleFonts.battambang(
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$percentage%',
                  style: GoogleFonts.roboto(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 8),

          // Amounts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'សន្សំបាន \$${current.toStringAsFixed(0)}',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: color,
                ),
              ),
              Text(
                'គោលដៅ \$${target.toStringAsFixed(0)}',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const Divider(height: 20),

          // Members Contribution Breakdown
          Text(
            'សមាជិកចូលរួម (${members.length} នាក់)៖',
            style: GoogleFonts.battambang(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          ...members.map((mem) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey.shade300,
                    child: Text(
                      (mem['name'] as String).substring(0, 1),
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      mem['name'] as String,
                      style: GoogleFonts.battambang(fontSize: 12, color: Colors.black87),
                    ),
                  ),
                  Text(
                    '\$${(mem['amount'] as double).toStringAsFixed(0)}',
                    style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0FA958)),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),

          const Divider(height: 18),

          // Multi-Party Security Badge
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, color: Color(0xFF0FA958), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Multi-Party Approval Protected',
                        style: GoogleFonts.roboto(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'ដកប្រាក់បានលុះត្រាតែមានការយល់ព្រមពីសមាជិកទាំងអស់',
                        style: GoogleFonts.battambang(
                          fontSize: 10.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                if ((goal['pendingWithdrawal'] as double) > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'មានសំណើដកប្រាក់',
                      style: GoogleFonts.battambang(
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Action Buttons: Deposit & Withdrawal Approval
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => _showDepositSheet(goal),
                    child: Text(
                      '+ ដាក់ប្រាក់',
                      style: GoogleFonts.battambang(fontSize: 12.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0F766E),
                      side: const BorderSide(color: Color(0xFF0F766E)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => _showMultiPartyApprovalSheet(goal),
                    child: Text(
                      '🛡️ ដកប្រាក់រួមគ្នា',
                      style: GoogleFonts.battambang(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Recent Activities Feed (if present)
          if (goal['recentActivities'] != null && (goal['recentActivities'] as List).isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history_rounded, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'សកម្មភាពថ្មីៗ (Recent Activity)',
                        style: GoogleFonts.battambang(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ...(goal['recentActivities'] as List<dynamic>).take(2).map((act) => Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '• $act',
                          style: GoogleFonts.battambang(fontSize: 10.5, color: Colors.grey.shade600),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
