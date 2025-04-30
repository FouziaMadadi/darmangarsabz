import 'package:flutter/material.dart';
import '../models/disease.dart';
import '../widgets/disease_item.dart';

class DiseasesScreen extends StatelessWidget {
   DiseasesScreen({super.key});

  final List<Disease> diseases =  [
    Disease(name: 'آگزما', imageUrl: 'assets/images/diseases/agzema.jpg'),
    Disease(name: 'آکنه', imageUrl: 'assets/images/diseases/akenna.jpg'),
    Disease(name: 'آلزایمر', imageUrl: 'assets/images/diseases/alzaymer.jpg'),
    Disease(name: 'آسم', imageUrl: 'assets/images/diseases/asm.jpg'),
    Disease(name: 'مشکلات تنفسی', imageUrl: 'assets/images/diseases/breath.jpg'),
    Disease(name: 'سرفه', imageUrl: 'assets/images/diseases/sorfa.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: diseases.length,
      itemBuilder: (ctx, index) {
        return DiseaseItem(disease: diseases[index]);
      },
    );
  }
}