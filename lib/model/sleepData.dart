part of '../main.dart';

class SleepData {
  final DateTime timestamp = DateTime.now();
  final int hr;
  final int rr;
  final int lux;
  
  SleepData(this.hr, this.rr, this.lux);
}