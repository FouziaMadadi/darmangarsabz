import 'package:flutter/material.dart';
import '../models/favorite.dart';
import '../widgets/favorite_item.dart';

class FavoritesScreen extends StatelessWidget {
   FavoritesScreen({super.key});

  final List<FavoriteItem> favorites = [
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: favorites.length,
      itemBuilder: (ctx, index) {
        return FavoriteListItem(favorite: favorites[index]);
      },
    );
  }
}