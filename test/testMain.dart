import 'package:mobile_health/model/deviceModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:movesense_plus/movesense_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

    // Create and connect to the Movesense device
    MovesenseDev device = MovesenseDev('0C:8C:DC:1B:23:16');
    await device.connect();

    

    // Verify connection
    expect(device.status, DeviceConnectionStatus.connected,
        reason: 'Device should be connected.');
  });
}
