import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Dark green header
          _buildHeader(context),

          // White content area with rounded top corners
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: _buildContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0D5C3A),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 24),
          // Title
          const Text(
            'Terms and Conditions Mobile Banking Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Intro paragraph
        _buildParagraph(
          children: [
             TextSpan(text: 'ខចែង និងលក្ខខណ្ឌទូទៅនែការប្រើប្រាស់ ',style: GoogleFonts.battambang(fontSize: 18)),
            _bold('CHIP MONG BANK APP'),
          ],
        ),
        const SizedBox(height: 16),

        _buildParagraph(
          children: [
            _bold('កំណត់សម្គាល់ចំណុចសំខាន់ៈ'),
             TextSpan(
              text:
                  ' សូមធ្វើការអាន និងយល់ដឹង​ មុននឹងចូលប្រើប្រាស់សេវាកម្ម និង/ឬ ផលិតផលផ្សេបានចែងនៅក្នុង ខចែង និងលក្ខខណ្ឌចូរទៅដោយយកចិត្តទុកដាក់ ។ គ្រប់អតិថិជនដែលចូលទៅប្រើប្រាស់នឹងត្រូវចងភា្ជប់ ជាំមួយខចែងនិងលក្ខខណ្ឌទូទៅ ។ ក្នុងនាមអ្នកជាប្រើប្រាស់កម្មវិធីទូរសព្ទ Chip Mong Bank App រាពិតជាសំខាន់ណាស់ក្នុងការអានខចែង និងលក្ខខណ្ខដែលត្រូវចងក្នុងការប្រើប្រាស់ ។',
                  style: GoogleFonts.battambang(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Section 1
        _buildSectionTitle('១. និយមន័យ'),
        const SizedBox(height: 12),

        _buildParagraph(
          children: [
            const TextSpan(
              text:
                  'ពាក្យខ្លះក្រោមនេះអាចអត្ថន័យអត្ថន័យដូចត នៅពេលត្រូវបានប្រើប្រាស់ នៅក្នុងខចែង និងលក្ខខណ្ឌទាំងនេះ ៖',
            ),
          ],
        ),
        const SizedBox(height: 16),

        _buildDefinitionItem(
          term: 'ធនាគារ',
          definition:
              ' មានន័យថា ធនាគារ ជីប ម៉ុង ខមមើសល ប៊ែង ម.ក ព្រមទាំងប្រតិសិទ្ធិ និងអ្នកដែលត្រូវបានប្រគល់សិទ្ធិដោយធនាគារ។',
        ),
        const SizedBox(height: 14),

        _buildDefinitionItem(
          term: 'ថ្ងៃធ្វើការ',
          definition:
              ' មានន័យថា ថ្ងៃដែលធនាគារបើកដំណើរការអាជីវកម្មរបស់ខ្លួន ដោយមិនរាប់បញ្ចូលថ្ងៃសៅរ៍ អាទិត្យ និងថ្ងៃឈប់សម្រាកបុណ្យជាតិ។',
        ),
        const SizedBox(height: 14),

        _buildDefinitionItem(
          term: 'អតិថិជន',
          definition:
              ' មានន័យថាជារូបវន្តបុគ្គល ឬ នីតិបុគ្គលដែលមានបំណងប្រើប្រាស់ ឬ បាននិងកំពុងប្រើប្រាស់សេវាកម្ម និង/ឬ ផលិតផលណាមួយពីធនាគារ។',
        ),
        const SizedBox(height: 16),

        
      ],
    );
  }

  Widget _buildParagraph({required List<InlineSpan> children}) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.battambang(
          fontSize: 18,
          color: Colors.black87,
          height: 1.65,
        ),
        children: children,
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.battambang(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.5,
      ),
    );
  }

  Widget _buildDefinitionItem({
    required String term,
    required String definition,
  }) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.battambang(
          fontSize: 18,
          color: Colors.black87,
          height: 1.65,
        ),
        children: [
          TextSpan(
            text: term,
            style: GoogleFonts.battambang(
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(text: definition),
        ],
      ),
    );
  }

  TextSpan _bold(String text) {
    return TextSpan(
      text: text,
      style: GoogleFonts.battambang(fontWeight: FontWeight.w700, fontSize: 20),
    );
  }
}
