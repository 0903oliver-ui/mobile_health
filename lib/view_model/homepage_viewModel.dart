part of '../main.dart';

class HomepageViewModel extends ChangeNotifier {
  int? _latestSleepScore;

  int? get latestSleepScore => _latestSleepScore;

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
