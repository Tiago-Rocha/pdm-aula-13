# pdm-aula-13 · Layered architecture and state management

Repository for lesson 13 of PDM (Mobile Device Programming), CTeSP DAW, ESTA, University of the Azores, 2026/27.

Tempo Açores with the islands from the course API (`https://api-pdm.sublimecipher.com`).

## Before and after

- Branch `antes` (before): one screen does everything. `lib/islands_screen.dart` knows the URL, turns the JSON into `Island` objects, keeps the loading, error and data states in a `FutureBuilder` and draws the list.
- Branch `main` (after): the same app, with each job in its own file and each kind of file in its own folder. This is where you start.

```
lib/
  main.dart                          puts the pieces together
  models/
    island.dart                      Island
    forecast.dart                    WeatherType, DayForecast, Forecast
  data/
    api_client.dart                  HTTP: token, headers, status codes, JSON
    forecast_repository.dart         what the app can ask for (the interface)
    http_forecast_repository.dart    how: asks the API, returns Island
  state/
    forecast_notifier.dart           loading, error and islands
  screens/
    islands_screen.dart              draws the state, calls load()
```

Each layer only knows the one below it: the screen knows the notifier, the notifier knows the repository, the repository knows the `ApiClient`. Only `main.dart` creates the pieces.

To see the whole change in one place: `git diff antes main`.

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

There is one branch per step. `main` is the starting point; `passo-2` is the final state.

| Step | Branch | What you do | In the app |
|---|---|---|---|
| 1 | `passo-1` | `lib/data/fake_forecast_repository.dart`: `FakeForecastRepository`, the same interface with three fixed islands and no network. `main` picks the fake with `--dart-define=FAKE=true` (`TODO 1`). | Three islands after one second, with no credentials. With `fail: true`, the error screen. |
| 2 | `passo-2` | `lib/state/favorites_notifier.dart`, `lib/widgets/favorite_button.dart` and `lib/screens/favorites_screen.dart`: favourite islands kept in memory and shared by two screens, with a `MultiProvider` (`TODO 2`). | A star on each island, a counter in the top bar and a "Favoritas" screen. |

To run with the fake from step 1 onwards:

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

API documentation: https://api-pdm.sublimecipher.com/docs

Teacher's content licensed CC BY-NC-SA 4.0.
