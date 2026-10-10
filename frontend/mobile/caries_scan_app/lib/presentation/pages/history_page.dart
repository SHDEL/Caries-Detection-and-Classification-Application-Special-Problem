import 'package:caries_scan_app/presentation/theme/app_colors.dart';
import 'package:caries_scan_app/presentation/widgets/app_card.dart';
import 'package:caries_scan_app/presentation/widgets/checkerboard_box.dart';
import 'package:flutter/material.dart';

/// [HistoryPage] หน้าประวัติการตรวจจับฟันผุ (ตามรูปที่ 3)
class HistoryPage extends StatefulWidget {
  final ValueChanged<int>? onSelectRecord;

  const HistoryPage({
    this.onSelectRecord,
    super.key,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = const [
    'ทั้งหมด',
    'Initial Caries',
    'Moderate Caries',
    'Severe Caries',
  ];

  final List<Map<String, dynamic>> _records = const [
    {
      'id': 4,
      'title': 'ผลการตรวจครั้งที่ 4',
      'date': '24 March 2026 - 16:16',
      'detail': 'พบฟันผุ 3 ตำแหน่ง',
    },
    {
      'id': 3,
      'title': 'ผลการตรวจครั้งที่ 3',
      'date': '24 March 2026 - 16:16',
      'detail': 'พบฟันผุ 3 ตำแหน่ง',
    },
    {
      'id': 2,
      'title': 'ผลการตรวจครั้งที่ 2',
      'date': '24 March 2026 - 16:16',
      'detail': 'พบฟันผุ 3 ตำแหน่ง',
    },
    {
      'id': 1,
      'title': 'ผลการตรวจครั้งที่ 1',
      'date': '24 March 2026 - 16:16',
      'detail': 'พบฟันผุ 3 ตำแหน่ง',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
              child: Text(
                'ประวัติการตรวจจับ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Filter Chips Horizontal List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(_filters.length, (index) {
                  final isSelected = _selectedFilterIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFFC7C7CC),
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          _filters[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // History List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                itemCount: _records.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final record = _records[index];
                  return AppCard(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 24,
                    onTap: () {
                      if (widget.onSelectRecord != null) {
                        widget.onSelectRecord!(record['id'] as int);
                      }
                    },
                    child: Row(
                      children: [
                        // Image Thumbnail Placeholder
                        const SizedBox(
                          width: 80,
                          height: 80,
                          child: CheckerboardBox(borderRadius: 18),
                        ),
                        const SizedBox(width: 16),
                        // Record Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record['title'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                record['date'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                record['detail'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
