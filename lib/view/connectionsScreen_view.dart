part of '../main.dart';

class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key, required this.model});
  final ConnectionsscreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 100,
            left: 30,
            right: 30,
            height: 45,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter MAC-Adress',
                filled: true,
                fillColor: const Color.fromRGBO(113, 198, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: model.setAdress,
            ),
          ),

          Positioned(
            bottom: 15,
            left: 30,
            right: 30,
            child: GestureDetector(
              onTap: () {
                model.device?.connect();
                final loadingModel = LoadingscreenViewmodel(device: model.device);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoadingscreenView(model: loadingModel)),
                );
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(73, 182, 255, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Connect',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),

          Positioned(
            top: 150,
            left: 280,
            right: 0,
            // ListenableBuilder listens to the view-model (`model`).
            // When `setAdress` creates a `MovesenseDev` and calls
            // `notifyListeners()`, this builder runs so we can attach
            // a StreamBuilder to `model.device.statusEvents`.
            child: ListenableBuilder(
              listenable: model,
              builder: (context, _) {
                // If device (and its status stream) isn't created yet,
                // show the default NotConnected icon.
                if (model.device?.statusEvents == null) {
                  return Image.asset(
                    'assets/images/NotConnected.png',
                    height: 50,
                    fit: BoxFit.contain,
                  );
                }

                // StreamBuilder attaches to the device's `statusEvents` stream.
                // - `initialData: model.device!.status` ensures we display the
                //   current connection state immediately (no waiting for next event).
                // - When the device emits status changes, StreamBuilder rebuilds
                //   and the icon swaps between Connected/NotConnected images.
                return StreamBuilder<DeviceConnectionStatus>(
                  stream: model.device!.statusEvents,
                  initialData: model.device!.status,
                  builder: (context, snapshot) {
                    final isConnected =
                        snapshot.data == DeviceConnectionStatus.connected;
                    final asset = isConnected
                        ? 'assets/images/Connected.png'
                        : 'assets/images/NotConnected.png';
                    return Image.asset(
                      asset,
                      height: 50,
                      fit: BoxFit.contain,
                    );
                  },
                );
              },
            ),
          ),

          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(73, 182, 255, 1),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'LukØje',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 120,
            right: 120,
            child: Image.asset('assets/images/Logo.png'),
          ),
        ],
      ),
    );
  }
}
