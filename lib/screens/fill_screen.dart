import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'success_screen.dart';

class FillScreen extends StatefulWidget {
  const FillScreen({super.key});

  @override
  State<FillScreen> createState() => _FillScreenState();
}

class _FillScreenState extends State<FillScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _accountFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {

    super.initState();
    _accountController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _accountController.dispose();
    _phoneController.dispose();
    _accountFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  bool get _canProceed =>
      _accountController.text.isNotEmpty && _phoneController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2ED),
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildFormCard(),
                  const SizedBox(height: 16),
                  _buildProceedButton(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────
  Widget _buildAppBar() {
    return Container(
      color: const Color(0xFF1A6B3C),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Spacer(),
              Text(
                'ត្រូវការជំនួយ?',
                style: GoogleFonts.battambang(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Form Card ────────────────────────────────────────────
  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFB8D9C5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                color: Color(0xFF1A6B3C),
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            'ចូលទៅការគណនីរបស់អ្នក',
            style: GoogleFonts.battambang(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),

          // Subtitle
          Text(
            'សូមបញ្ចូលលេខគណនី និងលេខទូរស័ព្ទរបស់អ្នកដើម្បីចូលទៅកាន់កម្មវិធីទូរស័ព្ទ Chip Mong Bank App',
            style: GoogleFonts.battambang(
              fontSize: 20,
              color: const Color.fromARGB(255, 101, 100, 100),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // Account Number Field
          _buildInputField(
            hint: 'លេខគណនី',
            controller: _accountController,
            focusNode: _accountFocus,
            nextFocus: _phoneFocus,
            maxLength: 20,
          ),
          const SizedBox(height: 14),

          // Phone Number Field
          _buildInputField(
            hint: 'លេខទូរស័ព្ទ',
            controller: _phoneController,
            focusNode: _phoneFocus,
            maxLength: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocus,
    required int maxLength,
  }) {
    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, _) {
        final isFocused = focusNode.hasFocus;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFocused ? const Color(0xFF1A6B3C) : Colors.grey.shade300,
              width: isFocused ? 2 : 1.2,
            ),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLength: maxLength,
            keyboardType: TextInputType.numberWithOptions(
              signed: false,
              decimal: false,
            ),
            textInputAction: nextFocus != null
                ? TextInputAction.next
                : TextInputAction.done,
            onSubmitted: (_) {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                focusNode.unfocus();
              }
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.battambang(
                fontSize: 15,
                color: Colors.grey.shade400,
              ),
              labelText: hint,
              labelStyle: GoogleFonts.battambang(
                fontSize: 15,
                color: const Color.fromARGB(255, 101, 100, 100),
                fontWeight: FontWeight.w500,
              ),
              floatingLabelStyle: GoogleFonts.battambang(
                fontSize: 13,
                color: const Color(0xFF1A6B3C),
                fontWeight: FontWeight.w500,
              ),
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }

  // ── Proceed Button ───────────────────────────────────────
  Widget _buildProceedButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF1A6B3C),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SuccessScreen(
                    userName: 'MENG THETH',
                    accountLabel: 'គណនីប្រាក់រៀលបស់អ្នក',
                    accountNumber: '1016 3840',
                    buttonLabel: 'ទំព័រដើម',
                    successLabel: 'អបអរសាទរ!',
                  ),
                ),
              );
            },
            child: Center(
              child: Text(
                'បន្ត',
                style: GoogleFonts.battambang(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
