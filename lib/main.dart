import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api_client.dart';
import 'fake_forecast_repository.dart';
import 'forecast_repository.dart';
import 'http_forecast_repository.dart';
import 'islands_screen.dart';
import 'favorites_notifier.dart';
import 'forecast_notifier.dart';

const clientId = String.fromEnvironment('CLIENT_ID');
const clientSecret = String.fromEnvironment('CLIENT_SECRET');
const useFake = bool.fromEnvironment('FAKE'); // --dart-define=FAKE=true

void main() {
  final ForecastRepository repository = useFake
      ? FakeForecastRepository()
      : HttpForecastRepository(
          ApiClient(clientId: clientId, clientSecret: clientSecret),
        );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ForecastNotifier(repository)..load(),
        ),
        ChangeNotifierProvider(create: (_) => FavoritesNotifier()),
      ],
      child: MaterialApp(
        title: 'Tempo Açores',
        theme: ThemeData(colorSchemeSeed: Colors.teal),
        home: const IslandsScreen(),
      ),
    ),
  );
}
