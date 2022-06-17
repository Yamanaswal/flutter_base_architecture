import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_utility.dart';
import 'package:flutter_base_architecture/views/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());

  ApiUtility().callApiDemo();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}

