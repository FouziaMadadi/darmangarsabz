import 'package:flutter/material.dart';
import '../models/herbs.dart';
import '../widgets/plant_item.dart';

class PlantsScreen extends StatelessWidget {
   PlantsScreen({super.key});

  final List<Plant> plants = [
    Plant(name: 'نعناع', imageUrl: 'assets/images/naanaa.jpg'),
    Plant(name: 'آلوورا', imageUrl: 'assets/images/alovera.jpg'),
    Plant(name: 'آنغوزه', imageUrl: 'assets/images/anghoza.jpg'),
    Plant(name: 'آکیناسا', imageUrl: 'assets/images/akinasa.jpg'),
    Plant(name: 'بابونه', imageUrl: 'assets/images/babona.jpg'),
    Plant(name: 'اسفرزه', imageUrl: 'assets/images/esfarza.jpg'),
    Plant(name: 'اسپند', imageUrl: 'assets/images/espand.jpg'),
    Plant(name: 'جوانی بادیان', imageUrl: 'assets/images/javani_badian.jpg'),
    Plant(name: 'گل کاوزبان', imageUrl: 'assets/images/gol_gavzaban.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: plants.length * 3,
      itemBuilder: (ctx, index) {
        final plant = plants[index % plants.length];
        return PlantItem(plant: plant);
      },
    );
  }
}