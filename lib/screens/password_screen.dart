import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  static Future<bool> show(BuildContext context) async {
    final unlocked = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => const PasswordScreen()));
    return unlocked ?? false;
  }

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
    with SingleTickerProviderStateMixin {
  static const int passwordLength = 6;
  static const String _demoPassword = '147258';

  List<String> _password = [];
  bool _isError = false;
  bool _isSuccess = false;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onKeyPressed(String digit) {
    if (_password.length >= passwordLength || _isSuccess) return;
    HapticFeedback.lightImpact();
    setState(() => _password.add(digit));
    if (_password.length == passwordLength) {
      _checkPassword();
    }
  }

  void _onBackspace() {
    if (_password.isEmpty) return;
    HapticFeedback.lightImpact();
    setState(() => _password.removeLast());
  }

  void _onClear() {
    HapticFeedback.mediumImpact();
    setState(() {
      _password = [];
      _isError = false;
      _isSuccess = false;
    });
  }

  Future<void> _checkPassword() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_password.join() == _demoPassword) {
      HapticFeedback.heavyImpact();
      setState(() => _isSuccess = true);
      await Future.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } else {
      HapticFeedback.vibrate();
      setState(() => _isError = true);
      _shakeController.forward(from: 0);
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() {
        _password = [];
        _isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFC8F0E0), Color(0xFFA8DFC8), Color(0xFFD4F0E8)],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Close button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Color(0xFF2A6B4E),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Lock icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF22B573),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF22B573).withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Enter your 6-digit password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A4A35),
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 28),

              // Password dots with shake animation
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  final shake = _isError
                      ? 8 * (0.5 - (_shakeAnimation.value - 0.5).abs())
                      : 0.0;
                  return Transform.translate(
                    offset: Offset(shake * 6, 0),
                    child: child,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(passwordLength, (i) {
                    final filled = i < _password.length;
                    Color dotColor;
                    if (_isError) {
                      dotColor = const Color(0xFFE05050);
                    } else if (_isSuccess && filled) {
                      dotColor = const Color(0xFF22B573);
                    } else if (filled) {
                      dotColor = const Color(0xFF22B573);
                    } else {
                      dotColor = const Color(0xFF226446).withValues(alpha: 0.2);
                    }
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      width: filled ? 14 : 13,
                      height: filled ? 14 : 13,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),

              const Spacer(),

              // Keypad
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: _buildKeypad(),
              ),

              const SizedBox(height: 32),

              // Home indicator
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3C28).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        _buildKeyRow(['1', '2', '3']),
        const SizedBox(height: 10),
        _buildKeyRow(['4', '5', '6']),
        const SizedBox(height: 10),
        _buildKeyRow(['7', '8', '9']),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildActionKey(
              child: const Text(
                'C',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A4A35),
                  letterSpacing: 0.5,
                ),
              ),
              onTap: _onClear,
              transparent: true,
            ),
            const SizedBox(width: 10),
            _buildNumberKey('0'),
            const SizedBox(width: 10),
            _buildActionKey(
              child: const Icon(
                Icons.backspace_outlined,
                color: Color(0xFF1A4A35),
                size: 22,
              ),
              onTap: _onBackspace,
              transparent: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyRow(List<String> keys) {
    return Row(
      children: keys
          .map(
            (k) => [
              _buildNumberKey(k),
              if (k != keys.last) const SizedBox(width: 10),
            ],
          )
          .expand((e) => e)
          .toList(),
    );
  }

  Widget _buildNumberKey(String digit) {
    return Expanded(
      child: _PasswordKey(
        onTap: () => _onKeyPressed(digit),
        child: Text(
          digit,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1A4A35),
          ),
        ),
      ),
    );
  }

  Widget _buildActionKey({
    required Widget child,
    required VoidCallback onTap,
    bool transparent = false,
  }) {
    return Expanded(
      child: _PasswordKey(onTap: onTap, transparent: transparent, child: child),
    );
  }
}

class _PasswordKey extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool transparent;

  const _PasswordKey({
    required this.child,
    required this.onTap,
    this.transparent = false,
  });

  @override
  State<_PasswordKey> createState() => _PasswordKeyState();
}

class _PasswordKeyState extends State<_PasswordKey> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        height: 64,
        decoration: BoxDecoration(
          color: widget.transparent
              ? Colors.transparent
              : _pressed
              ? Colors.white.withValues(alpha: 0.85)
              : Colors.white.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(16),
          border: widget.transparent
              ? null
              : Border.all(
                  color: Colors.white.withValues(alpha: 0.8),
                  width: 0.5,
                ),
        ),
        transform: _pressed
            ? (Matrix4.identity()..scaleByDouble(0.93, 0.93, 1.0, 1.0))
            : Matrix4.identity(),
        child: Center(child: widget.child),
      ),
    );
  }
}