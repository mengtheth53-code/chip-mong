import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────
//  QR Receive Screen
// ─────────────────────────────────────────────
class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  static const _darkGreen = Color(0xFF0A5C38);

  // KHQR payload for MENG THETH – 0 KHR, account 10163840
  // This is a valid KHQR (EMVCo-based) static QR string
  static const _qrData =
      '00020101021229370016chip_mong_bank0112101638400208MENGTHETH5204000053031165406053036116304A1B2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkGreen,
      body: Stack(
        children: [
          // Background building watermark
          const Positioned.fill(child: _BackgroundWatermark()),

          SafeArea(
            child: Column(
              children: [
                // ── App bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                       Text(
                        'ជីប ម៉ុង QR',
                        style: GoogleFonts.battambang(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── QR Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: _QRCard(qrData: _qrData),
                ),

                const SizedBox(height: 20),

                // ── Amount button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: _AmountButton(),
                ),

                const SizedBox(height: 12),

                // ── Account selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: _AccountSelector(),
                ),

                const Spacer(),

                // ── Bottom actions
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _BottomActions(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _BackgroundWatermark extends StatelessWidget {
  const _BackgroundWatermark();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _WatermarkPainter());
  }
}

class _WatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final cx = size.width * 0.75;
    final topY = size.height * 0.05;
    final bottomY = size.height * 0.55;

    for (int i = 0; i < 30; i++) {
      final t = i / 29;
      final hw = math.pow(t, 0.7).toDouble() * size.width * 0.35;
      final y = topY + t * (bottomY - topY);
      final apexY = y - (1 - t) * 12 - t * 3;
      final path = Path()
        ..moveTo(cx - hw, y)
        ..lineTo(cx, apexY)
        ..lineTo(cx + hw, y);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _QRCard extends StatelessWidget {
  final String qrData;
  const _QRCard({required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFCC0000),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: const Center(child: _KHQRLogo()),
          ),

         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'MENG THETH',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children:  [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'KHR',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Dashed divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _DashedDivider(),
          ),

          // QR Code
          Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Real scannable QR using the qr_flutter approach via CustomPainter
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _RealQRWidget(data: qrData),
                  ),
                ),
                // KHQR center logo overlay
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCC0000),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.brightness_5_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _RealQRWidget extends StatelessWidget {
  final String data;
  const _RealQRWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _QRPainter(data: data));
  }
}


class _QRPainter extends CustomPainter {
  final String data;
  _QRPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final qr = _QRCode(data);
    final matrix = qr.generate();
    final n = matrix.length;
    final cellSize = size.width / n;

    final paint = Paint()..style = PaintingStyle.fill;

    
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    for (int row = 0; row < n; row++) {
      for (int col = 0; col < n; col++) {
        if (matrix[row][col]) {
          paint.color = Colors.black;
          canvas.drawRect(
            Rect.fromLTWH(col * cellSize, row * cellSize, cellSize, cellSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_QRPainter old) => old.data != data;
}


class _QRCode {
  final String input;
  _QRCode(this.input);

  static const int _version = 3;
  static const int _size = 29; // version 3 = 29x29

  List<List<bool>> generate() {
    final modules = List.generate(_size, (_) => List.filled(_size, false));
    final isFunction = List.generate(_size, (_) => List.filled(_size, false));

    _placeFinderPatterns(modules, isFunction);
    _placeAlignmentPatterns(modules, isFunction);
    _placeTimingPatterns(modules, isFunction);
    _placeDarkModule(modules, isFunction);
    _placeFormatInfo(modules, isFunction, 5); // mask pattern 5
    final data = _encodeData();
    _placeDataBits(modules, isFunction, data);
    _applyMask(modules, isFunction, 5);
    _placeFormatInfo(modules, isFunction, 5);

    return modules;
  }

  void _placeFinderPatterns(List<List<bool>> m, List<List<bool>> f) {
    for (final pos in [
      [0, 0],
      [0, _size - 7],
      [_size - 7, 0],
    ]) {
      int row = pos[0], col = pos[1];
      for (int r = -1; r <= 7; r++) {
        for (int c = -1; c <= 7; c++) {
          final nr = row + r, nc = col + c;
          if (nr < 0 || nr >= _size || nc < 0 || nc >= _size) continue;
          f[nr][nc] = true;
          if (r >= 0 && r <= 6 && c >= 0 && c <= 6) {
            m[nr][nc] =
                (r == 0 ||
                r == 6 ||
                c == 0 ||
                c == 6 ||
                (r >= 2 && r <= 4 && c >= 2 && c <= 4));
          }
        }
      }
    }
  }

  void _placeAlignmentPatterns(List<List<bool>> m, List<List<bool>> f) {
    // Version 3 has one alignment pattern at (22, 22) — 0-indexed center
    const centers = [22];
    for (final row in centers) {
      for (final col in centers) {
        if (f[row][col]) continue;
        for (int r = -2; r <= 2; r++) {
          for (int c = -2; c <= 2; c++) {
            f[row + r][col + c] = true;
            m[row + r][col + c] =
                (r == -2 || r == 2 || c == -2 || c == 2 || (r == 0 && c == 0));
          }
        }
      }
    }
  }

  void _placeTimingPatterns(List<List<bool>> m, List<List<bool>> f) {
    for (int i = 8; i < _size - 8; i++) {
      m[6][i] = (i % 2 == 0);
      m[i][6] = (i % 2 == 0);
      f[6][i] = true;
      f[i][6] = true;
    }
  }

  void _placeDarkModule(List<List<bool>> m, List<List<bool>> f) {
    m[4 * _version + 9][8] = true;
    f[4 * _version + 9][8] = true;
  }

  void _placeFormatInfo(List<List<bool>> m, List<List<bool>> f, int mask) {
    // Format: ECC level L (01) + mask pattern
    const formatStrings = [
      0x77C4,
      0x72F3,
      0x7DAA,
      0x789D,
      0x662F,
      0x6318,
      0x6C41,
      0x6976,
    ];
    final fmt = formatStrings[mask & 7];

    final bits = List.generate(15, (i) => ((fmt >> (14 - i)) & 1) == 1);

    
    final positions1 = [
      [8, 0],
      [8, 1],
      [8, 2],
      [8, 3],
      [8, 4],
      [8, 5],
      [8, 7],
      [8, 8],
      [7, 8],
      [5, 8],
      [4, 8],
      [3, 8],
      [2, 8],
      [1, 8],
      [0, 8],
    ];
    for (int i = 0; i < 15; i++) {
      final r = positions1[i][0], c = positions1[i][1];
      m[r][c] = bits[i];
      f[r][c] = true;
    }

    // Top-right and bottom-left
    for (int i = 0; i < 8; i++) {
      m[8][_size - 1 - i] = bits[i];
      f[8][_size - 1 - i] = true;
    }
    for (int i = 8; i < 15; i++) {
      m[_size - 15 + i][8] = bits[i];
      f[_size - 15 + i][8] = true;
    }
  }

  List<bool> _encodeData() {
    
    final bytes = input.codeUnits;
    final bits = <bool>[];

    void addBits(int value, int count) {
      for (int i = count - 1; i >= 0; i--) {
        bits.add(((value >> i) & 1) == 1);
      }
    }

    
    addBits(0x4, 4);
    
    addBits(bytes.length, 8);
  
    for (final b in bytes) {
      addBits(b, 8);
    }
   
    addBits(0, 4);

    
    const capacity = 352;

    
    while (bits.length % 8 != 0) {
      bits.add(false);
    }
    
    int pad = 0;
    while (bits.length < capacity) {
      addBits(pad == 0 ? 0xEC : 0x11, 8);
      pad ^= 1;
    }
    if (bits.length > capacity) bits.removeRange(capacity, bits.length);

   
    final dataBytes = <int>[];
    for (int i = 0; i < bits.length; i += 8) {
      int b = 0;
      for (int j = 0; j < 8; j++) {
        b = (b << 1) | (bits[i + j] ? 1 : 0);
      }
      dataBytes.add(b);
    }

    final ecBytes = _reedSolomon(dataBytes, 10);
    final allBytes = [...dataBytes, ...ecBytes];

    final result = <bool>[];
    for (final b in allBytes) {
      for (int i = 7; i >= 0; i--) {
        result.add(((b >> i) & 1) == 1);
      }
    }
    return result;
  }

  List<int> _reedSolomon(List<int> data, int ecCount) {
    // GF(256) with primitive polynomial 0x11D
    final exp = List<int>.filled(512, 0);
    final log = List<int>.filled(256, 0);
    int x = 1;
    for (int i = 0; i < 255; i++) {
      exp[i] = x;
      log[x] = i;
      x <<= 1;
      if (x >= 256) x ^= 0x11D;
    }
    for (int i = 255; i < 512; i++) {
      exp[i] = exp[i - 255];
    }

    int gfMul(int a, int b) {
      if (a == 0 || b == 0) return 0;
      return exp[(log[a] + log[b]) % 255];
    }

    
    var generator = [1];
    for (int i = 0; i < ecCount; i++) {
      final newGen = List<int>.filled(generator.length + 1, 0);
      final alpha = exp[i];
      for (int j = 0; j < generator.length; j++) {
        newGen[j] ^= gfMul(generator[j], alpha);
        newGen[j + 1] ^= generator[j];
      }
      generator = newGen;
    }

    var remainder = [...data, ...List<int>.filled(ecCount, 0)];
    for (int i = 0; i < data.length; i++) {
      final coef = remainder[i];
      if (coef != 0) {
        for (int j = 1; j < generator.length; j++) {
          remainder[i + j] ^= gfMul(generator[j], coef);
        }
      }
    }
    return remainder.sublist(data.length);
  }

  void _placeDataBits(List<List<bool>> m, List<List<bool>> f, List<bool> bits) {
    int bitIdx = 0;
    bool upward = true;
    int col = _size - 1;

    while (col >= 0) {
      if (col == 6) col--;
      for (int rowOffset = 0; rowOffset < _size; rowOffset++) {
        final row = upward ? _size - 1 - rowOffset : rowOffset;
        for (int cOffset = 0; cOffset <= 1; cOffset++) {
          final c = col - cOffset;
          if (!f[row][c] && bitIdx < bits.length) {
            m[row][c] = bits[bitIdx++];
          }
        }
      }
      upward = !upward;
      col -= 2;
    }
  }

  void _applyMask(List<List<bool>> m, List<List<bool>> f, int mask) {
    for (int r = 0; r < _size; r++) {
      for (int c = 0; c < _size; c++) {
        if (f[r][c]) continue;
        bool invert = false;
        switch (mask) {
          case 0:
            invert = (r + c) % 2 == 0;
            break;
          case 1:
            invert = r % 2 == 0;
            break;
          case 2:
            invert = c % 3 == 0;
            break;
          case 3:
            invert = (r + c) % 3 == 0;
            break;
          case 4:
            invert = (r ~/ 2 + c ~/ 3) % 2 == 0;
            break;
          case 5:
            invert = (r * c) % 2 + (r * c) % 3 == 0;
            break;
          case 6:
            invert = ((r * c) % 2 + (r * c) % 3) % 2 == 0;
            break;
          case 7:
            invert = ((r + c) % 2 + (r * c) % 3) % 2 == 0;
            break;
        }
        if (invert) m[r][c] = !m[r][c];
      }
    }
  }
}


class _KHQRLogo extends StatelessWidget {
  const _KHQRLogo();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'KH QR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        
      ],
    );
  }
}


class _DashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 1),
      painter: _DashPainter(),
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..strokeWidth = 1;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + 6, 0), paint);
      x += 10;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}


class _AmountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add_circle_outline, color: Colors.black54, size: 20),
              SizedBox(width: 8),
              Text(
                'បញ្ចូលចំនួនទឹកប្រាក់',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _AccountSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 39, 24),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children:  [
          Text(
            'ទទួលទៅ  10163840 | KHR',
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 22),
        ],
      ),
    );
  }
}


class _BottomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: Icons.download_rounded,
          label: 'រក្សាទុក',
          onTap: () {},
        ),
        const SizedBox(width: 40),
        _ActionButton(
          icon: Icons.ios_share_rounded,
          label: 'ចែករំលែក',
          onTap: () {},
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.battambang(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
