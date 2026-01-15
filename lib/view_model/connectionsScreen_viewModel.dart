part of '../main.dart';

class ConnectionsscreenViewModel extends ChangeNotifier {
  String adress = '';

  void setAdress(String macA){
    adress = macA;
    notifyListeners();
  }
}