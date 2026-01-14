part of '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomepageViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = HomepageViewModel();
    _vm.addListener(_onVmChanged);
    _vm.loadLatestSleepScore();

    // Midlertidig test: uncomment én af disse for at se UI ændre sig.
    _vm.setLatestSleepScore(null);
    //_vm.setLatestSleepScore(82);
  }

  void _onVmChanged() {
    if (mounted) setState(() {});
  }

  // @override
  // void dispose() {
  //   _vm.removeListener(_onVmChanged);
  //   _vm.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final score = _vm.latestSleepScore;

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
          Positioned(
            top: 300,
            left: 0,
            right: 0,
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
                        score == null ? 'No previous sessions' : 'Latest sleep score',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        score == null ? '__' : '$score',
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
          ),
          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color.fromRGBO(73, 182, 255, 1),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
