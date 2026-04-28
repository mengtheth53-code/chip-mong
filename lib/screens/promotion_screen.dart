import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/poster.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A7A3C),
        leading: const BackButton(color: Colors.white),
        title: Text(
          'អត្ថប្រយោជន៍ និងការផ្ដល់ជូនពិសេស',
          style: GoogleFonts.battambang(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ស្វែងរក',
                hintStyle: GoogleFonts.battambang(fontSize: 15),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip('ការផ្ដល់ជូនពិសេស​ធំៗ', selected: true),
                  const SizedBox(width: 8),
                  _filterChip('បណ្ណ័ឥណទាន Visa Platinum'),
                  const SizedBox(width: 8),
                  _filterChip('ប័ណ្ណ'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: poster1.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final poster = poster1[index];
                return _PosterCard(poster: poster);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF1A7A3C) : Colors.white,
        border: Border.all(
          color: selected ? const Color(0xFF1A7A3C) : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.battambang(
          fontSize: 16,
          color: selected ? Colors.white : Colors.grey[700],
        ),
      ),
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Poster poster;

  const _PosterCard({required this.poster});

  @override
  Widget build(BuildContext context) {
    final parts = (poster.title ?? '').split('\n');
    final title = parts.isNotEmpty ? parts[0].trim() : '';
    final date = parts.length > 1 ? parts[1].trim() : '';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            poster.image,
            width: double.infinity,
            height: 190,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(height: 180, color: Colors.green[100]),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.battambang(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.battambang(
                    fontSize: 12,
                    color: Colors.grey,
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
