part of '../main.dart';

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
    // Hent data én gang når viewet bliver oprettet.
    widget.model.loadLatestSleepScore();

    // Midlertidig test (fjern når DB virker):
    // widget.model.setLatestSleepScore(null);
    // widget.model.setLatestSleepScore(82);
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

          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConnectionsScreen()),
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
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void refreshSleepScore() => widget.model.refresh();
}
