import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExchangeRatesScreen extends StatefulWidget {
  const ExchangeRatesScreen({super.key});

  @override
  State<ExchangeRatesScreen> createState() => _ExchangeRatesScreenState();
}

class _ExchangeRatesScreenState extends State<ExchangeRatesScreen> {
  static const Color _darkGreen = Color(0xFF085329);
  static const Color _green = Color(0xFF0FA958);
  static const Color _bgGray = Color(0xFFF2F4F7);

  final TextEditingController _convertAmountController =
      TextEditingController(text: '100');
  String _fromCurrency = 'USD';
  String _toCurrency = 'KHR';

  final List<Map<String, dynamic>> _rates = [
    {
      'code': 'USD / KHR',
      'currency': 'ប្រាក់រៀល',
      'flag': '🇰🇭',
      'buy': 4075.0,
      'sell': 4105.0,
      'rate': 4090.0,
    },
    {
      'code': 'THB / USD',
      'currency': 'បាតថៃ',
      'flag': '🇹🇭',
      'buy': 35.80,
      'sell': 36.40,
      'rate': 36.10,
    },
    {
      'code': 'EUR / USD',
      'currency': 'អឺរ៉ូ',
      'flag': '🇪🇺',
      'buy': 1.0720,
      'sell': 1.0950,
      'rate': 1.0835,
    },
    {
      'code': 'CNY / USD',
      'currency': 'យ័នចិន',
      'flag': '🇨🇳',
      'buy': 7.15,
      'sell': 7.30,
      'rate': 7.22,
    },
    {
      'code': 'SGD / USD',
      'currency': 'ដុល្លារសិង្ហបុរី',
      'flag': '🇸🇬',
      'buy': 1.3350,
      'sell': 1.3580,
      'rate': 1.3465,
    },
    {
      'code': 'JPY / USD',
      'currency': 'យ៉េនជប៉ុន',
      'flag': '🇯🇵',
      'buy': 152.20,
      'sell': 156.40,
      'rate': 154.30,
    },
    {
      'code': 'GBP / USD',
      'currency': 'ផោនអង់គ្លេស',
      'flag': '🇬🇧',
      'buy': 1.2580,
      'sell': 1.2850,
      'rate': 1.2715,
    },
    {
      'code': 'VND / USD',
      'currency': 'ដុងវៀតណាម',
      'flag': '🇻🇳',
      'buy': 24800.0,
      'sell': 25500.0,
      'rate': 25150.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _convertAmountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _convertAmountController.dispose();
    super.dispose();
  }

  double get _convertedValue {
    final amount = double.tryParse(_convertAmountController.text) ?? 0.0;
    if (_fromCurrency == 'USD' && _toCurrency == 'KHR') {
      return amount * 4090.0;
    } else if (_fromCurrency == 'KHR' && _toCurrency == 'USD') {
      return amount / 4090.0;
    } else if (_fromCurrency == 'USD' && _toCurrency == 'THB') {
      return amount * 36.10;
    } else {
      return amount * 4090.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGray,
      appBar: AppBar(
        backgroundColor: _darkGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'អត្រាប្ដូរប្រាក់',
          style: GoogleFonts.battambang(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Converter Calculator Card
            _buildConverterCard(),
            const SizedBox(height: 20),

            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'អត្រាប្ដូរប្រាក់ប្រចាំថ្ងៃ',
                  style: GoogleFonts.battambang(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'គិតត្រឹម 10:30 AM',
                  style: GoogleFonts.battambang(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // FX Rate Table
            _buildRateTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildConverterCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.currency_exchange_rounded,
                  color: _green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'គណនាការប្ដូរប្រាក់ភ្លាមៗ',
                style: GoogleFonts.battambang(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Amount Input Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _convertAmountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _darkGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _fromCurrency,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Switch button
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  final tmp = _fromCurrency;
                  _fromCurrency = _toCurrency;
                  _toCurrency = tmp;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.swap_vert_rounded,
                  color: _green,
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Result Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _green.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _toCurrency == 'KHR'
                      ? '${_convertedValue.toStringAsFixed(0)} ៛'
                      : '\$ ${_convertedValue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: _green,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _toCurrency,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
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

  Widget _buildRateTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Table header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'រូបិយប័ណ្ណ',
                    style: GoogleFonts.battambang(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'តម្លៃទិញចូល',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.battambang(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'តម្លៃលក់ចេញ',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.battambang(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Rates list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _rates.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 16),
            itemBuilder: (_, index) {
              final r = _rates[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            r['flag'] as String,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['code'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.5,
                                ),
                              ),
                              Text(
                                r['currency'] as String,
                                style: GoogleFonts.battambang(
                                  fontSize: 11.5,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        r['buy'] is double && (r['buy'] as double) >= 1000
                            ? (r['buy'] as double).toStringAsFixed(0)
                            : (r['buy'] as double).toString(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5,
                          color: _green,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        r['sell'] is double && (r['sell'] as double) >= 1000
                            ? (r['sell'] as double).toStringAsFixed(0)
                            : (r['sell'] as double).toString(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5,
                          color: Color(0xFFDC2626),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
