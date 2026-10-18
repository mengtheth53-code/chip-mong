import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EkycScannerScreen extends StatefulWidget {
  const EkycScannerScreen({super.key});

  @override
  State<EkycScannerScreen> createState() => _EkycScannerScreenState();
}

class _EkycScannerScreenState extends State<EkycScannerScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  // 0: NID Front, 1: NID Back, 2: Face Liveness, 3: OCR Review & Complete
  int _currentStep = 0;
  bool _isProcessing = false;
  bool _isTorchOn = false;
  String _livenessInstruction = 'សូមសម្លឹងត្រង់ទៅកាន់កាមេរ៉ា...';

  void _captureNext() {
    setState(() => _isProcessing = true);

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        if (_currentStep < 3) {
          _currentStep++;
          if (_currentStep == 2) {
            _startLivenessSimulation();
          }
        }
      });
    });
  }

  void _startLivenessSimulation() {
    _livenessInstruction = 'សូមសម្លឹងត្រង់ទៅកាន់កាមេរ៉ា...';
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted || _currentStep != 2) return;
      setState(() => _livenessInstruction = 'សូមព្រិចភ្នែកយឺតៗ (Blink slowly)...');
    });

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted || _currentStep != 2) return;
      setState(() => _livenessInstruction = 'សូមញញឹមបន្តិច (Smile)...');
    });

    Future.delayed(const Duration(milliseconds: 3400), () {
      if (!mounted || _currentStep != 2) return;
      setState(() {
        _currentStep = 3; // Move to OCR confirmation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildStepIndicator(),
            Expanded(
              child: _currentStep == 3
                  ? _buildOcrResultView()
                  : _buildCameraScannerView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.white, size: 26),
          ),
          Text(
            _currentStep == 0
                ? 'ស្កេនខាងមុខអត្តសញ្ញាណប័ណ្ណ'
                : (_currentStep == 1
                    ? 'ស្កេនខាងក្រោយអត្តសញ្ញាណប័ណ្ណ'
                    : (_currentStep == 2
                        ? 'ផ្ទៀងផ្ទាត់ផ្ទៃមុខ (Face Liveness)'
                        : 'ផ្ទៀងផ្ទាត់ទិន្នន័យ eKYC')),
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _isTorchOn = !_isTorchOn),
            icon: Icon(
              _isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: _isTorchOn ? Colors.yellow : Colors.white70,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        children: List.generate(4, (index) {
          final isCompleted = _currentStep > index;
          final isCurrent = _currentStep == index;
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: isCompleted
                    ? _green
                    : (isCurrent ? Colors.white : Colors.white24),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCameraScannerView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Camera View Simulation Background
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFF141923),
          child: Opacity(
            opacity: 0.15,
            child: GridPaper(
              color: _green,
              divisions: 2,
              subdivisions: 1,
            ),
          ),
        ),

        // Scanner Frame Overlay
        if (_currentStep == 0 || _currentStep == 1)
          _buildIdCardFrame()
        else if (_currentStep == 2)
          _buildFaceOvalFrame(),

        // Bottom Controls
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                _currentStep == 0
                    ? 'សូមដាក់អត្តសញ្ញាណប័ណ្ណសញ្ជាតិខ្មែរខាងមុខក្នុងស៊ុម'
                    : (_currentStep == 1
                        ? 'សូមត្រឡប់ទៅខាងក្រោយអត្តសញ្ញាណប័ណ្ណ'
                        : _livenessInstruction),
                style: GoogleFonts.battambang(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    const Shadow(color: Colors.black, blurRadius: 6),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Capture Button for NID
              if (_currentStep < 2)
                GestureDetector(
                  onTap: _isProcessing ? null : _captureNext,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isProcessing ? Colors.grey : _green,
                        shape: BoxShape.circle,
                      ),
                      child: _isProcessing
                          ? const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              ),
                            )
                          : const Icon(Icons.camera_alt, color: Colors.white, size: 28),
                    ),
                  ),
                )
              else if (_currentStep == 2)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _green.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: _green,
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'កំពុងវិភាគ Liveness ដោយ AI...',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIdCardFrame() {
    return Container(
      width: 320,
      height: 205,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _green, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: _green.withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Corner accents
          _buildCorner(top: 0, left: 0),
          _buildCorner(top: 0, right: 0),
          _buildCorner(bottom: 0, left: 0),
          _buildCorner(bottom: 0, right: 0),

          // ID Card Simulation Graphics
          if (_currentStep == 0) ...[
            // Photo placeholder
            Positioned(
              left: 20,
              top: 40,
              child: Container(
                width: 75,
                height: 95,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white38),
                ),
                child: const Icon(Icons.person, color: Colors.white54, size: 48),
              ),
            ),
            // Hologram emblem
            Positioned(
              right: 25,
              top: 25,
              child: Icon(Icons.verified, color: Colors.amber.withValues(alpha: 0.8), size: 36),
            ),
            // Text placeholders
            Positioned(
              left: 110,
              top: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFakeTextLine(90),
                  const SizedBox(height: 8),
                  _buildFakeTextLine(130),
                  const SizedBox(height: 8),
                  _buildFakeTextLine(110),
                ],
              ),
            ),
          ] else ...[
            // Back MRZ Barcode simulation
            Positioned(
              bottom: 25,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  _buildFakeTextLine(260),
                  const SizedBox(height: 6),
                  _buildFakeTextLine(260),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFaceOvalFrame() {
    return Container(
      width: 240,
      height: 310,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.elliptical(120, 155)),
        border: Border.all(color: _green, width: 3),
        boxShadow: [
          BoxShadow(
            color: _green.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.face_retouching_natural_rounded,
          color: Colors.white24,
          size: 110,
        ),
      ),
    );
  }

  Widget _buildCorner({double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: _green,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildFakeTextLine(double width) {
    return Container(
      width: width,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // ── Step 3: Extracted OCR Profile Confirmation ─────────────────────────────
  Widget _buildOcrResultView() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: _bgGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Success Verification Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _green.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _green.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified_user_rounded, color: _green, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'eKYC ផ្ទៀងផ្ទាត់ជោគជ័យ (Verified)',
                        style: GoogleFonts.battambang(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _darkGreen,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ទិន្នន័យត្រូវបានដកស្រង់ដោយស្វ័យប្រវត្តពីអត្តសញ្ញាណប័ណ្ណ',
                        style: GoogleFonts.battambang(
                          fontSize: 11.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // OCR Extracted Info Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ព័ត៌មានផ្ទាល់ខ្លួន (Personal Details)',
                  style: GoogleFonts.battambang(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                const Divider(height: 20),
                _buildDataRow('គោត្តនាម និងនាម:', 'ម៉េង ថេត'),
                _buildDataRow('Full Name (Latin):', 'MENG THETH'),
                _buildDataRow('លេខអត្តសញ្ញាណប័ណ្ណ (NID):', '010892415'),
                _buildDataRow('ថ្ងៃខែឆ្នាំកំណើត (DOB):', '15 តុលា 2002'),
                _buildDataRow('ភេទ (Gender):', 'ប្រុស (Male)'),
                _buildDataRow('សញ្ជាតិ (Nationality):', 'ខ្មែរ (Cambodian)'),
                _buildDataRow(
                  'អាសយដ្ឋាន:',
                  'សង្កាត់ទឹកល្អក់១ ខណ្ឌទួលគោក រាជធានីភ្នំពេញ',
                ),
                _buildDataRow('កាលបរិច្ឆេទផុតកំណត់:', '15 តុលា 2032'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Confirm & Open Account Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'អបអរសាទរ! គណនីធនាគារ ជីប ម៉ុង ត្រូវបានបង្កើតដោយជោគជ័យ',
                      style: GoogleFonts.battambang(),
                    ),
                    backgroundColor: _darkGreen,
                  ),
                );
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _darkGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                'បញ្ជាក់ និងបញ្ចប់ការបើកគណនី',
                style: GoogleFonts.battambang(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: GoogleFonts.battambang(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.battambang(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
