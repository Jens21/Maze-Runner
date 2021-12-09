import 'package:flutter/material.dart';
import 'package:app/home.dart';
import 'package:app/Game/game.dart';
import 'package:app/Settings/settings.dart';
import 'package:app/About/about.dart';
import 'package:app/Quit/quit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/game': (context) => Game(),
        '/settings': (context) => Settings(),
        '/about': (context) => About(),
        '/quit': (context) => Quit(),
      },
    );
  }
}