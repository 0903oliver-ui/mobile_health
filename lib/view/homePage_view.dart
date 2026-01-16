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

          // Connection icon (Connected/NotConnected)
          Positioned(
            top: 150,
            left: 280,
            right: 0,
            child: ListenableBuilder(
              listenable: widget.model,
              builder: (context, _) {
                if (widget.model.device?.statusEvents == null) {
                  return Image.asset(
                    'assets/images/NotConnected.png',
                    height: 50,
                    fit: BoxFit.contain,
                  );
                }

                return StreamBuilder<DeviceConnectionStatus>(
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

          // Sleep score circle
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
          Positioned(
            top: 490,
            left: 40,
            right: 40,
            child: StreamBuilder<MovesenseHR>(
              stream: widget.model.heartRateStream,
              builder: (context, snapshot) {
                final hrValue =
                    snapshot.hasData ? '${snapshot.data?.average}' : '--';
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

          // Bottom button: CONNECT when disconnected, START when connected
          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: ListenableBuilder(
              listenable: widget.model,
              builder: (context, _) {
                final dev = widget.model.device;

                if (dev?.statusEvents == null) {
                  return _connectButton(context);
                }

                return StreamBuilder<DeviceConnectionStatus>(
                  stream: dev!.statusEvents,
                  initialData: dev.status,
                  builder: (context, snapshot) {
                    final isConnected =
                        snapshot.data == DeviceConnectionStatus.connected;
                    return isConnected
                        ? _startButton(context)
                        : _connectButton(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void refreshSleepScore() => widget.model.refresh();

  Widget _connectButton(BuildContext context) => GestureDetector(
        onTap: () {
          final connectModel = ConnectionsscreenViewModel();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConnectionsScreen(model: connectModel),
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
            'Connect to sensor',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      );

  Widget _startButton(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SleepscreenView()),
          );
        },
        child: Container(
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(104, 182, 0, 0.5),
            borderRadius: BorderRadius.circular(35),
          ),
          child: const Text(
            'START',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      );
}


// part of LukOjeApp;

// class HomePage extends StatefulWidget {
//   const HomePage({required this.model, super.key});

//   final HomepageViewModel model;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     requestPermissions();
//     // Hent data én gang når viewet bliver oprettet.
//     widget.model.loadLatestSleepScore();

//     // Midlertidig test (fjern når DB virker):
//     // widget.model.setLatestSleepScore(null);
//     //widget.model.setLatestSleepScore(82);
//   }

//   Future<void> requestPermissions() async {
//     if (!mounted) return;

//     await [
//       Permission.bluetooth,
//       Permission.bluetoothScan,
//       Permission.bluetoothConnect,
//     ].request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             top: -50,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: const Color.fromRGBO(73, 182, 255, 1),
//                 borderRadius: BorderRadius.circular(40),
//               ),
//             ),
//           ),
//           const Positioned(
//             top: 60,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Text(
//                 'LukØje',
//                 style: TextStyle(fontSize: 24, color: Colors.black),
//               ),
//             ),
//           ),

//           Positioned(
//             top: 150,
//             left: 280,
//             right: 0,
//             child: widget.model.device?.statusEvents == null
//                 ? Image.asset(
//                     'assets/images/NotConnected.png',
//                     height: 50,
//                     fit: BoxFit.contain,
//                   )
//                 : StreamBuilder<DeviceConnectionStatus>(
//                     stream: widget.model.device!.statusEvents,
//                     initialData: widget.model.device!.status,
//                     builder: (context, snapshot) {
//                       final isConnected =
//                           snapshot.data == DeviceConnectionStatus.connected;
//                       final asset = isConnected
//                           ? 'assets/images/Connected.png'
//                           : 'assets/images/NotConnected.png';
//                       return Image.asset(
//                         asset,
//                         height: 50,
//                         fit: BoxFit.contain,
//                       );
//                     },
//                   ),
//           ),

//           Positioned(
//             top: 150,
//             left: 120,
//             right: 120,
//             child: Image.asset('assets/images/Logo.png'),
//           ),

//           // Kun score-delen genbygges når modellen ændrer sig.
//           Positioned(
//             top: 320,
//             left: 0,
//             right: 0,
//             child: ListenableBuilder(
//               listenable: widget.model,
//               builder: (BuildContext context, Widget? child) {
//                 final model = widget.model;

//                 return GestureDetector(
//                   onTap: refreshSleepScore,
//                   child: Container(
//                     padding: const EdgeInsets.all(1),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.black,
//                     ),
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         const CircleAvatar(
//                           radius: 120,
//                           backgroundColor: Color.fromRGBO(113, 198, 255, 1),
//                         ),
//                         Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               model.sleepScoreTitle,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 25),
//                             Text(
//                               model.sleepScoreValueText,
//                               style: const TextStyle(
//                                 fontSize: 40,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // TEMPORARY: Heart rate display when device is connected
//           // This StreamBuilder listens to the `heartRateStream` exposed by
//           // `HomepageViewModel`. The ViewModel simply forwards `device.hr`.
//           // When the device emits HR samples, the builder rebuilds and the
//           // numeric BPM value is updated. This block is intentionally
//           // minimal (plain text) and marked TEMPORARY for later refactor.
//           Positioned(
//             top: 490,
//             left: 40,
//             right: 40,
//             child: StreamBuilder<MovesenseHR>(
//               stream: widget.model.heartRateStream,
//               builder: (context, snapshot) {
//                 final hrValue = snapshot.hasData
//                     ? '${snapshot.data?.average}'
//                     : '--';
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Heart Rate',
//                       style: TextStyle(fontSize: 14, color: Colors.black),
//                     ),
//                     Text(
//                       '$hrValue BPM',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),

          

//           Positioned(
//             child: widget.model.device?.statusEvents == null
//                 ? Positioned(
//                     bottom: 50,
//                     left: 40,
//                     right: 40,
//                     child: GestureDetector(
//                       onTap: () {
//                         final ConnectModel = ConnectionsscreenViewModel();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 ConnectionsScreen(model: ConnectModel),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         height: 80,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: const Color.fromRGBO(73, 182, 255, 1),
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: const Color.fromARGB(255, 0, 0, 0),
//                             width: 1,
//                           ),
//                         ),
//                         child: const Text(
//                           'Connect to sensor',
//                           style: TextStyle(fontSize: 24, color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   )
//                 : StreamBuilder<DeviceConnectionStatus>(
//                     stream: widget.model.device!.statusEvents,
//                     initialData: widget.model.device!.status,
//                     builder: (context, snapshot) {
//                       final isConnected =
//                           snapshot.data == DeviceConnectionStatus.connected;
//                       final asset = isConnected
//                           ? Positioned(
//                               bottom: 50,
//                               left: 40,
//                               right: 40,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => SleepscreenView(),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   height: 80,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     color: const Color.fromRGBO(
//                                       104,
//                                       182,
//                                       0,
//                                       0.5,
//                                     ),
//                                     borderRadius: BorderRadius.circular(35),
//                                   ),
//                                   child: const Text(
//                                     'START',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : Positioned(
//                               bottom: 50,
//                               left: 40,
//                               right: 40,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   final ConnectModel =
//                                       ConnectionsscreenViewModel();
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ConnectionsScreen(
//                                         model: ConnectModel,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   height: 80,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     color: const Color.fromRGBO(
//                                       73,
//                                       182,
//                                       255,
//                                       1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color: const Color.fromARGB(255, 0, 0, 0),
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     'Connect to sensor',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                       return asset;
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   void refreshSleepScore() => widget.model.refresh();
// }
