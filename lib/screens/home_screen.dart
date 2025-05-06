
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../screens/plants_screen.dart';
import '../screens/diseases_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/search_bar.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'package:persian_fonts/persian_fonts.dart';


class HomeScreen extends StatefulWidget {
  final int initialTab;

  const HomeScreen({super.key, required this.initialTab}); // دریافت initialTab

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late int selectedTab;
  String searchText = '';
  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'درمانگر سبز',
          style: TextStyle(
            fontFamily: 'Vazir',
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          //نوار جستجو
          CustomSearchBar(
            selectedTab: selectedTab,
            onSearchChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
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
                PlantsScreen(searchText: searchText),
                DiseasesScreen(searchText: searchText),
                FavoritesScreen(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedTab,
        onTabSelected: (index) {
          if (index == 1) {
            themeProvider.toggleTheme();
          } else {
            setState(() {
              if (index == 0) {
                if (selectedTab == 0) {
                  searchText = '';
                }
                selectedTab = 0;
              } else if (index == 2) {
                selectedTab = 2; 
              }
            }
            );
          }
        },
      ),

    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;
    final screenWidth = MediaQuery.of(context).size.width;
    final tabCount = 3;
    final horizontalPadding = 24.0;
    final totalPadding = horizontalPadding * 2;
    final totalSpacing = (tabCount - 1) * 3.0;
    final tabWidth = (screenWidth - totalPadding - totalSpacing) / tabCount;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;


    final inactiveColor = isDarkMode
        ? Colors.white
        : Colors.purple.shade200;

    final inactiveTextColor = isDarkMode
        ? Colors.black
        : Colors.white;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        width: tabWidth,
        margin: const EdgeInsets.symmetric(horizontal: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.transparent,
            width: 2,
          ),
          color: isSelected ? Colors.deepPurple : inactiveColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : inactiveTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  }
