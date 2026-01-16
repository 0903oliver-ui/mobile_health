part of '../main.dart';

class SleepscreenView extends StatelessWidget {
  const SleepscreenView({super.key, required this.homeModel});

  final HomepageViewModel homeModel;

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
              text: 'SLEEP THIGHT!',
              textStyle: const TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(9, 62, 174, 1),
              ),
              startAngle: -88.6,
              placement: Placement.outside,
            ),
          ),

          // STOP-knap
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Her kan I evt. stoppe session/logning, hvis I har logik til det.
                // homeModel.stopSleepSession(); // eksempel

                // Gå tilbage til den HomePage der allerede er i stacken (med device)
                Navigator.pop(context);

                // Hvis du vil tvinge UI refresh efter stop:
                // homeModel.refresh();
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 5, 5, 0.5),
                  borderRadius: BorderRadius.circular(35),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'STOP',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}