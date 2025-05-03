import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final int selectedTab;

  const CustomSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.selectedTab,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _onChanged(String value) {
    widget.onSearchChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.selectedTab == 0
              ? 'جستجوی گیاه...'
              : widget.selectedTab == 1
              ? 'جستجوی بیماری...'
              : '',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: _onChanged,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
