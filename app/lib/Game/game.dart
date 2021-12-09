import 'dart:async';

import 'package:app/utils/bluetooth_state.dart';
import 'package:app/utils/headphones.dart';
import 'package:flutter/material.dart';
import 'package:app/Game/connect_headphones_screen.dart';
import 'package:app/utils/game_state.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late BuildContext dialog_connect_headphones;
  bool showed_dialog_connect_headphones=false;

  @override
  void initState() {
    super.initState();

    Headphones.add_listener((event) {
      switch (event) {
        case OwnBluetoothState.CONNECTED:
          if(showed_dialog_connect_headphones){
            Navigator.pop(dialog_connect_headphones);
          }
          break;
        case OwnBluetoothState.DISCONNECTED:
          if(!GameState.use_key){
            showDialog(
              barrierDismissible: false,
              barrierColor: Colors.black26,
              context: context,
              builder: (context) {
                dialog_connect_headphones=context;
                showed_dialog_connect_headphones=true;
                return WillPopScope(
                  child: ConnectHeadphonesDialog(),
                  onWillPop: (){
                    return Future.value(false);
                  },
                );
              }
            ).then((_) {showed_dialog_connect_headphones=false;});
          }
          break;
        }
      });

      Headphones.start_sensor_listening();
  }

  @override
  void dispose() {
    super.dispose();

    Headphones.stop_sensor_listening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Euler x: '),
            Text('Euler y: '),
            Text('Euler z: '),
          ],
        ),
      )
    );
  }
}