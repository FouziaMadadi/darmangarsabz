// import 'package:flutter/material.dart';
// import 'diseases_screen.dart';
// import 'favorites_screen.dart';
// import 'plants_screen.dart';
// import '../providers/theme_provider.dart';
// import 'package:provider/provider.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int selectedTab = 0;
//   String searchQuery = ''; // متغیر جدید برای ذخیره سرچ
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: const Text('درمانگر سبز',
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // نوار جستجو در بالای صفحه اصلی
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'اینجا جستجو نمایید',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   searchQuery = value.trim();
//                   selectedTab = 0; // با هر بار تایپ کردن لیست گیاه نیز اپدیت میشود
//                 });
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildTabButton('گیاهان', 0),
//               _buildTabButton('امراض', 1),
//               _buildTabButton('علاقه مندی ها', 2),
//             ],
//           ),
//           Expanded(
//             child: IndexedStack(
//               index: selectedTab,
//               children: [
//                 PlantsScreen(searchQuery: searchQuery), // پاس دادن سرچ به PlantsScreen
//                 DiseasesScreen(),
//                 FavoritesScreen(),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedTab,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
//         ],
//         onTap: (index) {
//           if (index == 1) {
//             themeProvider.toggleTheme();
//           } else {
//             setState(() {
//               selectedTab = index == 0 ? 0 : 2;
//             });
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildTabButton(String title, int index) {
//     bool isSelected = selectedTab == index;
//     bool isMainTab = index == 0 || index == 1; // گیاهان و امراض
//
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           selectedTab = index;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Colors.deepPurple
//               : isMainTab
//               ? Colors.deepPurple.shade100
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
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
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  String searchText = '';

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
            });
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
