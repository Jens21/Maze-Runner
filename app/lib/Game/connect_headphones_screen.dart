import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:app/utils/game_state.dart';

class ConnectHeadphonesDialog extends StatefulWidget {
  @override
  _ConnectHeadphonesDialogState createState() => _ConnectHeadphonesDialogState();
}

class _ConnectHeadphonesDialogState extends State<ConnectHeadphonesDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      backgroundColor: Color(0xff313131),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
              child: Text(
                'Please connect your headphones to the mobile phone\s bluetooth',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8,),
            Stack(
              children: [
                Center(child: SpinKitPulse(color: Colors.white, size: 100,), widthFactor: 0,),
                Center(child: Icon(Icons.bluetooth_connected, color: Colors.blue[600],size: 100,), widthFactor: 0,)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Or use the keys:',
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
                      Navigator.pop(context);
                    });
                  },
                  activeColor: Colors.blue[600],
                  trackColor: Colors.grey[700],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}