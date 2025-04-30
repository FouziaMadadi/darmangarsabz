import 'package:flutter/material.dart';
import '../models/favorite.dart';

class FavoriteListItem extends StatelessWidget {
  final FavoriteItem favorite;

  const FavoriteListItem({super.key, required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        //leading: Icon(Icons.local_florist), // به جای عکس، آیکون گیاه
        leading: Image.asset(favorite.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(favorite.name),
      ),
    );
  }
}