part of '../mobile_health.dart';

class SleepData {
  final DateTime timestamp = DateTime.now();
  final int hr;
  final int rr;
  final int lux;
  
  SleepData(this.hr, this.rr, this.lux);
}