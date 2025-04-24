import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  int selectedIndex = 0;
  final List<String> filters = ['گیاهان', 'امراض', 'علاقه‌مندی‌ها'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF5E3A75) : Color(0xFFE0C9F3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Vazir',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
