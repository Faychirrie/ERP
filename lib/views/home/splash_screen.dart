import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white, // AppBar
        body: const Center(
          child: Image(image: AssetImage('assets/pdil_logo.jpg'))
        ), // Container
      ), // Scaffold
    ); // MaterialApp
  }
}