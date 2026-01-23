part of LukOjeApp;

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
          // MAC input
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

          // Connect button
          Positioned(
            bottom: 15,
            left: 30,
            right: 30,
            child: GestureDetector(
              onTap: () {
                final dev = model.device;
                final statusStream = model.statusEvents;

                if (dev == null || statusStream == null) {
                  debugPrint('No device/status stream yet. Enter MAC first.');
                  return;
                }

                // Start connection
                dev.connect();

                // Create loading VM with SAME device + SAME broadcast stream
                final loadingModel = LoadingscreenViewmodel(
                  statusEvents: statusStream,
                );

                // Use pushReplacement so ConnectionsScreen disposes and stops rebuilding/listening.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoadingscreenView(model: loadingModel),
                  ),
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

          // Connection icon (reactive)
          Positioned(
            top: 150,
            left: 280,
            right: 0,
            child: ListenableBuilder(
              listenable: model,
              builder: (context, _) {
                final dev = model.device;
                final statusStream = model.statusEvents;

                if (dev == null || statusStream == null) {
                  return Image.asset(
                    'assets/images/NotConnected.png',
                    height: 50,
                    fit: BoxFit.contain,
                  );
                }

                return StreamBuilder<DeviceConnectionStatus>(
                  stream: statusStream,
                  initialData: dev.status,
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

          // Header
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