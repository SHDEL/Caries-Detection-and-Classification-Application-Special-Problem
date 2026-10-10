import 'package:caries_scan_app/presentation/widgets/app_card.dart';
import 'package:caries_scan_app/presentation/widgets/checkerboard_box.dart';
import 'package:caries_scan_app/presentation/widgets/outline_app_button.dart';
import 'package:caries_scan_app/services/auth_service.dart';
import 'package:flutter/material.dart';

/// [AccountPage] หน้าบัญชีของฉันและการตั้งค่า (ตามรูป Account Mockup)
class AccountPage extends StatelessWidget {
  final VoidCallback? onAccountInfoTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onLanguageTap;
  final VoidCallback? onThemeTap;
  final VoidCallback? onLogoutTap;

  const AccountPage({
    this.onAccountInfoTap,
    this.onNotificationsTap,
    this.onLanguageTap,
    this.onThemeTap,
    this.onLogoutTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              const Text(
                'บัญชีของฉัน',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Profile Card
              AppCard(
                borderRadius: 24,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Circular Avatar with Checkerboard pattern
                    const ClipOval(
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: CheckerboardBox(borderRadius: 0),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kongphop Worawutkasem',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'kongphop.wor@gmail.com',
                            style: TextStyle(
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
              const SizedBox(height: 24),

              // Section 1: บัญชี
              const Text(
                'บัญชี',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              AppCard(
                borderRadius: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                onTap: onAccountInfoTap,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ข้อมูลบัญชี',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section 2: การตั้งค่า
              const Text(
                'การตั้งค่า',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              AppCard(
                borderRadius: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Column(
                  children: [
                    _buildSettingRow(
                      title: 'การแจ้งเตือน',
                      onTap: onNotificationsTap,
                    ),
                    const Divider(
                      color: Color(0xFFE5E5EA),
                      height: 1,
                      thickness: 1,
                    ),
                    _buildSettingRow(
                      title: 'ภาษา',
                      onTap: onLanguageTap,
                    ),
                    const Divider(
                      color: Color(0xFFE5E5EA),
                      height: 1,
                      thickness: 1,
                    ),
                    _buildSettingRow(
                      title: 'ธีมสี',
                      onTap: onThemeTap,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Logout Button using OutlineAppButton
              SizedBox(
                width: double.infinity,
                child: OutlineAppButton(
                  text: 'ออกจากระบบ',
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  onPressed: onLogoutTap ?? () => AuthService.signOut(),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
