part of LukOjeApp;




enum SensorType{acclrmtr, hrsnsr, lxsnsr}

abstract interface class Sensor {
  /// The type of sensor.
  SensorType get type;

  /// The name of the sensor.
  String get name;

  /// Is this sensor running, i.e., started?
  bool get isRunning;

  /// The stream of sensor readings as a string representation.
  Stream<String> get readings;

  /// Start this sensor.
  void start();

  /// Stop this sensor.
  void stop();
}



class LightSensor implements Sensor {
  @override
  SensorType get type => SensorType.lxsnsr;

  @override
  String get name => 'Light Sensor';

  bool _isRunning = false;
  Light _light = Light();

  @override
  bool get isRunning => _isRunning;

  final StreamController<String> _readingController = StreamController<String>();

  LightSensor() {
  _light.lightSensorStream.listen((luxValue) {
    if (_isRunning) {
      _readingController.add('Lux: $luxValue');
    }
  });
}

  @override
  Stream<String> get readings => _readingController.stream;

  @override
  void start() {
    _isRunning = true;
  }

  @override
  void stop() {
    _isRunning = false;
  }
}