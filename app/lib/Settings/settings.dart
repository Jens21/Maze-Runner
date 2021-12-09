import 'package:app/utils/headphones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/game_state.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _new_device_name=Headphones.get_device_name();

  @override
  void dispose() {
    super.dispose();
    
    if(_new_device_name!=""){
      Headphones.set_device_name(_new_device_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          'Settings'
        ),
      ),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Headphone\'s name:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      width: 110,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: TextEditingController(
                          text: Headphones.get_device_name()
                        ),
                        onChanged: (content){
                          _new_device_name=content;
                        },
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Use the keys:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10,),
                  CupertinoSwitch(
                    value: GameState.use_key, 
                    onChanged: (switched){
                      setState(() {
                        GameState.use_key=!GameState.use_key;
                      });
                    },
                    activeColor: Colors.blue[600],
                    trackColor: Colors.grey[700],
                  )                
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}