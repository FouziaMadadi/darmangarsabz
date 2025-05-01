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
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'خانه',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.nightlight_round), // آیکون مهتاب
          label: 'تم',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'علاقه‌مندی',
        ),
      ],
    );
  }
}
