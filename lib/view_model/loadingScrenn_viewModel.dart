part of LukOjeApp;

class LoadingscreenViewmodel extends ChangeNotifier {
  LoadingscreenViewmodel({
    required this.device,
    required this.statusEvents,
  });

  final MovesenseDev device;

  /// MUST be broadcast (or otherwise multi-listener safe).
  final Stream<DeviceConnectionStatus> statusEvents;

  bool _hasNavigated = false;

  /// Returns true the first time it is called; false afterwards.
  /// Used to prevent multiple pushReplacement calls when stream rebuilds.
  bool tryMarkNavigated() {
    if (_hasNavigated) return false;
    _hasNavigated = true;
    return true;
  }
}