import 'package:mobile_health/model/sensorModel.dart';

class Movesense{
  String id;
  bool isConnected = false;
  List<Sensor> sensors = [];
  Movesense(this.id);
}