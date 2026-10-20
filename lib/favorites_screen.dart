import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorites_notifier.dart';
import 'forecast_notifier.dart';
import 'favorite_button.dart';

/// The favourite islands. Reads two notifiers.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesNotifier>();
    final islands = context
        .watch<ForecastNotifier>()
        .islands
        .where((island) => favorites.contains(island.id))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritas')),
      body: islands.isEmpty
          ? const Center(child: Text('Ainda não há ilhas favoritas.'))
          : ListView(
              children: [
                for (final island in islands)
                  ListTile(
                    title: Text(island.name),
                    trailing: FavoriteButton(islandId: island.id),
                  ),
              ],
            ),
    );
  }
}
