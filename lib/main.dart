library LukOjeApp;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

part 'view/first_screen_view.dart';
part 'view/register_screen.dart';
part 'view/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LukØje',
      theme: ThemeData(
        textTheme: GoogleFonts.merriweatherTextTheme(),
      ),
      home: FirstScreenView(),
    );
  }
}