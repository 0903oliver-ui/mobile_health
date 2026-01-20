part of LukOjeApp;

class HomepageViewModel extends ChangeNotifier {
  MovesenseDev? _device;

  HomepageViewModel({MovesenseDev? device}) : _device = device;

  MovesenseDev? get device => _device;

  void setDevice(MovesenseDev? device) {
    _device = device;
    notifyListeners();
  }

  int? _latestSleepScore;
  int? get latestSleepScore => _latestSleepScore;

  Stream<MovesenseHR> get heartRateStream => _device?.hr ?? Stream.empty();

  String get sleepScoreTitle =>
      _latestSleepScore == null ? 'No previous sessions' : 'Latest sleep score';

  String get sleepScoreValueText =>
      _latestSleepScore == null ? '__' : _latestSleepScore.toString();

  Future<void> refresh() => loadLatestSleepScore();

  Future<void> loadLatestSleepScore() async {
    notifyListeners();
  }

  void setLatestSleepScore(int? value) {
    _latestSleepScore = value;
    notifyListeners();
  }

  SleepScreenViewModel createSleepSessionViewModel() {
    final dev = _device;
    if (dev == null || dev.status != DeviceConnectionStatus.connected) {
      throw StateError('Device not connected');
    }
    final sessionModel = SleepSessionModel(device: dev);
    final vm = SleepScreenViewModel(session: sessionModel);
    return vm;
  }
}
