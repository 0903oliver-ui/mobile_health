 part of LukOjeApp;

// //'0C:8C:DC:1B:23:16'
// class StreamModel{
//   final MovesenseDev device;
//   final Sensor lightSensor = LightSensor();
//   late SleepData sleepData;
  

//   StreamSubscription<MovesenseDeviceState>? stateSubscription;
//   StreamSubscription<MovesenseHR>? hrSubscription;
//   StreamSubscription<String>? lightSubscription;

//   StreamModel(this.device);

//   void startStream(){
//     sleepData = SleepData([], [], []);
//     if(device.status == DeviceConnectionStatus.connected){
//       stateSubscription = device.statusEvents.listen((state) {
//         sleepData.events.add(state);
//         // TEMPORARY: currently we just log device states. Replace with
//         // persistence or processing logic as needed.
//         //debugPrint('Device State: $state');
//       });
//       lightSubscription = lightSensor.readings.listen((reading) {
//         sleepData.lux.add(int.parse(reading));
        
//         // TEMPORARY: currently we just log light sensor readings. Replace with
//         // persistence or processing logic as needed.
//         //debugPrint('Light Sensor Reading: $reading');
//       });
//       // Subscribe to the device's HR stream here. This establishes a
//       // listener to the domain stream `device.hr` and will receive
//       // `MovesenseHR` samples as they arrive from the device.
//       hrSubscription = device.hr.listen((hr) {
//         sleepData.hr.add(hr.average);
//         final rr = hr.rr;
//         if (rr != null) {
//           sleepData.rr.add(rr);
//         }
//         // TEMPORARY: currently we just log HR samples. Replace with
//         // persistence or processing logic as needed.
//         //debugPrint('Heart Rate: ${hr.average}, r-r: ${hr.rr}');
//       });
//     }else{
//       /// Throws an exception when the device is not connected.
//       /// 
//       /// This exception will halt execution and must be caught by a try-catch block
//       /// or it will propagate up the call stack, terminating the current function
//       /// and any subsequent code in that block will not execute.
//       throw Exception('Device not connected');
//     }
//   }
// }