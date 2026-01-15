import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';

class MovesenseDev extends MovesenseDevice {
  MovesenseDev(String address) : super(address: address);

  // @override
  // Future<void> connect() async{
  //   super.connect();
  //   getBatteryStatus().then(
  //         (battery) => debugPrint('>> Battery level: ${battery.name}'));
  // }
  //other model methods are from superclass MovesenseDevice
}