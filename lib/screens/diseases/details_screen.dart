import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../home_screen.dart';


class DetailsScreen extends StatefulWidget {
  final String docId;

  const DetailsScreen({super.key, required this.docId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedIndex = 0;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFE1BEE7),
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFE1BEE7),
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('alamat_bimari')
              .doc(widget.docId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('نام بیماری پیدا نشد');
            }

            // دریافت عنوان از دیتابیس
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final title = data['title'] ?? 'نام بیماری';

            return Text(
              title, // نمایش عنوان بارگذاری‌شده
              style: const TextStyle(color: Colors.black, fontSize: 16),
            );
          },
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('alamat_bimari').doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('داده‌ای یافت نشد.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final imageUrl = data['image'] ?? 'https://via.placeholder.com/150';
          final generalInfo = data['description'] ?? 'معلومات موجود نیست';
          final benefits = data['usage'] ?? 'فواید موجود نیست';

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
                        child: Text(
                          selectedIndex == 0 ? generalInfo : benefits,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // تب‌ها پایین صفحه
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    tabButton(Icons.local_florist, 0),
                    const SizedBox(width: 16),
                    tabButton(Icons.local_cafe, 1),
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
                  builder: (context) => HomeScreen(initialTab: selectedTab),
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

