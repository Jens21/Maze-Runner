import 'package:flutter/material.dart';

class FadingInformationBox extends StatefulWidget {

  late _FadingInformationBoxState _fadingBoxState;
  String title;

  FadingInformationBox({required this.title}){
    _fadingBoxState=_FadingInformationBoxState(title: title);
  }

  @override
  _FadingInformationBoxState createState(){
    _fadingBoxState= _FadingInformationBoxState(title: title);
    return _fadingBoxState;
  }

  void forward(){
    _fadingBoxState.forward();
  }

  void set_title(String title){
    this.title=title;
    _fadingBoxState.set_title(title);
  }
}

class _FadingInformationBoxState extends State<FadingInformationBox>  with TickerProviderStateMixin {
  String title;

  _FadingInformationBoxState({required this.title});

  void set_title(String title){
    setState(() {
      this.title=title;
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
    reverseDuration: const Duration(milliseconds: 5000),
  )..addStatusListener((status) {
    if(status==AnimationStatus.completed){
      _controller.reverse();
    }
  });

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  void forward(){
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeTransition(
        opacity: _animation,
        child: Container(          
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }
}