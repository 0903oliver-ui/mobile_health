part of LukOjeApp;

class SleepData {
  DateTime timestamp = DateTime.now();
  List<int> hr = [];
  List<int> rr = [];
  List<int> lux = [];
  List<MovesenseDeviceState> events = [];

  
  SleepData(this.hr, this.rr, this.lux);
}