import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showTransactionReceiptSheet(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String amount,
  required String date,
  required bool isIncome,
  String? referenceId,
  String? fromAccount,
  String? toAccount,
  String? remark,
}) {
  const primaryGreen = Color(0xFF0FA958);
  const darkGreen = Color(0xFF085329);

  final ref = referenceId ?? 'CMB20260805148029';
  final fromAcc = fromAccount ?? 'THETH MENG (••• 3840)';
  final toAcc = toAccount ?? title;
  final rmk = remark ?? 'ការទូទាត់ប្រាក់ទំនិញ ឬសេវាកម្ម';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 18),

            // Success Circle
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: primaryGreen,
                size: 36,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'ប្រតិបត្តិការជោគជ័យ',
              style: GoogleFonts.battambang(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              amount,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: isIncome ? primaryGreen : Colors.black87,
              ),
            ),
            const SizedBox(height: 18),

            // Divider dashed line
            Row(
              children: List.generate(
                30,
                (i) => Expanded(
                  child: Container(
                    height: 1,
                    color: i.isEven ? Colors.grey.shade300 : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Receipt details table
            _buildReceiptRow('កាលបរិច្ឆេទ', date),
            _buildReceiptRow('លេខយោងប្រតិបត្តិការ', ref),
            _buildReceiptRow('ពីគណនី', fromAcc),
            _buildReceiptRow('ទៅកាន់', toAcc),
            _buildReceiptRow('ថ្លៃសេវា', 'ឥតគិតថ្លៃ (0.00 USD)'),
            _buildReceiptRow('សម្គាល់', rmk),

            const SizedBox(height: 20),

            // Actions: Share & Download
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'វិក្កយបត្រត្រូវបានរក្សាទុកក្នុងរូបថត',
                            style: GoogleFonts.battambang(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, color: primaryGreen),
                    label: Text(
                      'ទាញយក',
                      style: GoogleFonts.battambang(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryGreen),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'ចែករំលែកវិក្កយបត្រជោគជ័យ',
                            style: GoogleFonts.battambang(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.share_rounded, color: Colors.white),
                    label: Text(
                      'ចែករំលែក',
                      style: GoogleFonts.battambang(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildReceiptRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.battambang(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.battambang(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}
