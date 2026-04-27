import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    this.trailing,
    this.bottom,
    this.height = 56,
  });

  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget? trailing;
  final Widget? bottom;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: foregroundColor,
                        size: 20,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.battambang(
                      color: foregroundColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (trailing != null)
                    Align(alignment: Alignment.centerRight, child: trailing!),
                ],
              ),
            ),
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }
}
