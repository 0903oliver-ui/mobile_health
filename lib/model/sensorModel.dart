

enum SensorType{acclrmtr, hrsnsr, lsnsr}

abstract interface class Sensor{
  SensorType? type;
  Sensor(this.type);
}