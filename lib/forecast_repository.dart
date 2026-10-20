import 'forecast.dart';
import 'island.dart';

/// What the app can ask for. The screens only see this.
abstract class ForecastRepository {
  Future<List<Island>> fetchIslands();
  Future<Forecast> fetchForecast(String islandId);
}
