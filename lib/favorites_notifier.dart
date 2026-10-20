import 'package:flutter/foundation.dart';

/// Favourite islands, in memory. Shared by two screens.
class FavoritesNotifier extends ChangeNotifier {
  final Set<String> _ids = {};

  int get count => _ids.length;
  bool contains(String islandId) => _ids.contains(islandId);

  void toggle(String islandId) {
    if (!_ids.remove(islandId)) _ids.add(islandId);
    notifyListeners();
  }
}
