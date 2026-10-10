import 'package:caries_scan_app/presentation/theme/app_colors.dart';
import 'package:caries_scan_app/presentation/widgets/outline_app_button.dart';
import 'package:caries_scan_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Caries Scan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.primary),
            tooltip: 'ออกจากระบบ',
            onPressed: () => AuthService.signOut(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),
              const Text(
                'เข้าสู่ระบบสำเร็จ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user?.email ?? user?.displayName ?? 'User',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: OutlineAppButton(
                  text: 'ออกจากระบบ',
                  onPressed: () => AuthService.signOut(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Alias สำหรับเรียกใช้ด้วยชื่อ HomePage หรือ HomeScreen
typedef HomeScreen = HomePage;
