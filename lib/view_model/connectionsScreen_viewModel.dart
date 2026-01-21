part of LukOjeApp;

class ConnectionsscreenViewModel extends ChangeNotifier {
  String adress = '';
  MovesenseDev? device;

  /// Broadcast stream så både ConnectionsScreen og LoadingScreen kan lytte samtidig.
  Stream<DeviceConnectionStatus>? statusEvents;

  void setAdress(String macA) {
    adress = macA
        .replaceAllMapped(RegExp(r'.{1,2}'), (match) => '${match.group(0)}:')
        .replaceAll(RegExp(r':$'), '');

    // Opret device (samme som før)
    device = MovesenseDev();
    device!.setAdress(adress);

    // VIGTIGT: gør statusEvents multi-subscriber safe
    statusEvents = device!.statusEvents.asBroadcastStream();

    notifyListeners();
  }


}
