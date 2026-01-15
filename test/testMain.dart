import '../lib/main.dart'; 
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
    await device.statusEvents.firstWhere(
      (status) => status == DeviceConnectionStatus.connected,
      orElse: () => DeviceConnectionStatus.disconnected,
    );

    // Verify connection
    expect(device.status, DeviceConnectionStatus.connected,
        reason: 'Device should be connected.');


    // Disconnect the device after the test
    await device.disconnect();
    await device.statusEvents.firstWhere(
      (status) => status == DeviceConnectionStatus.disconnected,
      orElse: () => DeviceConnectionStatus.connected,
    );

    expect(device.status, DeviceConnectionStatus.disconnected,
        reason: 'Device should be disconnected.');
  });
}
