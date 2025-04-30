import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlantsScreen extends StatelessWidget {
  final String searchQuery;
  const PlantsScreen({super.key, required this.searchQuery});

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

        final query = searchQuery.toLowerCase(); // به کوچیک تبدیل کن برای مقایسه
        final plants = snapshot.data!.docs.where((doc) {
          final name = (doc['name'] ?? '').toString().toLowerCase();
          final benefits = (doc['benefits'] ?? '').toString().toLowerCase();

          return name.contains(query) || benefits.contains(query);
        }).toList();

        if (plants.isEmpty) {
          return const Center(child: Text('هیچ نتیجه‌ای یافت نشد.'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // سه کارت در هر ردیف
            crossAxisSpacing: 8.0, // فاصله افقی بین کارت‌ها
            mainAxisSpacing: 8.0, // فاصله عمودی بین کارت‌ها
            childAspectRatio: 0.8, // نسبت عرض به ارتفاع برای ایجاد کارت‌های منظم
          ),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            final plant = plants[index];
            final imagePath =
            (plant.data() as Map<String, dynamic>).containsKey('image') &&
                (plant['image'] as String).isNotEmpty
                ? plant['image']
                : 'assets/images/default.jpg';

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
                  borderRadius: BorderRadius.circular(12), // گوشه‌های گرد برای زیبایی
                ),
                elevation: 4, // سایه برای عمق
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        width: 80, // عرض تصویر ثابت
                        height: 80, // ارتفاع تصویر ثابت
                        fit: BoxFit.cover, // مناسب‌ترین نحوه نمایش تصویر
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      plant['name'] ?? 'نام نامشخص',
                      style: const TextStyle(
                        fontSize: 14, // اندازه ثابت برای نام گیاه
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
//         final query = searchQuery.toLowerCase(); // به کوچیک تبدیل کن برای مقایسه
//         final plants = snapshot.data!.docs.where((doc) {
//           final name = (doc['name'] ?? '').toString().toLowerCase();
//           final benefits = (doc['benefits'] ?? '').toString().toLowerCase();
//
//           return name.contains(query) || benefits.contains(query);
//         }).toList();
//
//         if (plants.isEmpty) {
//           return const Center(child: Text('هیچ نتیجه‌ای یافت نشد.'));
//         }
//
//         return ListView.builder(
//           itemCount: plants.length,
//           itemBuilder: (context, index) {
//             final plant = plants[index];
//             final imagePath =
//             (plant.data() as Map<String, dynamic>).containsKey('image') &&
//                 (plant['image'] as String).isNotEmpty
//                 ? plant['image']
//                 : 'assets/images/default.jpg';
//
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: AssetImage(imagePath),
//                 ),
//                 title: Text(plant['name'] ?? 'نام نامشخص'),
//                 subtitle:
//                 Text(plant['generalInfo'] ?? 'معلومات عمومی موجود نیست'),
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (_) => AlertDialog(
//                       title: Text(plant['name'] ?? ''),
//                       content: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('مشخصات ظاهری: ${plant['appearance'] ?? 'ناموجود'}'),
//                             const SizedBox(height: 8),
//                             Text('خواص درمانی: ${plant['benefits'] ?? 'ناموجود'}'),
//                             const SizedBox(height: 8),
//                             Text('روش استفاده: ${plant['usage'] ?? 'ناموجود'}'),
//                             const SizedBox(height: 8),
//                             Text('اضرار: ${plant['sideEffects'] ?? 'ناموجود'}'),
//                           ],
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text('بستن'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
