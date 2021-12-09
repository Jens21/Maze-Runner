import 'package:app/utils/fading_information_box.dart';
import 'package:app/utils/headphones.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/bluetooth_state.dart';
import 'package:app/utils/game_state.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

bool _can_start_game=false;
bool _can_resume_game=false;

class _HomeState extends State<Home> {

  FadingInformationBox fadingInformationBox=FadingInformationBox(title: '');

  @override
  void initState() {
    super.initState();

    Headphones.add_listener((event) {
      switch (event) {
        case OwnBluetoothState.CONNECTED:
          fadingInformationBox.set_title('Connected to the headphones.');
          fadingInformationBox.forward();
          setState(() {
            _can_start_game=true;
          });
          break;
        case OwnBluetoothState.DISCONNECTED:
          setState(() {
            _can_start_game=false;
          });
          break;
      }
    });
    Headphones.connect();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.cover,),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _can_resume_game ? (){
                    print('TODO, implement me');
                  } : (){
                    print('TODO, implement me');
                  }, 
                  child: Text(
                    'Resume Game',
                    style: TextStyle(color: _can_resume_game ? Colors.blue : Colors.grey),
                  )
                ),
                TextButton(
                  onPressed: _can_start_game || GameState.use_key ? (){
                    Navigator.pushNamed(context, '/game').then((_) => setState(() {}));
                  } : (){
                    fadingInformationBox.set_title('The headphones could not be regonized. Please connect them with your mobile phone\s bluetooth.');
                    fadingInformationBox.forward();
                  },
                  child: Text(
                    'Start New Game',
                    style: TextStyle(color: _can_start_game || GameState.use_key ? Colors.blue : Colors.grey),
                  )
                ),
                TextButton(
                  onPressed: (){Navigator.pushNamed(context, '/settings').then((_) => setState(() {}));}, 
                  child: Text('Settings')
                ),
                TextButton(
                  onPressed: (){Navigator.pushNamed(context, '/about');}, 
                  child: Text('About')
                ),
                TextButton(
                  onPressed: (){Navigator.pushNamed(context, '/quit');}, 
                  child: Text('Quit')
                ),
                TextButton(
                  onPressed: (){Navigator.pushNamed(context, '/test');}, 
                  child: Text('Test')
                ),                
              ],
            )
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter, 
              child: fadingInformationBox
            ),
          ),
        ],
      )
    );
  }
}
