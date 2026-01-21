part of '../main.dart';

class SleepscreenView extends StatelessWidget {
  const SleepscreenView({super.key, required this.model});
  final SleepScreenViewModel model;

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
                color: const Color.fromRGBO(9, 62, 174, 1),
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
                style: TextStyle(fontSize: 24, color: Colors.white),
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
            left: 20,
            right: 20,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(9, 62, 174, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Collecting Data...',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 20,
            right: 20,
            child: ArcText(
              radius: 120,
              text: 'SLEEP TIGHT!',
              textStyle: const TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(9, 62, 174, 1),
              ),
              startAngle: -88.6,
              placement: Placement.outside,
            ),
          ),

          // STOP-knap (rettet)
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: ListenableBuilder(
              listenable: model,
              builder: (context, _) => GestureDetector(
                onTap: model.isStopping
                    ? null
                    : () async {
                        final result = await model.stopSession();
                        if (context.mounted) Navigator.pop(context, result);
                      },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: model.isStopping
                        ? const Color.fromRGBO(200, 200, 200, 1)
                        : const Color.fromRGBO(255, 5, 5, 0.5),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    model.isStopping ? 'STOPPING...' : 'STOP',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
