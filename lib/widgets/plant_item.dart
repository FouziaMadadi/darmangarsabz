import 'package:flutter/material.dart';
import '../models/herbs.dart';

class PlantItem extends StatelessWidget {
  final Plant plant;

  const PlantItem({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(Icons.local_florist), // به جای عکس، آیکون گیاه
        //Image.asset(plant.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(plant.name),
      ),
    );
  }
}