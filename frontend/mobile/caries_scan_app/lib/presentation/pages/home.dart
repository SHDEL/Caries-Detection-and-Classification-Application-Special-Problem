import 'package:caries_scan_app/presentation/pages/account_page.dart';
import 'package:caries_scan_app/presentation/pages/history_page.dart';
import 'package:caries_scan_app/presentation/pages/home_dashboard_page.dart';
import 'package:caries_scan_app/presentation/pages/record_detail_page.dart';
import 'package:caries_scan_app/presentation/pages/scan_guide_page.dart';
import 'package:caries_scan_app/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

/// [HomePage] หน้าหลักของแอปพลิเคชันที่รวมแท็บเมนูต่าง ๆ ตามดีไซน์
/// - Tab 0: HomeDashboardPage (รูปที่ 1)
/// - Tab 1: ScanGuidePage (รูปที่ 2)
/// - Tab 2: HistoryPage (รูปที่ 3) และ RecordDetailPage (รูปที่ 4 & 5)
/// - Tab 3: ProfilePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int? _selectedRecordId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildCurrentPage(),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _selectedRecordId = null; // รีเซ็ตการดูหน้ารายละเอียดเมื่อสลับแท็บ
          });
        },
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const HomeDashboardPage();
      case 1:
        return ScanGuidePage(
          onScanPressed: () {
            // สลับไปแท็บประวัติหรือแสดงหน้ารายละเอียดเพื่อพรีวิว
            setState(() {
              _currentIndex = 2;
              _selectedRecordId = 3;
            });
          },
        );
      case 2:
        if (_selectedRecordId != null) {
          return RecordDetailPage(
            recordTitle: 'ผลการตรวจครั้งที่ $_selectedRecordId',
            onBack: () {
              setState(() {
                _selectedRecordId = null;
              });
            },
          );
        }
        return HistoryPage(
          onSelectRecord: (recordId) {
            setState(() {
              _selectedRecordId = recordId;
            });
          },
        );
      case 3:
        return const AccountPage();
      default:
        return const HomeDashboardPage();
    }
  }
}

// Alias สำหรับเรียกใช้ด้วยชื่อ HomePage หรือ HomeScreen
typedef HomeScreen = HomePage;
