import 'package:flutter/material.dart';
import 'diseases_screen.dart';
import 'favorites_screen.dart';
import 'plants_screen.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  String searchQuery = ''; // متغیر جدید برای ذخیره سرچ

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('درمانگر سبز'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // نوار جستجو در بالای صفحه اصلی
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'جستجوی گیاه...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.trim();
                  selectedTab = 0; // هر بار تایپ کرد، روی تب گیاهان سوئیچ کند
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabButton('گیاهان', 0),
              _buildTabButton('امراض', 1),
              _buildTabButton('علاقه مندی ها', 2),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: [
                PlantsScreen(searchQuery: searchQuery), // پاس دادن سرچ به PlantsScreen
                DiseasesScreen(),
                FavoritesScreen(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        ],
        onTap: (index) {
          if (index == 1) {
            themeProvider.toggleTheme();
          } else {
            setState(() {
              selectedTab = index == 0 ? 0 : 2;
            });
          }
        },
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    bool isMainTab = index == 0 || index == 1; // گیاهان و امراض

    return TextButton(
      onPressed: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple
              : isMainTab
              ? Colors.deepPurple.shade100
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

