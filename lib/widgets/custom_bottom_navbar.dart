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

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.deepPurple.shade800
                : Colors.deepPurple.shade500,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: selectedIndex == 0 ? Colors.white : Colors.white70,
                ),
                onPressed: () => onTabSelected(0),
              ),
              const SizedBox(width: 60),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: selectedIndex == 2 ? Colors.white : Colors.white70,
                ),
                onPressed: () => onTabSelected(2),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 30,
          child: GestureDetector(
            onTap: () => onTabSelected(1),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
                border: Border.all(
                  color: Colors.deepPurple.shade100,
                  width: 4,
                ),
              ),
              child: const Icon(
                Icons.nightlight_round,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
