part of '../main.dart';

class ConnectionsscreenViewModel extends ChangeNotifier {
  String adress = '';
  MovesenseDev? device;

  void setAdress(String macA){
    adress = macA.replaceAllMapped(RegExp(r'.{1,2}'), (match) => '${match.group(0)}:').replaceAll(RegExp(r':$'), '');
    // Create the domain device object here. This constructs a `MovesenseDev`
    // (subclass of `MovesenseDevice`) which exposes `statusEvents` and `hr` streams.
    // The view must rebuild to attach StreamBuilders to the newly created device.
    device = MovesenseDev(adress);
    notifyListeners(); // Notify UI (ListenableBuilder) to rebuild and attach streams
  }
}