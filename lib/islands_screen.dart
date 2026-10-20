import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorites_notifier.dart';
import 'forecast_notifier.dart';
import 'favorite_button.dart';
import 'favorites_screen.dart';

/// Draws the state of the ForecastNotifier. Knows no URLs and no JSON.
class IslandsScreen extends StatelessWidget {
  const IslandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forecast = context.watch<ForecastNotifier>(); // rebuilds on notify
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempo Açores'),
        actions: [
          Consumer<FavoritesNotifier>(
            builder: (context, favorites, child) => IconButton(
              icon: Badge(
                isLabelVisible: favorites.count > 0,
                label: Text('${favorites.count}'),
                child: const Icon(Icons.star),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              ),
            ),
          ),
        ],
      ),
      body: _body(context, forecast),
    );
  }

  Widget _body(BuildContext context, ForecastNotifier forecast) {
    if (forecast.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (forecast.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(forecast.error!),
            TextButton(
              onPressed: () => context.read<ForecastNotifier>().load(),
              child: const Text('Tentar de novo'),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: forecast.islands.length,
      itemBuilder: (context, i) => ListTile(
        leading: Image.network(forecast.islands[i].imageUrl, width: 56),
        title: Text(forecast.islands[i].name),
        trailing: FavoriteButton(islandId: forecast.islands[i].id),
      ),
    );
  }
}
