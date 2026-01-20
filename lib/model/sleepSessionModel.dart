part of LukOjeApp;

class SleepScoreResult {
  final int score0to100;
  final Duration duration;

  // raw features (til debug/rapport/visualisering senere)
  final double movementRatePerHour;
  final double hrMean;
  final double? rmssdMs;
  final double luxMedian;

  SleepScoreResult({
    required this.score0to100,
    required this.duration,
    required this.movementRatePerHour,
    required this.hrMean,
    required this.rmssdMs,
    required this.luxMedian,
  });
}

/// Model-lag: indsamler data fra streams under en session og beregner rå score.
class SleepSessionModel {
  final MovesenseDev device;
  final LightSensor _lightSensor = LightSensor();

  StreamSubscription<MovesenseHR>? _hrSub;
  StreamSubscription<String>? _luxSub;
  StreamSubscription<MovesenseState>? _movementSub;

  final List<int> _hrBpm = <int>[];
  final List<int> _rrMs = <int>[];
  final List<int> _lux = <int>[];
  int _movementEvents = 0;

  DateTime? _startTime;
  DateTime? _endTime;

  bool _running = false;
  bool get isRunning => _running;

  SleepSessionModel({required this.device});

  Future<void> start() async {
    if (_running) return;
    if (device.status != DeviceConnectionStatus.connected) {
      throw Exception('Device not connected');
    }

    _running = true;
    _startTime = DateTime.now();
    _endTime = null;

    _hrBpm.clear();
    _rrMs.clear();
    _lux.clear();
    _movementEvents = 0;

    _lightSensor.start();

    _hrSub = device.hr.listen((MovesenseHR hr) {
      if (!_running) return;

      final int? bpm = hr.average;
      final int? rr = hr.rr;

      if (bpm != null && bpm > 0) _hrBpm.add(bpm);
      if (rr != null && rr > 0) _rrMs.add(rr);
    });

    _luxSub = _lightSensor.readings.listen((reading) {
      if (!_running) return;
      final v = _parseLux(reading);
      if (v != null && v >= 0) _lux.add(v);
    });

    bool lastWasMoving = false;
    _movementSub = device.getStateEvents(SystemStateComponent.movement).listen((
      MovesenseState state,
    ) {
      debugPrint('Movement state: $state');
      if (!_running) return;
      final isMoving = _isMovingState(state);
      if (isMoving && !lastWasMoving) _movementEvents += 1;
      lastWasMoving = isMoving;
    });
  }

  Future<SleepScoreResult> stopAndCompute() async {
    await stop();
    return computeRawScore();
  }

  Future<void> stop() async {
    if (!_running) return;
    _running = false;
    _endTime = DateTime.now();

    await _hrSub?.cancel();
    await _luxSub?.cancel();
    await _movementSub?.cancel();

    _hrSub = null;
    _luxSub = null;
    _movementSub = null;

    _lightSensor.stop();
    try {
      await _saveSession();
    } catch (e, st) {
      debugPrint('Failed to save sleep session: $e\n$st');
    }
  }

  Future<void> _saveSession() async {
    final db = await Database.getInstance();
    final store = db.store;
    final database = db.database;
    if (store == null || database == null) {
      throw Exception('Database not initialized');
    }

    final record = <String, dynamic>{
      'start': _startTime?.toIso8601String(),
      'end': _endTime?.toIso8601String(),
      'durationMs': _endTime != null && _startTime != null
          ? _endTime!.difference(_startTime!).inMilliseconds
          : null,
      'hr': List<int>.from(_hrBpm),
      'rr': List<int>.from(_rrMs),
      'lux': List<int>.from(_lux),
      'movementEvents': _movementEvents,
      'savedAt': DateTime.now().toIso8601String(),
    };

    // Use `add` to append a new record to the int map store.
    await store.add(database, record);
    debugPrint('Sleep session saved to database.');
  }

  SleepScoreResult computeRawScore() {
    final start = _startTime ?? DateTime.now();
    final end = _endTime ?? DateTime.now();
    final dur = end.difference(start);

    final hours = dur.inMilliseconds / (1000.0 * 60.0 * 60.0);
    final durationHours = hours <= 0 ? 1e-6 : hours;

    final movementRatePerHour = _movementEvents / durationHours;

    final hrMean = _hrBpm.isEmpty
        ? 0.0
        : _hrBpm.reduce((a, b) => a + b) / _hrBpm.length;

    final luxMedian = _medianInt(_lux).toDouble();

    final rmssd = _computeRmssdMs(_rrMs);

    // --- Normalisering / penalties (0..1) ---
    // Heuristiske designparametre (I kan justere i rapporten som "design choices")
    const movementBadPerHour = 40.0;
    const hrLow = 50.0;
    const hrHigh = 80.0;
    const luxBad = 50.0;
    const rmssdLow = 20.0;
    const rmssdHigh = 60.0;

    final pMove = _clip01(movementRatePerHour / movementBadPerHour);
    final pHr = _clip01((hrMean - hrLow) / (hrHigh - hrLow));
    final pLux = _clip01(luxMedian / luxBad);

    final bHrv = rmssd == null
        ? 0.5
        : _clip01((rmssd - rmssdLow) / (rmssdHigh - rmssdLow));

    // --- Vægte ---
    const wHrv = 0.30;
    const wM = 0.45;
    const wH = 0.35;
    const wL = 0.20;

    final pen = (wM * pMove) + (wH * pHr) + (wL * pLux);
    final x = (wHrv * bHrv) + ((1.0 - wHrv) * (1.0 - pen));
    final score = (100.0 * _clip01(x)).round();

    debugPrint('--- SleepScore debug ---');
    debugPrint('duration: $dur');
    debugPrint('movementEvents: $_movementEvents');
    debugPrint('movementRate/h: $movementRatePerHour');
    debugPrint('hrMean: $hrMean  (n=${_hrBpm.length})');
    debugPrint('rmssd: $rmssd  (rr n=${_rrMs.length})');
    debugPrint('luxMedian: $luxMedian (n=${_lux.length})');
    debugPrint('score: $score');

    return SleepScoreResult(
      score0to100: score,
      duration: dur,
      movementRatePerHour: movementRatePerHour,
      hrMean: hrMean,
      rmssdMs: rmssd,
      luxMedian: luxMedian,
    );
  }

  // ---- helpers ----
  static double _clip01(double x) => x.clamp(0.0, 1.0);

  static int? _parseLux(String reading) {
    final re = RegExp(r'(\d+)');
    final m = re.firstMatch(reading);
    if (m == null) return null;
    return int.tryParse(m.group(1) ?? '');
  }

  static bool _isMovingState(MovesenseState state) {
    // Jeres MovesenseState er ikke typed til bool i jeres kodebase.
    // Derfor bruger vi en robust string-heuristik (kan raffineres efter log).
    final s = state.toString().toLowerCase();
    if (s.contains('inactive')) return false;
    if (s.contains('false')) return false;
    if (s.contains('active')) return true;
    if (s.contains('true')) return true;
    return s.contains('movement');
  }

  static double? _computeRmssdMs(List<int> rrMs) {
    if (rrMs.length < 30) return null;
    final rr = rrMs.where((v) => v >= 300 && v <= 2000).toList();
    if (rr.length < 30) return null;

    double sumSq = 0.0;
    for (int i = 0; i < rr.length - 1; i++) {
      final d = (rr[i + 1] - rr[i]).toDouble();
      sumSq += d * d;
    }
    return sqrt(sumSq / (rr.length - 1));
  }

  static int _medianInt(List<int> values) {
    if (values.isEmpty) return 0;
    final sorted = List<int>.from(values)..sort();
    final mid = sorted.length ~/ 2;
    if (sorted.length.isOdd) return sorted[mid];
    return ((sorted[mid - 1] + sorted[mid]) / 2.0).round();
  }
}
