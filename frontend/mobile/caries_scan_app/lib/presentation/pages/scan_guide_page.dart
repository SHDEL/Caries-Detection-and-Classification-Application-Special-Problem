import 'package:caries_scan_app/presentation/widgets/app_card.dart';
import 'package:caries_scan_app/presentation/widgets/checkerboard_box.dart';
import 'package:caries_scan_app/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

/// [ScanGuidePage] หน้าแนะนำการถ่ายภาพช่องปากด้วย AI (ตามรูปที่ 2)
class ScanGuidePage extends StatelessWidget {
  final VoidCallback? onScanPressed;

  const ScanGuidePage({
    this.onScanPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const Text(
                        'ตรวจจับฟันผุด้วย AI',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'เช็กสุขภาพฟันของคุณด้วยการถ่ายภาพช่องปากของคุณ\nและประมวลผลด้วย AI ของเรา',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Section 1: Example Angles
                      const Text(
                        'ภาพตัวอย่างที่ควรถ่าย (3 มุม)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CheckerboardBox(borderRadius: 18),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CheckerboardBox(borderRadius: 18),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CheckerboardBox(borderRadius: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Section 2: Tips
                      const Text(
                        'เคล็ดลับให้ผลแม่นยำ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const AppCard(
                        height: 200,
                        borderRadius: 24,
                        child: SizedBox(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Bottom Button using PrimaryAppButton
              PrimaryAppButton(
                text: "Let’s scan",
                padding: const EdgeInsets.symmetric(vertical: 20),
                onPressed: onScanPressed ?? () {},
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
