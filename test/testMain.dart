import 'package:flutter/foundation.dart';
import 'package:mobile_health/model/deviceModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:movesense_plus/movesense_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MovesenseDev device = MovesenseDev('0C:8C:DC:1B:23:16');

  test('test movesense connect using movesense_plus plugin', () async {
    // Request necessary permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();

    // Check if all permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);
    expect(allGranted, true, reason: 'All required permissions should be granted.');

    // Connect to the Movesense device
    await device.connect();

    // Poll for connection status
    int attempts = 0;
    while (device.status != DeviceConnectionStatus.connected && attempts < 10) {
      await Future.delayed(Duration(seconds: 1)); // Check every second
      attempts++;
    }

    // Verify connection
    expect(device.status, DeviceConnectionStatus.connected,
        reason: 'Device should be connected.');


    // Disconnect the device after the test
    await device.disconnect();

    attempts = 0;
    while (device.status != DeviceConnectionStatus.disconnected && attempts < 10) {
      await Future.delayed(Duration(seconds: 1)); // Check every second
      attempts++;
    }

    expect(device.status, DeviceConnectionStatus.disconnected,
        reason: 'Device should be disconnected.');
  });
}
