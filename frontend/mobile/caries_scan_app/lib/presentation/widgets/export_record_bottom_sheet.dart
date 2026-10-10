import 'package:caries_scan_app/presentation/theme/app_colors.dart';
import 'package:caries_scan_app/presentation/widgets/outline_app_button.dart';
import 'package:flutter/material.dart';

/// [showExportRecordBottomSheet] ฟังก์ชันเปิด BottomSheet สำหรับการส่งออกผลตรวจ (ตามรูปที่ 5)
void showExportRecordBottomSheet(BuildContext context, {String recordTitle = 'ผลการตรวจครั้งที่ 3'}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) {
      return ExportRecordBottomSheet(recordTitle: recordTitle);
    },
  );
}

class ExportRecordBottomSheet extends StatelessWidget {
  final String recordTitle;

  const ExportRecordBottomSheet({
    this.recordTitle = 'ผลการตรวจครั้งที่ 3',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 14,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 36,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle indicator
          Center(
            child: Container(
              width: 50,
              height: 4.5,
              decoration: BoxDecoration(
                color: const Color(0xFFC7C7CC),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'ส่งออก$recordTitle',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // Option 1: Save to PDF
          _buildExportOption(
            title: 'Save to PDF',
            subtitle: 'Include image, analysis',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 14),

          // Option 2: Copy Link
          _buildExportOption(
            title: 'Copy Link',
            subtitle: 'for viewer, expires in 7 days, cancelable',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 26),

          // Cancel button using OutlineAppButton
          OutlineAppButton(
            text: 'ยกเลิก',
            fontSize: 16,
            padding: const EdgeInsets.symmetric(vertical: 16),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOption({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFC7C7CC),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            // Icon / placeholder rounded square
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF1DEFC),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 16),
            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
