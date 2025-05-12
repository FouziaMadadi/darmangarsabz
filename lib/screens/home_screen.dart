
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../screens/plants_screen.dart';
import '../screens/diseases_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/custome_drawer.dart';
import '../widgets/search_bar.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  final int initialTab;

  const HomeScreen({super.key, required this.initialTab});

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
        leading: IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
          ),
          onPressed: () {
            themeProvider.toggleTheme();
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),

      endDrawer: CustomDrawer(),

      body: Column(
        children: [
          // نوار جستجو
          CustomSearchBar(
            selectedTab: selectedTab,
            onSearchChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
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
          setState(() {
            selectedTab = index;
            searchText = '';
          });
        },
      ),
    );
  }
}







