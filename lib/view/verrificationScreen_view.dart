part of '../main.dart';

class VerificationscreenView extends StatelessWidget {
  const VerificationscreenView({super.key, required this.homeModel});

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
          Positioned(
            bottom: 10,
            left: 0,
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
                    radius: 50,
                    backgroundColor: Color.fromRGBO(113, 198, 255, 1),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // VIGTIGT: Brug samme homeModel (med device) – IKKE en ny.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(model: homeModel),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/home.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Connection Successful!',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/images/Connected.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// part of lukOjeApp;

// class VerificationscreenView extends StatelessWidget {
//   const VerificationscreenView({super.key});
  

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
//             left: 120,
//             right: 120,
//             child: Image.asset('assets/images/Logo.png'),
//           ),
//           Positioned(
//             bottom: 10,
//             left: 0,
//             right: 0,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(1),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black,
//                   ),
//                   child: const CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Color.fromRGBO(113, 198, 255, 1),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     final homeModel = HomepageViewModel();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomePage(model: homeModel),
//                       ),
//                     );
//                   },
//                   child: Image.asset(
//                     'assets/images/home.png',
//                     width: 80,
//                     height: 80,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Positioned.fill(
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Connection Successful!',
//                     style: TextStyle(fontSize: 24, color: Colors.black),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   Image.asset(
//                     'assets/images/Connected.png',
//                     width: 100,
//                     height: 100,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
