// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class PlantsScreen extends StatelessWidget {
//   final String searchQuery;
//   const PlantsScreen({super.key, required this.searchQuery});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('darmanegeyahi').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('هیچ گیاهی ثبت نشده است.'));
//         }
//
//         final query = searchQuery.toLowerCase(); // نام گیاهان را گرفته و برای مقایسه به حروف کوچک تبدیل میکند
//         final plants = snapshot.data!.docs.where((doc) {
//           final name = (doc['name'] ?? '').toString().toLowerCase();
//           final benefits = (doc['benefits'] ?? '').toString().toLowerCase();
//
//           return name.contains(query) || benefits.contains(query);
//         }).toList();
//
//         if (plants.isEmpty) {
//           return const Center(child: Text('هیچ نتیجه‌ای یافت نشد.'));//در صورتیکه نتیجه برای سرچ پیدا نشد این متن را در اسکرین نمایش میدهد
//         }
//
//         return GridView.builder(
//           padding: const EdgeInsets.all(8.0),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // برای نمایش سه کارت در هر سطر
//             crossAxisSpacing: 8.0, // فاصله افقی بین کارت‌ها
//             mainAxisSpacing: 8.0, // فاصله عمودی بین کارت‌ها
//             childAspectRatio: 0.8, // نسبت عرض به ارتفاع برای ایجاد کارت‌های منظم
//           ),
//           itemCount: plants.length,
//           itemBuilder: (context, index) {
//             final plant = plants[index];
//             final imagePath =
//             (plant.data() as Map<String, dynamic>).containsKey('image') &&
//                 (plant['image'] as String).isNotEmpty
//                 ? plant['image']
//                 : 'assets/images/anghoza.jpg';
//
//             return GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (_) => AlertDialog(
//                     title: Text(plant['name'] ?? ''),
//                     content: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('مشخصات ظاهری: ${plant['appearance'] ?? 'ناموجود'}'),
//                           const SizedBox(height: 8),
//                           Text('خواص درمانی: ${plant['benefits'] ?? 'ناموجود'}'),
//                           const SizedBox(height: 8),
//                           Text('روش استفاده: ${plant['usage'] ?? 'ناموجود'}'),
//                           const SizedBox(height: 8),
//                           Text('اضرار: ${plant['sideEffects'] ?? 'ناموجود'}'),
//                         ],
//                       ),
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text('بستن'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 4,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.asset(
//                         imagePath,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       plant['name'] ?? 'نام نامشخص',
//                       style: const TextStyle(
//                         fontSize: 14, // اندازه ثابت برای نام گیاه
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlantsScreen extends StatelessWidget {
  final String searchText;
  const PlantsScreen({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('darmanegeyahi').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('هیچ گیاهی ثبت نشده است.'));
        }

        final plants = snapshot.data!.docs.where((doc){
          final data = doc.data() as Map<String, dynamic>;
          final name = data['name']?.toString().toLowerCase() ?? '';
          return name.contains(searchText.toLowerCase());
        }).toList();

        return GridView.builder(
          padding: const EdgeInsets.all(12.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // سه کارت در هر ردیف
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            final plant = plants[index];
            final data = plant.data() as Map<String, dynamic>;
            final imagePath = plant['image'];

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(plant['name'] ?? ''),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('مشخصات ظاهری: ${plant['appearance'] ?? 'ناموجود'}'),
                          const SizedBox(height: 8),
                          Text('خواص درمانی: ${plant['benefits'] ?? 'ناموجود'}'),
                          const SizedBox(height: 8),
                          Text('روش استفاده: ${plant['usage'] ?? 'ناموجود'}'),
                          const SizedBox(height: 8),
                          Text('اضرار: ${plant['sideEffects'] ?? 'ناموجود'}'),
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
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: imagePath != null && imagePath.isNotEmpty
                          ? Image.network(
                        imagePath,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/images/default.jpg',
                        width: double.infinity,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          plant['name'] ?? 'نام نامشخص',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
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
