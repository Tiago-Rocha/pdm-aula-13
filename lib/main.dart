import 'package:flutter/material.dart';

import 'api_client.dart';
import 'islands_screen.dart';

const clientId = String.fromEnvironment('CLIENT_ID');
const clientSecret = String.fromEnvironment('CLIENT_SECRET');

/// TODO 3: choose the repository here: the real one or a fake.
/// TODO 4: favourite islands, shared by two screens.
void main() {
  final api = ApiClient(clientId: clientId, clientSecret: clientSecret);
  runApp(
    MaterialApp(
      title: 'Tempo Açores',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: IslandsScreen(api: api),
    ),
  );
}
