library LukOjeApp;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:movesense_plus/movesense_plus.dart';
import 'package:light/light.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'dart:math';


part 'view/firstScreen_view.dart';
part 'view/registerScreen_view.dart';
part 'view/homePage_view.dart';
part 'view/verrificationScreen_view.dart';
part 'view/connectionsScreen_view.dart';
part 'view/loadingScreen_view.dart';
part 'view/sleepScreen_view.dart';

part 'view_model/firstScreen_viewModel.dart';
part 'view_model/homepage_viewModel.dart';
part 'view_model/registerScreen_viewModel.dart';
part 'view_model/connectionsScreen_viewModel.dart';
part 'view_model/loadingScrenn_viewModel.dart';
part 'view_model/verificationScreen_viewModel.dart';
part 'view_model/sleepScreen_viewModel.dart';

part 'model/deviceModel.dart';
part 'model/sensorModel.dart';
part 'model/streamModell.dart';
part 'model/sleepData.dart';
part 'model/database.dart';
part 'model/sleepSessionModel.dart';

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