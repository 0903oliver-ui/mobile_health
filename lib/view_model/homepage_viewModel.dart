part of LukOjeApp;

class HomepageViewModel extends ChangeNotifier {
  final MovesenseDev? device;

  HomepageViewModel({this.device});

  int? _latestSleepScore;

  int? get latestSleepScore => _latestSleepScore;

  // TEMPORARY: Heart rate stream from connected device
  // Exposes the device's `hr` stream to the View layer while keeping
  // domain logic inside the ViewModel (MVVM).
  // - Returns `Stream.empty()` when no device is present to avoid nulls.
  // - TEMPORARY: this is a simple passthrough; replace with proper
  //   domain/service abstraction when persisting or processing HR data.
  Stream<MovesenseHR> get heartRateStream => device?.hr ?? Stream.empty();

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
