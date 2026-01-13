part of '../main.dart';

class FirstScreenView extends StatelessWidget {
  const FirstScreenView({super.key});

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
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
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
            child: Center(
              child: Text(
                'Welcome to LukØje',
                style: TextStyle(
                  fontSize:24,
                  color: Colors.black,
                )
              )
            ),
          ),

          Positioned(
            bottom: 200,
            left: 30,
            right: 30,
            child: GestureDetector(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) => RegisterScreen()),
                );
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(73, 182, 255, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center (
                  child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize:24,
                    color: Colors.black,
                    )
                  )
                )
              )
            ),
          )
        ],
      ),
    );
  }
}