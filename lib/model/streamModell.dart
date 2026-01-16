part of LukOjeApp;

//'0C:8C:DC:1B:23:16'
class StreamModel{
  final MovesenseDev device;
  final Sensor lightSensor = LightSensor();

  StreamSubscription<MovesenseHR>? hrSubscription;
  StreamSubscription<String>? lightSubscription;

  StreamModel(this.device){
    if(device.status == DeviceConnectionStatus.connected){
      lightSensor.start();
      // Subscribe to the device's HR stream here. This establishes a
      // listener to the domain stream `device.hr` and will receive
      // `MovesenseHR` samples as they arrive from the device.
      hrSubscription = device.hr.listen((hr) {
        // TEMPORARY: currently we just log HR samples. Replace with
        // persistence or processing logic as needed.
        //debugPrint('Heart Rate: ${hr.average}, r-r: ${hr.rr}');
      });
    }else{
      /// Throws an exception when the device is not connected.
      /// 
      /// This exception will halt execution and must be caught by a try-catch block
      /// or it will propagate up the call stack, terminating the current function
      /// and any subsequent code in that block will not execute.
      throw Exception('Device not connected');
    }
  }
}