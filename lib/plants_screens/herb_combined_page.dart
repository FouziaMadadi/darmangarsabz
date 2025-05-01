import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HerbCombinedPage extends StatelessWidget {
  const HerbCombinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('درمانگر سبز'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('darmanegeyahi').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('هیچ گیاهی ثبت نشده است.'));
          }

          final plants = snapshot.data!.docs;

          return ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              final imagePath =
                  (plant.data() as Map<String, dynamic>).containsKey('image') &&
                          (plant['image'] as String).isNotEmpty
                      ? plant['image']
                      : 'assets/images/default.jpg';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(imagePath),
                  ),
                  title: Text(plant['name'] ?? 'نام نامشخص'),
                  subtitle:
                      Text(plant['generalInfo'] ?? 'معلومات عمومی موجود نیست'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(plant['name'] ?? ''),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'مشخصات ظاهری: ${plant['appearance'] ?? 'ناموجود'}'),
                              const SizedBox(height: 8),
                              Text(
                                  'خواص درمانی: ${plant['benefits'] ?? 'ناموجود'}'),
                              const SizedBox(height: 8),
                              Text(
                                  'روش استفاده: ${plant['usage'] ?? 'ناموجود'}'),
                              const SizedBox(height: 8),
                              Text(
                                  'اضرار: ${plant['sideEffects'] ?? 'ناموجود'}'),
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
