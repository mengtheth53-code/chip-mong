import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/transaction_receipt_sheet.dart';

class PpwsaPaymentScreen extends StatefulWidget {
  const PpwsaPaymentScreen({super.key});

  @override
  State<PpwsaPaymentScreen> createState() => _PpwsaPaymentScreenState();
}

class _PpwsaPaymentScreenState extends State<PpwsaPaymentScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _waterBlue = Color(0xFF0284C7);
  static const Color _bgGray = Color(0xFFF2F4F7);

  final TextEditingController _consumerCodeController =
      TextEditingController(text: '012938475');
  final TextEditingController _invoiceController = TextEditingController();

  bool _isQueried = false;
  bool _isLoading = false;
  final String _selectedAccount = 'KHR Account (•• 1289) - ៛ 2,850,000';

  @override
  void dispose() {
    _consumerCodeController.dispose();
    _invoiceController.dispose();
    super.dispose();
  }

  void _queryWaterBill() {
    if (_consumerCodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'សូមបញ្ចូលលេខអតិថិជនរដ្ឋាករទឹក (Consumer Code)',
            style: GoogleFonts.battambang(),
          ),
          backgroundColor: Colors.orange.shade800,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isQueried = true;
      });
    });
  }

  void _payBill() {
    showTransactionReceiptSheet(
      context,
      title: 'ទូទាត់ជោគជ័យ!',
      subtitle: 'ការទូទាត់វិក្កយបត្ររដ្ឋាករទឹកស្វយ័តក្រុងភ្នំពេញបានជោគជ័យ',
      amount: '៛ 68,500',
      date: '18 តុលា 2026, 17:42',
      isIncome: false,
      referenceId: 'PPWSA-TXN-491028',
      fromAccount: _selectedAccount,
      toAccount: 'រដ្ឋាករទឹកស្វយ័តក្រុងភ្នំពេញ (PPWSA)',
      remark: 'លេខអតិថិជន: ${_consumerCodeController.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    ),
                  ),
                  Text(
                    'រដ្ឋាករទឹកស្វយ័តក្រុងភ្នំពេញ',
                    style: GoogleFonts.battambang(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // PPWSA Water Header Banner
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.water_drop_rounded, color: _waterBlue, size: 32),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PPWSA Water Supply',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ទូទាត់វិក្កយបត្រប្រើប្រាស់ទឹកស្អាតរហ័ស និងឥតគិតថ្លៃសេវា',
                          style: GoogleFonts.battambang(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // White Content Body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bgGray,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Input Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
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
                          Text(
                            'លេខសម្គាល់អតិថិជន (Consumer Number)',
                            style: GoogleFonts.battambang(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _consumerCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'បញ្ចូលលេខអតិថិជន ៩ ខ្ទង់',
                              hintStyle: GoogleFonts.battambang(color: Colors.grey.shade400, fontSize: 13),
                              prefixIcon: const Icon(Icons.pin, color: _waterBlue),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.qr_code_scanner, color: _waterBlue),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('បានស្កេន Barcode វិក្កយបត្រជោគជ័យ', style: GoogleFonts.battambang()),
                                      backgroundColor: _darkGreen,
                                    ),
                                  );
                                },
                              ),
                              filled: true,
                              fillColor: _bgGray,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 14),

                          Text(
                            'លេខវិក្កយបត្រ (Invoice No. - ស្រេចចិត្ត)',
                            style: GoogleFonts.battambang(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _invoiceController,
                            decoration: InputDecoration(
                              hintText: 'បញ្ចូលលេខវិក្កយបត្រ',
                              hintStyle: GoogleFonts.battambang(color: Colors.grey.shade400, fontSize: 13),
                              prefixIcon: const Icon(Icons.receipt_long, color: Colors.grey),
                              filled: true,
                              fillColor: _bgGray,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Search Bill Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _queryWaterBill,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _waterBlue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                    )
                                  : Text(
                                      'ពិនិត្យវិក្កយបត្រទឹកស្អាត',
                                      style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Bill Result Card
                    if (_isQueried) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _waterBlue.withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _waterBlue.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'វិក្កយបត្រមិនទាន់បង់',
                                    style: GoogleFonts.battambang(
                                      color: _waterBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'កាលកំណត់: 28 តុលា 2026',
                                  style: GoogleFonts.battambang(fontSize: 11.5, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _buildInfoRow('ឈ្មោះអតិថិជន:', 'ម៉េង ថេត (MENG THETH)'),
                            _buildInfoRow('ទីតាំង:', 'ខណ្ឌទួលគោក, រាជធានីភ្នំពេញ'),
                            _buildInfoRow('អំណានកុងទ័រចាស់:', '1,240 m³'),
                            _buildInfoRow('អំណានកុងទ័រថ្មី:', '1,272 m³'),
                            _buildInfoRow('បរិមាណទឹកប្រើប្រាស់:', '32 m³'),
                            const Divider(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ទឹកប្រាក់សរុប:',
                                  style: GoogleFonts.battambang(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E1E1E),
                                  ),
                                ),
                                Text(
                                  '៛ 68,500',
                                  style: GoogleFonts.roboto(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: _waterBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            Text(
                              'គណនីទូទាត់ (Source Account)',
                              style: GoogleFonts.battambang(fontSize: 12, color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: _bgGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.account_balance_wallet, color: _darkGreen, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _selectedAccount,
                                      style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _payBill,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _darkGreen,
                                  foregroundColor: Colors.white,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check_circle_outline, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'បង់ប្រាក់ឥឡូវនេះ (៛ 68,500)',
                                      style: GoogleFonts.battambang(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.battambang(fontSize: 12.5, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: GoogleFonts.battambang(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }
}
