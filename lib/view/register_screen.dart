part of '../main.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 450,
              left: 45,
              right: 45,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      filled: true,
                      fillColor: const Color.fromRGBO(113, 198, 255, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Age',
                      filled: true,
                      fillColor: const Color.fromRGBO(113, 198, 255, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Weight',
                      filled: true,
                      fillColor: const Color.fromRGBO(113, 198, 255, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Gender',
                      filled: true,
                      fillColor: const Color.fromRGBO(113, 198, 255, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 10,
              left: 300,
              right: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundColor: Color.fromRGBO(113, 198, 255, 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/arrow.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
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

            Positioned(
              top: 320,
              left: 30,
              right: 30,
              child: Center(
                child: Text(
                  'Please put in information listed bellow for later calculations',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
