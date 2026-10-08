import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. Bakong Template Creation Screen
// ─────────────────────────────────────────────────────────────────────────────
class CreateBakongTemplateScreen extends StatefulWidget {
  const CreateBakongTemplateScreen({super.key});

  @override
  State<CreateBakongTemplateScreen> createState() =>
      _CreateBakongTemplateScreenState();
}

class _CreateBakongTemplateScreenState
    extends State<CreateBakongTemplateScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool get _canProceed =>
      _accountController.text.trim().isNotEmpty &&
      _nameController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _accountController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF085329),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Green Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'ផ្ទេរប្រាក់ទៅគណនីបាគង',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE52329),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.brightness_7,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Form Body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  child: Column(
                    children: [
                      _buildFormField(
                        controller: _accountController,
                        hint: 'លេខគណនីបាគង',
                        onChanged: () => setState(() {}),
                      ),
                      const SizedBox(height: 14),
                      _buildFormField(
                        controller: _nameController,
                        hint: 'ឈ្មោះគំរូទូទាត់',
                        onChanged: () => setState(() {}),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF2F4F7),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _canProceed ? () => Navigator.of(context).pop() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0FA958),
              disabledBackgroundColor: const Color(0xFFD1D5DB),
              foregroundColor: Colors.white,
              disabledForegroundColor: const Color(0xFF9CA3AF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'បង្កើត',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String hint,
    required VoidCallback onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        onChanged: (_) => onChanged(),
        style: GoogleFonts.battambang(
          fontSize: 14.5,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.battambang(
            color: const Color(0xFF6B7280),
            fontSize: 14.5,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. SWIFT International Template Creation Screen
// ─────────────────────────────────────────────────────────────────────────────
class CreateSwiftTemplateScreen extends StatefulWidget {
  const CreateSwiftTemplateScreen({super.key});

  @override
  State<CreateSwiftTemplateScreen> createState() =>
      _CreateSwiftTemplateScreenState();
}

class _CreateSwiftTemplateScreenState
    extends State<CreateSwiftTemplateScreen> {
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _recipientAccount = TextEditingController();
  final TextEditingController _recipientAddress = TextEditingController();
  final TextEditingController _swiftCode = TextEditingController();
  final TextEditingController _templateName = TextEditingController();
  String? _selectedCurrency;

  @override
  void dispose() {
    _recipientName.dispose();
    _recipientAccount.dispose();
    _recipientAddress.dispose();
    _swiftCode.dispose();
    _templateName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF085329),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Green Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'ផ្ទេរប្រាក់ក្រៅប្រទេសតាមរយៈ\nប្រព័ន្ធ SWIFT',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0072CE),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'SWIFT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Form Body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  child: Column(
                    children: [
                      _buildInputCard(
                        controller: _recipientName,
                        hint: 'ឈ្មោះអ្នកទទួល',
                      ),
                      const SizedBox(height: 12),
                      _buildInputCard(
                        controller: _recipientAccount,
                        hint: 'លេខគណនីអ្នកទទួល',
                      ),
                      const SizedBox(height: 12),
                      _buildInputCard(
                        controller: _recipientAddress,
                        hint: 'អាសយដ្ឋានអ្នកទទួល',
                      ),
                      const SizedBox(height: 12),
                      _buildInputCard(
                        controller: _swiftCode,
                        hint: 'លេខកូដ SWIFT ធនាគារទទួល',
                      ),
                      const SizedBox(height: 12),
                      _buildCurrencyDropdown(),
                      const SizedBox(height: 12),
                      _buildInputCard(
                        controller: _templateName,
                        hint: 'ឈ្មោះគំរូទូទាត់',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF2F4F7),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0FA958),
              disabledBackgroundColor: const Color(0xFFD1D5DB),
              disabledForegroundColor: const Color(0xFF9CA3AF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'បង្កើត',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        style: GoogleFonts.battambang(
          fontSize: 14.5,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.battambang(
            color: const Color(0xFF6B7280),
            fontSize: 14.5,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedCurrency,
          hint: Text(
            'ជ្រើសរើសរូបិយប័ណ្ណ',
            style: GoogleFonts.battambang(
              color: const Color(0xFF6B7280),
              fontSize: 14.5,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
          items: const [
            DropdownMenuItem(value: 'USD', child: Text('USD - US Dollar')),
            DropdownMenuItem(value: 'KHR', child: Text('KHR - Khmer Riel')),
            DropdownMenuItem(value: 'EUR', child: Text('EUR - Euro')),
            DropdownMenuItem(value: 'THB', child: Text('THB - Thai Baht')),
          ],
          onChanged: (val) => setState(() => _selectedCurrency = val),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Chip Mong Transfer Template Creation Screen
// ─────────────────────────────────────────────────────────────────────────────
class CreateChipMongTemplateScreen extends StatefulWidget {
  const CreateChipMongTemplateScreen({super.key});

  @override
  State<CreateChipMongTemplateScreen> createState() =>
      _CreateChipMongTemplateScreenState();
}

class _CreateChipMongTemplateScreenState
    extends State<CreateChipMongTemplateScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _templateName = TextEditingController();

  bool get _canProceed =>
      _accountController.text.trim().isNotEmpty &&
      _templateName.text.trim().isNotEmpty;

  @override
  void dispose() {
    _accountController.dispose();
    _templateName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF085329),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Green Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'ផ្ទេរប្រាក់ទៅគណនី ជីប\nម៉ុង ណាមួយ',
                          style: GoogleFonts.battambang(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5AB64A),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.swap_horiz_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Form Body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  child: Column(
                    children: [
                      _buildFormField(
                        controller: _accountController,
                        hint: 'ទៅគណនី',
                        onChanged: () => setState(() {}),
                      ),
                      const SizedBox(height: 14),
                      _buildFormField(
                        controller: _templateName,
                        hint: 'ឈ្មោះគំរូទូទាត់',
                        onChanged: () => setState(() {}),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF2F4F7),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _canProceed ? () => Navigator.of(context).pop() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0FA958),
              disabledBackgroundColor: const Color(0xFFD1D5DB),
              disabledForegroundColor: const Color(0xFF9CA3AF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'បង្កើត',
              style: GoogleFonts.battambang(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String hint,
    required VoidCallback onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        onChanged: (_) => onChanged(),
        style: GoogleFonts.battambang(
          fontSize: 14.5,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.battambang(
            color: const Color(0xFF6B7280),
            fontSize: 14.5,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
