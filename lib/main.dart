import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_app.dart';

export 'my_app.dart';

// main application entry point
// initializes system bindings and sets default orientation prior to running widget tree
void main() async {
  // ensure flutter engine bindings are initialized before calling async platform services
  WidgetsFlutterBinding.ensureInitialized();

  // lock orientation to portrait up/down for optimal mobile screen presentation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // configure translucent system overlay for seamless edge-to-edge UI feel
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}
