// import 'package:flutter/material.dart';
// import '../models/disease.dart';
// import '../widgets/disease_item.dart';
//
// class DiseasesScreen extends StatelessWidget {
//    DiseasesScreen({super.key});
//
//   final List<Disease> diseases =  [
//     Disease(name: 'آگزما', imageUrl: 'assets/images/diseases/agzema.jpg'),
//     Disease(name: 'آکنه', imageUrl: 'assets/images/diseases/akenna.jpg'),
//     Disease(name: 'آلزایمر', imageUrl: 'assets/images/diseases/alzaymer.jpg'),
//     Disease(name: 'آسم', imageUrl: 'assets/images/diseases/asm.jpg'),
//     Disease(name: 'مشکلات تنفسی', imageUrl: 'assets/images/diseases/breath.jpg'),
//     Disease(name: 'سرفه', imageUrl: 'assets/images/diseases/sorfa.jpg'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(8),
//       itemCount: diseases.length,
//       itemBuilder: (ctx, index) {
//         return DiseaseItem(disease: diseases[index]);
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseasesScreen extends StatefulWidget {
  const DiseasesScreen({super.key});

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  String selectedDiseaseId = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('diseases').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('هیچ بیماری ثبت نشده است.'));
        }

        final diseases = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: diseases.length,
          itemBuilder: (context, index) {
            final disease = diseases[index];
            final diseaseId = disease.id;
            final isSelected = selectedDiseaseId == diseaseId;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDiseaseId = diseaseId;
                });
                // می‌توانید اینجا صفحه جزئیات بیماری را هم باز کنید
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios, color: Colors.grey),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        disease['name'] ?? 'نام نامشخص',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipOval(
                      child: Image.network(
                        disease['image'] ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
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
