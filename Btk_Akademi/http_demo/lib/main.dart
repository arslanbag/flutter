import 'package:flutter/material.dart';
import 'package:http_demo/screens/main_screen.dart';

void main() {
  runApp(const HttpApp());
}

class HttpApp extends StatelessWidget {
  const HttpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}
