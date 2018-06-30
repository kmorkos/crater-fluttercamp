import 'package:flutter/material.dart';

import 'screens/HomeScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Crowd Rater',
      home: HomeScreen(),
    );
  }
}
