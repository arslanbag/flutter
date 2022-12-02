import 'package:flutter/material.dart';
import 'package:sqlflitdemo/screensR/urun_listele.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UrunListele(),
    );
  }
}
