part of '../main.dart';

class HomepageViewModel extends ChangeNotifier {
  int? _latestSleepScore;

  int? get latestSleepScore => _latestSleepScore;

  /// Convenience getters for the View (keeps UI logic out of the View).
  String get sleepScoreTitle =>
      _latestSleepScore == null ? 'No previous sessions' : 'Latest sleep score';

  String get sleepScoreValueText =>
      _latestSleepScore == null ? '__' : _latestSleepScore.toString();

  /// Alias used by the View when the user requests a refresh.
  Future<void> refresh() => loadLatestSleepScore();

  Future<void> loadLatestSleepScore() async {
    // Fremtidig kode (når databasen kendes)
    // final session = await _DB.getLatestSleepSession();

    // Når session er deklareret
    // _latestSleepScore = session?.sleepScore;

    notifyListeners();
  }

  /// Midlertidig helper, så du kan teste UI'et uden database.
  /// (Kald fx `setLatestSleepScore(82)` eller `setLatestSleepScore(null)`.)
  void setLatestSleepScore(int? value) {
    _latestSleepScore = value;
    notifyListeners();
  }
}
