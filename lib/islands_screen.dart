import 'package:flutter/material.dart';

import 'api_client.dart';
import 'models.dart';

/// This screen does everything by itself: the URL, the JSON, the loading,
/// error and data states, and the drawing. It works. On main, each of
/// these jobs has its own file, in its own folder.
class IslandsScreen extends StatefulWidget {
  const IslandsScreen({super.key, required this.api});

  final ApiClient api;

  @override
  State<IslandsScreen> createState() => _IslandsScreenState();
}

class _IslandsScreenState extends State<IslandsScreen> {
  late Future<List<Island>> _islands;

  @override
  void initState() {
    super.initState();
    _islands = _load();
  }

  Future<List<Island>> _load() async {
    final list = await widget.api.get('/v1/islands') as List<dynamic>;
    return list
        .map((item) => Island.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tempo Açores')),
      body: FutureBuilder<List<Island>>(
        future: _islands,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${snapshot.error}'),
                  TextButton(
                    onPressed: () => setState(() => _islands = _load()),
                    child: const Text('Tentar de novo'),
                  ),
                ],
              ),
            );
          }
          final islands = snapshot.data!;
          return ListView.builder(
            itemCount: islands.length,
            itemBuilder: (context, i) => ListTile(
              leading: Image.network(islands[i].imageUrl, width: 56),
              title: Text(islands[i].name),
            ),
          );
        },
      ),
    );
  }
}
