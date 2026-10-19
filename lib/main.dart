import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_client.dart';
import 'data/http_forecast_repository.dart';
import 'screens/islands_screen.dart';
import 'state/forecast_notifier.dart';

const clientId = String.fromEnvironment('CLIENT_ID');
const clientSecret = String.fromEnvironment('CLIENT_SECRET');

/// TODO 1: choose the repository here: the real one or a fake.
/// TODO 2: favourite islands, shared by two screens.
void main() {
  final api = ApiClient(clientId: clientId, clientSecret: clientSecret);
  final repository = HttpForecastRepository(api);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ForecastNotifier(repository)..load(),
      child: MaterialApp(
        title: 'Tempo Açores',
        theme: ThemeData(colorSchemeSeed: Colors.teal),
        home: const IslandsScreen(),
      ),
    ),
  );
}
