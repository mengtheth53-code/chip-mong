import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipmongBrand extends StatelessWidget {
  const ChipmongBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.crunchbase.com/image/upload/c_pad,f_auto,q_auto:eco,dpr_1/ujrwed9bibpujkrzshvt?ik-sanitizeSvg=true',
              ),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'CHIP MONG\nBANK',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Chipmong extends StatelessWidget {
  const Chipmong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B6B3D),
      body: const Center(child: ChipmongBrand()),
    );
  }
}

