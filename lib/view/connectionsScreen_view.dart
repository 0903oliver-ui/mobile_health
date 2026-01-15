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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (
                      LoadingscreenView()
                    )
                  ),
                );
                


                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoadingscreenView()),
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
