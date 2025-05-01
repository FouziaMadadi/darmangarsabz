import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست بیماری‌ها'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('alamat_bimari').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('هیچ بیماری ثبت نشده است.'));
          }

          final bimariha = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bimariha.length,
            itemBuilder: (context, index) {
              final bimari = bimariha[index];
              final data = bimari.data() as Map<String, dynamic>;

              final imagePath = data.containsKey('image') && data['image'] != ''
                  ? data['image']
                  : 'assets/diseases/default.jpg';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(imagePath),
                  ),
                  title: Text(data['name'] ?? 'نام نامشخص'),
                  subtitle: Text(data.containsKey('description')
                      ? data['description']
                      : 'توضیحات موجود نیست'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(data['name'] ?? ''),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'توضیحات: ${data.containsKey('description') ? data['description'] : 'موجود نیست'}'),
                              const SizedBox(height: 8),
                              Text(
                                  'گیاهان موثر: ${data.containsKey('related-plants') ? data['related-plants'] : 'موجود نیست'}'),
                              const SizedBox(height: 8),
                              Text(
                                  'روش استفاده: ${data.containsKey('usage') ? data['usage'] : 'موجود نیست'}'),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
