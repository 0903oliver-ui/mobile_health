part of '../main.dart';

class ConnectionsscreenViewModel extends ChangeNotifier {
  String adress = '';
  MovesenseDev? device;

  

  void setAdress(String macA){
    adress = macA.replaceAllMapped(RegExp(r'.{1,2}'), (match) => '${match.group(0)}:').replaceAll(RegExp(r':$'), '');
    device = MovesenseDev(adress);
  }
}