
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'diseases/details_screen.dart';

class DiseasesScreen extends StatefulWidget {
  final String searchText;
  const DiseasesScreen({super.key, required this.searchText});

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFE5D5F4),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('alamat_bimari').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('داده‌ای یافت نشد.'));
          }

          final bimariha = snapshot.data!.docs.where((doc) {
            try {
              final data = doc.data() as Map<String, dynamic>;
              final name = data['name']?.toString().toLowerCase() ?? '';
              return name.contains(widget.searchText.toLowerCase());
            } catch (e) {
              return false;
            }
          }).toList();

          if (bimariha.isEmpty) {
            return const Center(child: Text('هیچ بیماری مطابق جستجو پیدا نشد.'));
          }

          return ListView.builder(
            itemCount: bimariha.length,
            itemBuilder: (context, index) {
              try {
                final bimari = bimariha[index];
                final data = bimari.data() as Map<String, dynamic>;
                final imageUrl = data['image']?.toString() ?? 'assets/diseases/default.jpg';
                final name = data['name']?.toString() ?? 'نام نامشخص';
                final isSelected = selectedIndex == index;
                final isImageRight = index.isEven;

                return diseaseCard(
                  name: name,
                  imageUrl: imageUrl,
                  isSelected: isSelected,
                  isImageRight: isImageRight,
                  isDark: isDark,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(docId: bimari.id),
                      ),
                    );
                  },
                );
              } catch (e) {
                return const ListTile(title: Text('خطا در دریافت اطلاعات'));
              }
            },
          );
        },
      ),
    );
  }

  Widget diseaseCard({
    required String name,
    required String imageUrl,
    required bool isSelected,
    required bool isImageRight,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final Color normalCardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color selectedCardColor = const Color(0xFF5E5166);
    final Color normalTextColor = isDark ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 4,
        color: isSelected ? selectedCardColor : normalCardColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: isImageRight
                ? _buildRowContent(name, imageUrl, isSelected, true, normalTextColor)
                : _buildRowContent(name, imageUrl, isSelected, false, normalTextColor),
          ),
        ),
      ),
    );
  }
  List<Widget> _buildRowContent(
      String name, String imageUrl, bool isSelected, bool imageRight, Color textColor) {
    final imageWidget = CircleAvatar(
      radius: 30,
      backgroundImage: imageUrl.startsWith('http')
          ? NetworkImage(imageUrl)
          : AssetImage(imageUrl) as ImageProvider,
      backgroundColor: Colors.grey[200],
    );

    final textWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );

    return imageRight
        ? [textWidget, imageWidget]
        : [imageWidget, textWidget];
  }
}






