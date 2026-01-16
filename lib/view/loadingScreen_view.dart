part of LukOjeApp;

class LoadingscreenView extends StatefulWidget {
  const LoadingscreenView({super.key, required this.model});

  final LoadingscreenViewmodel model;

  @override
  State<LoadingscreenView> createState() => _LoadingScreenViewState();
}

class _LoadingScreenViewState extends State<LoadingscreenView> {
  StreamSubscription<DeviceConnectionStatus>? _statusSubscription;

  @override
  void initState() {
    super.initState();

    if (widget.model.device == null) {
      debugPrint("Device is null. Cannot subscribe to statusEvents.");
      return;
    }

    // Hvis device allerede er connected, så navigér med det samme.
    if (widget.model.device!.status == DeviceConnectionStatus.connected) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToHomePage());
      return;
    }

    // Lyt på statusEvents og navigér når den bliver connected.
    _statusSubscription = widget.model.device!.statusEvents.listen((status) {
      if (status == DeviceConnectionStatus.connected) {
        _navigateToHomePage();
      }
    });
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }

  void _navigateToHomePage() {
    if (!mounted) return;

    // VIGTIGT: Lav homeModel med device, så HomePage kan se connection-state.
    final homeModel = HomepageViewModel(device: widget.model.device);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => VerificationscreenView(homeModel: homeModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 500,
            right: 40,
            left: 40,
            child: Image.asset('assets/images/loadingGif.gif'),
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
            top: -50,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromRGBO(73, 182, 255, 1),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          Positioned(
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


// part of LukOjeApp;

// class LoadingscreenView extends StatefulWidget {
//   const LoadingscreenView({super.key, required this.model});

//   final LoadingscreenViewmodel model;

//   @override
//   State<LoadingscreenView> createState() => _LoadingScreenViewState();
// }

// class _LoadingScreenViewState extends State<LoadingscreenView> {
//   late final StreamSubscription<DeviceConnectionStatus> _statusSubscription;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.model.device == null) {
//       debugPrint("Device is null. Cannot subscribe to statusEvents.");
//       // Handle the null case (e.g., show an error or navigate back)
//       return;
//     }

//     // Listen to the statusEvents stream
//     _statusSubscription = widget.model.device!.statusEvents.listen((status) {
//       if (status == DeviceConnectionStatus.connected) {
//         _navigateToHomePage();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _statusSubscription.cancel();
//     super.dispose();
//   }

//   void _navigateToHomePage() {
//     if (!mounted) return;
//     // Pass the connected device into the HomePage view-model so the
//     // HomePage can listen to the same `statusEvents` and `hr` streams.
//     final homeModel = HomepageViewModel(device: widget.model.device);
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => VerificationscreenView()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             top: 500,
//             right: 40,
//             left: 40,
//             child: Image.asset('assets/images/loadingGif.gif'),
//           ),
//           Positioned(
//             top: 150,
//             left: 280,
//             right: 0,
//             // This StreamBuilder listens to `widget.model.device.statusEvents`.
//             // It uses `initialData` set to the device's current `status` so
//             // the UI displays the right icon immediately. When the device
//             // emits new statuses (connecting, connected, disconnected),
//             // the builder rebuilds and updates the icon.
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
//             top: -50,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(73, 182, 255, 1),
//                 borderRadius: BorderRadius.circular(40),
//               ),
//             ),
//           ),
//           Positioned(
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
//             left: 120,
//             right: 120,
//             child: Image.asset('assets/images/Logo.png'),
//           ),
//         ],
//       ),
//     );
//   }
// }
