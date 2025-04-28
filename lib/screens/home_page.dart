import 'package:darmajgar_sabz/screens/plants_page.dart';
import 'package:flutter/material.dart';
import 'diseases_page.dart';
import 'favorite_page.dart';
import 'plants_page.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

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
          const CustomSearchBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabButton('گیاهان', 0),
              _buildTabButton('امراض', 1),
              _buildTabButton('علاقه مندی ها', 2),
            ],
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        ],
        onTap: (index) {
          if (index == 1) {
            themeProvider.toggleTheme();
          }
        },
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
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
          color: isSelected ? Colors.deepPurple : Colors.transparent,
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

  Widget _buildContent() {
    if (selectedTab == 0) {
      return  PlantsScreen();
    } else if (selectedTab == 1) {
      return  DiseasesScreen();
    } else {
      return  FavoritesScreen();
    }
  }
}