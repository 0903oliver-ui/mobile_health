part of '../main.dart';


//'0C:8C:DC:1B:23:16'
class StreamModel{
  final MovesenseDev device;
  final Sensor lightSensor = LightSensor();

  StreamSubscription<MovesenseHR>? hrSubscription;
  StreamSubscription<String>? lightSubscription;

  StreamModel(this.device){
    if(device.status == DeviceConnectionStatus.connected){
      lightSensor.start();
      hrSubscription = device.hr.listen((hr) {
      //Timer.periodic(Duration(minutes: 5), (_) {
      //saveToDB();
    //});
      debugPrint('Heart Rate: ${hr.average}, r-r: ${hr.rr}');
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