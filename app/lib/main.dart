import 'package:flutter/material.dart';
import 'package:app/Settings/settings.dart';
import 'package:app/Home/home.dart';
import 'package:app/Game/game.dart';
import 'package:app/About/about.dart';
import 'package:app/Quit/quit.dart';
import 'package:flutter/services.dart';
import 'package:app/utils/headphones.dart';
import 'package:app/test.dart';

import 'package:app/ESenseExample/eSenseExample.dart';
import 'dart:async';

import 'package:esense_flutter/esense.dart';

void main(){

  //Headphones.register_listener((){
  //  print('connected');
  //});
  //Headphones.try_to_connect();  

  //_listenToESense();

  runApp(new MyApp());
}

// => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]
    );

    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/game': (context) => Game(),
        '/settings': (context) => Settings(),
        '/about': (context) => About(),
        '/eSenseExample': (context) => ESenseExample(),
        '/quit': (context) => Quit(),
        '/test': (context) => Test(),
      },
    );
  }
}