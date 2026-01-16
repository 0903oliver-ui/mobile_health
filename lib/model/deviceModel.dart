part of LukOjeApp;




class MovesenseDev extends MovesenseDevice {
  MovesenseDev(String address) : super(address: address);

  @override
  Future<void> connect() async {
    super.connect();
    
    // Wait for the device to be fully connected before retrieving battery status
    int attempts = 0;
    while (status != DeviceConnectionStatus.connected && attempts < 10) {
      await Future.delayed(Duration(seconds: 1));
      attempts++;
    }
    
    if (status == DeviceConnectionStatus.connected) {
      await getBatteryStatus().then(
        (battery) => debugPrint('>> Battery level: ${battery.name}'));
    }
  }
  // other model methods are from superclass MovesenseDevice
}