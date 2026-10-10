import 'package:caries_scan_app/presentation/theme/app_colors.dart';
import 'package:caries_scan_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OutlineAppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  const OutlineAppButton({
    required this.onPressed,
    required this.text,
    this.padding,
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 24),
        side: BorderSide(color: AppTheme.lightTheme.primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            28,
          ), // ปรับตามรูปร่างปุ่มใน Theme ของคุณ
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
          fontSize: fontSize ?? 18,
        ),
      ),
    );
  }
}
