import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../home_screen.dart';

class PlantDetailsScreen extends StatefulWidget {
  final String docId; // شناسه مستند گیاه

  const PlantDetailsScreen({super.key, required this.docId});

  @override
  State<PlantDetailsScreen> createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  int selectedIndex = 0;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFE1BEE7),
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFE1BEE7),
      title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('darmanegeyahi') // نام کالکشن گیاهان
              .doc(widget.docId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('نام گیاه پیدا نشد');
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final title = data['name'] ?? 'نام گیاه';

            return Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            );
          },
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('darmanegeyahi').doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('داده‌ای یافت نشد.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final imageUrl = data['image'] ?? 'https://via.placeholder.com/150';
          final appearance = data['appearance'] ?? 'ناموجود';
          final benefits = data['benefits'] ?? 'ناموجود';
          final usage = data['usage'] ?? 'ناموجود';
          final sideEffects = data['sideEffects'] ?? 'ناموجود';

          return Column(
            children: [
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[850] : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: SingleChildScrollView(
                      key: ValueKey<int>(selectedIndex),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.topRight,
                          child: selectedIndex == 0
                              ? Text(
                            'مشخصات ظاهری: $appearance\n\nخواص درمانی: $benefits',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          )
                              : selectedIndex == 1
                              ? Text(
                            'روش استفاده: $usage',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          )
                              : selectedIndex == 2
                              ? Text(
                            'اضرار: $sideEffects',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          )
                              : Container(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    tabButton(Icons.info, 0),
                    const SizedBox(width: 12),
                    tabButton(Icons.tag_faces, 1),
                    const SizedBox(width: 12),
                    tabButton(Icons.favorite, 2),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedTab,
        onTabSelected: (index) {
          if (index == 1) {
            themeProvider.toggleTheme();
          } else {
            if (index == 0 || index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(initialTab: index),
                ),
              );
            }
            setState(() {
              selectedTab = index;
            });
          }
        },
      ),
    );
  }
Widget tabButton(IconData icon, int index) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple[300] : Colors.purple[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
          size: 28,
        ),
      ),
    );
  }
}


