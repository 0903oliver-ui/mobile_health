library LukOjeApp;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

part 'view/firstScreen_view.dart';
part 'view/registerScreen_view.dart';
part 'view/homePage_view.dart';
part 'view_model/firstScreen_viewModel.dart';
part 'view_model/homepage_viewModel.dart';
part 'view_model/registerScreen_viewModel.dart';
part 'view/connectionsScreen_view.dart';
part 'view_model/connectionsScreen_viewModel.dart';

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