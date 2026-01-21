part of LukOjeApp;

/// State Pattern interface
abstract class SleepSessionState {
  Future<void> start(SleepScreenViewModel vm);
  Future<SleepScoreResult> stop(SleepScreenViewModel vm);
}

/// Idle: ikke startet endnu
class IdleSleepSessionState implements SleepSessionState {
  @override
  Future<void> start(SleepScreenViewModel vm) async {
    await vm._session.start();
    vm._state = RunningSleepSessionState();
    vm.notifyListeners();
  }

  @override
  Future<SleepScoreResult> stop(SleepScreenViewModel vm) {
    throw StateError('Cannot stop: session not started');
  }
}

/// Running: indsamler data
class RunningSleepSessionState implements SleepSessionState {
  @override
  Future<void> start(SleepScreenViewModel vm) async {
    // no-op
  }

  @override
  Future<SleepScoreResult> stop(SleepScreenViewModel vm) async {
    vm._state = StoppingSleepSessionState();
    vm.notifyListeners();

    final result = await vm._session.stopAndCompute();

    vm._state = StoppedSleepSessionState(result);
    vm._lastResult = result;
    vm.notifyListeners();
    return result;
  }
}

/// Stopping: midlertidig “busy”
class StoppingSleepSessionState implements SleepSessionState {
  @override
  Future<void> start(SleepScreenViewModel vm) {
    throw StateError('Cannot start: stopping in progress');
  }

  @override
  Future<SleepScoreResult> stop(SleepScreenViewModel vm) {
    throw StateError('Stop already in progress');
  }
}

/// Stopped: færdig
class StoppedSleepSessionState implements SleepSessionState {
  final SleepScoreResult result;
  StoppedSleepSessionState(this.result);

  @override
  Future<void> start(SleepScreenViewModel vm) {
    throw StateError('Cannot restart: create a new session');
  }

  @override
  Future<SleepScoreResult> stop(SleepScreenViewModel vm) async => result;
}

class SleepScreenViewModel extends ChangeNotifier {
  SleepScreenViewModel({required SleepSessionModel session})
      : _session = session,
        _state = IdleSleepSessionState();

  final SleepSessionModel _session;

  SleepSessionState _state;
  SleepScoreResult? _lastResult;

  bool get isRunning => _session.isRunning;
  bool get isStopping => _state is StoppingSleepSessionState;
  SleepScoreResult? get lastResult => _lastResult;

  Future<void> startSession() => _state.start(this);

  Future<SleepScoreResult> stopSession() => _state.stop(this);
}