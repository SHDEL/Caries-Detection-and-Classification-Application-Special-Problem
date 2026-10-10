import 'package:caries_scan_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PrimaryInput extends StatefulWidget {
  final String text;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? hintText;

  const PrimaryInput({
    required this.text,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.hintText,
    super.key,
  });

  @override
  State<PrimaryInput> createState() => _PrimaryInputState();
}

class _PrimaryInputState extends State<PrimaryInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // ค่าเริ่มต้นเอามาจาก widget.isPassword ที่ส่งมาจากหน้า Sign In / Sign Up
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.text.isNotEmpty) ...[
          Text(
            widget.text,
            style: TextStyle(
              color: AppTheme.lightTheme.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: AppTheme.lightTheme.primaryColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: AppTheme.lightTheme.primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: AppTheme.lightTheme.primaryColor,
                width: 2,
              ),
            ),
            // เพิ่มไอคอนรูปตา ถ้ากำหนด isPassword ให้แสดงไอคอนเปิด/ปิดรหัสผ่าน
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                    onPressed: () {
                      // ถ้ากดให้สลับสถานะ
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
