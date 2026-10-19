import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/favorites_notifier.dart';

/// The star of one island. Used by both screens.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.islandId});

  final String islandId;

  @override
  Widget build(BuildContext context) {
    final favorite = context.watch<FavoritesNotifier>().contains(islandId);
    return IconButton(
      icon: Icon(favorite ? Icons.star : Icons.star_border),
      onPressed: () => context.read<FavoritesNotifier>().toggle(islandId),
    );
  }
}
