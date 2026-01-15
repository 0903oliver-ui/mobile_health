part of '../main.dart';

class LoadingscreenView extends StatefulWidget {
  const LoadingscreenView({super.key, required this.model});

  final LoadingscreenViewmodel model;

  @override
  State<LoadingscreenView> createState() => _LoadingScreenViewState();
}

class _LoadingScreenViewState extends State<LoadingscreenView> {
  late final StreamSubscription<DeviceConnectionStatus> _statusSubscription;

  @override
  void initState() {
    super.initState();

    // Listen to the statusEvents stream
    _statusSubscription = widget.model.device!.statusEvents.listen((status) {
      if (status == DeviceConnectionStatus.connected) {
        _navigateToHomePage();
      }
    });
  }

  @override
  void dispose() {
    _statusSubscription.cancel();
    super.dispose();
  }

  void _navigateToHomePage() {
    if (!mounted) return;

    final homeModel = HomepageViewModel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage(model: homeModel)),
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
            child: Image.asset(
              'assets/images/NotConnected.png',
              height: 50,
              fit: BoxFit.contain,
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
