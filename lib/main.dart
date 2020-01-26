import 'package:dollychallange/home/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dolly Parton Challenge',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
