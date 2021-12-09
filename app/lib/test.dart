import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({ Key? key }) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
      ),
      body: TextButton(
        onPressed: (){
          showDialog(
            context: context, 
            barrierDismissible: false,            
            builder: (context){
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: TextButton(
                  onPressed: (){Navigator.pop(context);}, 
                  child: Text('Remove Dialog'),
                ),
              );
            }
          );
        }, 
        child: Text('Press me'),
      ),
    );
  }
}