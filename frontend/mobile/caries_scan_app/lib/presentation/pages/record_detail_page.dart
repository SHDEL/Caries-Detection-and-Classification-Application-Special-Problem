import 'package:caries_scan_app/presentation/widgets/app_card.dart';
import 'package:caries_scan_app/presentation/widgets/checkerboard_box.dart';
import 'package:caries_scan_app/presentation/widgets/export_record_bottom_sheet.dart';
import 'package:caries_scan_app/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

/// [RecordDetailPage] หน้ารายละเอียดผลการตรวจ (ตามรูปที่ 4 และ 5)
class RecordDetailPage extends StatelessWidget {
  final String recordTitle;
  final VoidCallback? onBack;

  const RecordDetailPage({
    this.recordTitle = 'ผลการตรวจครั้งที่ 3',
    this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Custom Header Bar with Back Button
              Row(
                children: [
                  GestureDetector(
                    onTap: onBack ?? () => Navigator.maybePop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE5E5EA),
                          width: 1.2,
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        recordTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44), // Placeholder to balance back button
                ],
              ),
              const SizedBox(height: 20),

              // Scrollable Body Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Large Checkerboard Image Preview
                      const SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: CheckerboardBox(borderRadius: 24),
                      ),
                      const SizedBox(height: 24),

                      // Section Title
                      const Text(
                        'ตำแหน่งที่ตรวจพบทั้งหมด (3)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Severity Detection Cards
                      _buildDetectionCard('ฟันผุระดับปานกลาง'),
                      const SizedBox(height: 14),
                      _buildDetectionCard('ฟันผุระดับรุนแรง'),
                      const SizedBox(height: 14),
                      _buildDetectionCard('ฟันผุระดับเริ่มต้น'),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Export Button using PrimaryAppButton
              PrimaryAppButton(
                text: 'Export this record',
                padding: const EdgeInsets.symmetric(vertical: 20),
                onPressed: () {
                  showExportRecordBottomSheet(
                    context,
                    recordTitle: recordTitle,
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetectionCard(String title) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      borderRadius: 26,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
