
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseasesScreen extends StatelessWidget {
  final String searchText;
  const DiseasesScreen({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('alamat_bimari').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('داده‌ای یافت نشد.'));
        }

        // فیلتر بر اساس جستجو
        final bimariha = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final name = data['name']?.toString().toLowerCase() ?? '';
          return name.contains(searchText.toLowerCase());
        }).toList();

        if (bimariha.isEmpty) {
          return const Center(child: Text('هیچ بیماری مطابق جستجو پیدا نشد.'));
        }

        return ListView.builder(
          itemCount: bimariha.length,
          itemBuilder: (context, index) {
            final bimari = bimariha[index];
            final data = bimari.data() as Map<String, dynamic>;
            final imageUrl = data['image'] ?? 'assets/diseases/default.jpg';
            final name = data['name'] ?? 'نام نامشخص';

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(name),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('توضیحات: ${data['description'] ?? 'موجود نیست'}'),
                          const SizedBox(height: 8),
                          Text('گیاهان موثر: ${data['related-plants'] ?? 'موجود نیست'}'),
                          const SizedBox(height: 8),
                          Text('روش استفاده: ${data['usage'] ?? 'موجود نیست'}'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('بستن'),
                      ),
                    ],
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                      child: Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/diseases/default.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

