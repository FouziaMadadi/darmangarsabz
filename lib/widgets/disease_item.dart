import 'package:flutter/material.dart';
import '../models/disease.dart';

class DiseaseItem extends StatelessWidget {
  final Disease disease;

  const DiseaseItem({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(Icons.local_florist), // به جای عکس، آیکون گیاه
        //Image.asset(disease.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(disease.name),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}