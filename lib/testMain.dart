// import 'package:mdsflutter/Mds.dart';

// void main(){
// // Scan for new devices
// Mds.startScan((name, address) {
//     // Handle new scanned device
// });

// // Stop scanning
// Mds.stopScan();

// // Connect to a Movesense device
// Mds.connect(address,
//             (serial) { /* onConnected */ },
//             () { /* onDisconnected */ },
//             (error) { /* onConnectionError */ }
//     );

// // Disconnect from a device
// Mds.disconnect(address);

// // Make a GET, PUT, POST, DEL request
// Mds.get(Mds.createRequestUri(serial, resourceUri),
//       contract,
//       (data, statusCode) { /* onSuccess */ },
//       (error, statusCode) { /* onError */ }
//     );

// // Make a subscription request
// int subscriptionId = Mds.subscribe(Mds.createSubscriptionUri(serial, resourceUri),
//       contract,
//       (data, statusCode) { /* onSuccess */ },
//       (error, statusCode) { /* onError */ },
//       (data) { /* onNotification */ },
//       (error, statusCode) { /* onSubscriptionError */ }
//     );

// // Unsubscribe from a subscription
// Mds.unsubscribe(subscriptionId);
// }
