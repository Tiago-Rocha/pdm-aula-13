# pdm-aula-13 · Layered architecture and state management

Repository for lesson 13 of PDM (Mobile Device Programming), CTeSP DAW, ESTA, University of the Azores, 2026/27.

Tempo Açores with the islands from the course API (`https://api-pdm.sublimecipher.com`). On `main` the islands screen does everything by itself: it calls the `ApiClient`, knows the URL, turns the JSON into `Island` objects and keeps the loading, error and data states in a `FutureBuilder`. During the lesson you move each of those jobs to its own layer:

- `lib/models.dart`: `Island`, `DayForecast` and `Forecast` with `fromJson`. Not changed.
- `lib/api_client.dart`: `ApiClient`, which gets the token, sends the request, checks the status code and decodes the JSON. Not changed.
- `lib/islands_screen.dart`: the screen you clean up, following the comments `TODO 1` and `TODO 2`.
- `lib/main.dart`: where the pieces are put together (`TODO 3` and `TODO 4`).

## Getting started

```bash
git clone https://github.com/Tiago-Rocha/pdm-aula-13.git
cd pdm-aula-13
flutter pub get
```

Your `clientId` and `clientSecret` are in issue #1 of your `pdm-miniprojeto` repository. They go on the command line, never in the code and never in git:

```bash
flutter run -d chrome --dart-define=CLIENT_ID=pdm-ab12cd --dart-define=CLIENT_SECRET=your-secret
```

You should see the list of islands, each with its photo. In the terminal where `flutter run` is running, `r` is hot reload, `R` is hot restart and `q` quits. Open a second terminal for the `git` commands.

If the screen shows `401: clientId ou clientSecret errados.`, the two `--dart-define` are missing or wrong. Pressing F5 in VS Code does not pass them.

## The steps

There is one branch per step. `main` is the starting point; `passo-4` is the final state.

| Step | Branch | What you do | In the app |
|---|---|---|---|
| 1 | `passo-1` | `lib/forecast_repository.dart`: the `ForecastRepository` interface and `HttpForecastRepository`, which receives the `ApiClient` in its constructor. The screen receives the repository and no longer knows URLs or JSON. | The same islands as before. |
| 2 | `passo-2` | `lib/forecast_notifier.dart`: `ForecastNotifier`, a `ChangeNotifier` with `isLoading`, `error`, `islands` and `load()`. A `ChangeNotifierProvider` above the `MaterialApp`; `IslandsScreen` becomes a `StatelessWidget` that reads the notifier with `context.watch`. | The same islands; "Tentar de novo" calls `load()`. |
| 3 | `passo-3` | `lib/fake_forecast_repository.dart`: `FakeForecastRepository`, with three islands and no network. `main` picks the fake with `--dart-define=FAKE=true`. | Three islands after one second, with no credentials. With `fail: true`, the error screen. |
| 4 | `passo-4` | `lib/favorites_notifier.dart` and `lib/favorites_screen.dart`: favourite islands kept in memory and shared by two screens, with a `MultiProvider`. | A star on each island, a counter in the top bar and a "Favoritas" screen. |

To run with the fake from step 3 onwards:

```bash
flutter run -d chrome --dart-define=FAKE=true
```

## Syncing with the lesson

At the end of each step, finished or not, run the commands on the slide, one at a time, in the second terminal. They put aside what you wrote and give you the code of that step:

```bash
git stash -u
git checkout passo-1
flutter pub get
```

Then press `R` in the `flutter run` terminal (hot restart).

To go back to the start: `git stash -u` and then `git checkout main`.

## Homework

On `passo-4`, add the forecast of one island: tapping an island opens a screen with its five days. Follow the same layers: `fetchForecast` already exists in `HttpForecastRepository`; write an `IslandForecastNotifier` and a screen that only knows the notifier. This notifier belongs to a single island, so its `ChangeNotifierProvider` goes inside the route, around the new screen. To create it there you need the repository: add it to the `MultiProvider` with `Provider<ForecastRepository>.value(value: repository)`.

API documentation: https://api-pdm.sublimecipher.com/docs

Teacher's content licensed CC BY-NC-SA 4.0.
