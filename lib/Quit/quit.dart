import 'dart:html';

import 'package:flutter/material.dart';

class Quit extends StatefulWidget {
  @override
  _QuitState createState() => _QuitState();
}

class _QuitState extends State<Quit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(      
          child: Text('Quit'),
        ),
      ),
    );
  }
}