import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'diseases/details_screen.dart';

class DiseasesScreen extends StatelessWidget {
  final String searchText;
  const DiseasesScreen({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('alamat_bimari').snapshots(),
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
            return name.contains(searchText.toLowerCase());
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
              final imageUrl =
                  data['image']?.toString() ?? 'assets/diseases/default.jpg';
              final name = data['name']?.toString() ?? 'نام نامشخص';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(docId: bimari.id),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16)),
                        child: imageUrl.startsWith('http')
                            ? Image.network(
                                imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset('assets/diseases/default.jpg',
                                        width: 100, height: 100),
                              )
                            : Image.asset(imageUrl,
                                width: 100, height: 100, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } catch (e) {
              return const ListTile(title: Text('خطا در دریافت اطلاعات'));
            }
          },
        );
      },
    );
  }
}
