part of LukOjeApp;

class MovesenseDev extends MovesenseDevice {
  MovesenseDev._();
  
  static final MovesenseDev _instance = MovesenseDev._();

  factory MovesenseDev(){
    return _instance;
  }

  void setAdress(String macA){
    address = macA;
  }
  @override
  Future<void> connect() async {
    super.connect();
    
    // Wait for the device to be fully connected before retrieving battery status
    await statusEvents.firstWhere(
      (status) => status == DeviceConnectionStatus.connected,
      orElse: () => DeviceConnectionStatus.disconnected,
    );
    
    if (status == DeviceConnectionStatus.connected) {
      await getBatteryStatus().then(
        (battery) => debugPrint('>> Battery level: ${battery.name}'));
    }
  }
  // other model methods are from superclass MovesenseDevice
}