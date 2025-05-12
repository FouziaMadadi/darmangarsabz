
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.deepPurple.shade800
            : Colors.deepPurple.shade500,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
         // bottomLeft: Radius.circular(30),
         // bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.local_florist,
            label: 'گیاهان',
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.medical_services,
            label: 'بیماری‌ها',
            index: 1,
          ),
          _buildNavItem(
            icon: Icons.favorite,
            label: 'علاقه‌مندی',
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple.shade500 : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white70,
                size: isSelected ? 30 : 26,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: isSelected ? 13 : 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Vazir',
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}



