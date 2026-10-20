import 'forecast.dart';
import 'island.dart';
import 'forecast_repository.dart';

/// Same interface, fixed data: no API and no credentials.
class FakeForecastRepository implements ForecastRepository {
  FakeForecastRepository({this.fail = false});

  final bool fail; // true: shows the error screen

  @override
  Future<List<Island>> fetchIslands() async {
    await Future.delayed(const Duration(seconds: 1)); // a slow network
    if (fail) throw Exception('Sem rede (fake)');
    return const [
      Island(id: 'corvo', name: 'Corvo', imageUrl: '$_img/corvo.jpg'),
      Island(id: 'faial', name: 'Faial', imageUrl: '$_img/faial.jpg'),
      Island(id: 'pico', name: 'Pico', imageUrl: '$_img/pico.jpg'),
    ];
  }

  @override
  Future<Forecast> fetchForecast(String islandId) {
    throw UnimplementedError(); // not used yet
  }
}

const _img = 'https://api-pdm.sublimecipher.com/static/islands';
