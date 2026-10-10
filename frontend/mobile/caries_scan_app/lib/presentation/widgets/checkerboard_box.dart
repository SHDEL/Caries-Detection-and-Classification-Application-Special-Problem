import 'package:flutter/material.dart';

/// [CheckerboardBox] กล่องแสดงภาพ Placeholder ลายตารางหมากรุก (Checkerboard)
/// ตามที่แสดงในรูป mockup สำหรับตัวอย่างภาพถ่ายและพรีวิวภาพฟัน
class CheckerboardBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? child;

  const CheckerboardBox({
    this.width,
    this.height,
    this.borderRadius = 20.0,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _CheckerboardPainter(),
            ),
            if (child != null) Center(child: child),
          ],
        ),
      ),
    );
  }
}

class _CheckerboardPainter extends CustomPainter {
  final double squareSize = 10.0;
  final Color color1 = const Color(0xFFF0F1F5);
  final Color color2 = const Color(0xFFFAFAFC);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = color1;
    final paint2 = Paint()..color = color2;

    int cols = (size.width / squareSize).ceil();
    int rows = (size.height / squareSize).ceil();

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final rect = Rect.fromLTWH(
          c * squareSize,
          r * squareSize,
          squareSize,
          squareSize,
        );
        canvas.drawRect(rect, (r + c) % 2 == 0 ? paint1 : paint2);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
