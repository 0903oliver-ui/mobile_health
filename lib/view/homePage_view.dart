part of LukOjeApp;

class HomePage extends StatefulWidget {
  const HomePage({required this.model, super.key});

  final HomepageViewModel model;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
    // Hent data én gang når viewet bliver oprettet.
    widget.model.loadLatestSleepScore();

    // Midlertidig test (fjern når DB virker):
    // widget.model.setLatestSleepScore(null);
    //widget.model.setLatestSleepScore(82);
  }

  Future<void> requestPermissions() async {
    if (!mounted) return;

    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
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
            left: 280,
            right: 0,
            child: widget.model.device?.statusEvents == null
                ? Image.asset(
                    'assets/images/NotConnected.png',
                    height: 50,
                    fit: BoxFit.contain,
                  )
                : StreamBuilder<DeviceConnectionStatus>(
                    stream: widget.model.device!.statusEvents,
                    initialData: widget.model.device!.status,
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
                  ),
          ),

          Positioned(
            top: 150,
            left: 120,
            right: 120,
            child: Image.asset('assets/images/Logo.png'),
          ),

          // Kun score-delen genbygges når modellen ændrer sig.
          Positioned(
            top: 320,
            left: 0,
            right: 0,
            child: ListenableBuilder(
              listenable: widget.model,
              builder: (BuildContext context, Widget? child) {
                final model = widget.model;

                return GestureDetector(
                  onTap: refreshSleepScore,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 120,
                          backgroundColor: Color.fromRGBO(113, 198, 255, 1),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              model.sleepScoreTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              model.sleepScoreValueText,
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // TEMPORARY: Heart rate display when device is connected
          // This StreamBuilder listens to the `heartRateStream` exposed by
          // `HomepageViewModel`. The ViewModel simply forwards `device.hr`.
          // When the device emits HR samples, the builder rebuilds and the
          // numeric BPM value is updated. This block is intentionally
          // minimal (plain text) and marked TEMPORARY for later refactor.
          Positioned(
            top: 490,
            left: 40,
            right: 40,
            child: StreamBuilder<MovesenseHR>(
              stream: widget.model.heartRateStream,
              builder: (context, snapshot) {
                final hrValue = snapshot.hasData
                    ? '${snapshot.data?.average}'
                    : '--';
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Heart Rate',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Text(
                      '$hrValue BPM',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          
        ],
      ),
    );
  }

  void refreshSleepScore() => widget.model.refresh();
}
