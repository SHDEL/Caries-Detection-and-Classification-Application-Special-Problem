import 'package:caries_scan_app/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// [AppBottomNavBar] แถบเมนูด้านล่าง 4 เมนูตาม UI Mockup
/// (Home, AI Scan, History, Profile)
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home_rounded),
              _buildNavItem(1, Icons.camera_alt_outlined, Icons.camera_alt_rounded),
              _buildNavItem(2, Icons.assignment_outlined, Icons.assignment_rounded),
              _buildNavItem(3, Icons.person_outline_rounded, Icons.person_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlineIcon, IconData solidIcon) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Icon(
          isSelected ? solidIcon : outlineIcon,
          size: 28,
          color: isSelected ? AppColors.primary : const Color(0xFF8E8E93),
        ),
      ),
    );
  }
}
