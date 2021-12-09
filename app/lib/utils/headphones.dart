import 'package:esense_flutter/esense.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app/utils/bluetooth_state.dart';

class Headphones{

  static const int _sampling_rate = 30;
  static String _device_name="eSense-0362";

  static int _connection_timer_duration=5;
  static Timer? _connection_timer;

  static FlutterBlue _flutterBlue = FlutterBlue.instance;

  static bool _bluetooth_on=false;
  static bool _connected=false;

  static List<Function>_listeners=[];

  static var sensor_listener;

  static List<int>?accel=[0,0,0];
  static List<int>?gyro=[0,0,0];

  static bool _called_connected=false;
  static void connect(){
    print('Called function connect');
    print(_called_connected);
    if(!_called_connected){
      _called_connected=true;
      _flutterBlue.state.listen((event) {
      switch (event.toString()) {
        case 'BluetoothState.on':
          _bluetooth_on=true;
          break;
        case 'BluetoothState.off':
          _bluetooth_on=false;
          _connected=false;
          _send_disconnected_message();
          break;
      }
    });

    ESenseManager().connectionEvents.listen((event) {
      switch (event.type) {
        case ConnectionType.connected:
          _connected=true;
          _send_connected_message();
          break;
        case ConnectionType.disconnected:
          _connected=false;
          _send_disconnected_message();
          break;
        default:
          break;
      }
    });

    ESenseManager().setSamplingRate(_sampling_rate);

    _start_connection_timer();
    }
  }

  static void add_listener(Function func){
    _listeners.add(func);
  }

  static void _start_connection_timer(){
    _connection_timer?.cancel();
    _connection_timer=Timer.periodic(Duration(seconds: _connection_timer_duration), (timer) {
      if(_bluetooth_on && !_connected){
        ESenseManager().connect(_device_name);
      }
    });
  }

  static void start_sensor_listening(){
    print('start_sensor_listening');
      try {
        sensor_listener = ESenseManager().sensorEvents.listen((event) {
          accel=event.accel;
          gyro=event.gyro;
        });
      } catch (e) {
        print('Exception $e');
      }
  }

  static void stop_sensor_listening(){
    if(_connected){
      try {
        sensor_listener?.cancel();
      } catch (e) {
      }
    }
  }

  static void disconnect(){
    _connection_timer?.cancel();
    if(_connected){
      ESenseManager().disconnect();
    }
  }

  static bool is_bluetooth_on(){
    return _bluetooth_on;
  }
  static bool is_connected(){
    return _connected;
  }
  static List<int>? getAccel(){
    return accel;
  }
  static List<int>? getGyro(){
    return gyro;
  }
  static String get_device_name(){
    return _device_name;
  }
  static void set_device_name(String device_name){
    ESenseManager().disconnect();
    _device_name=device_name;
  }

  static void _send_disconnected_message(){
    _listeners.forEach((element) {
      try {
        element.call(OwnBluetoothState.DISCONNECTED);
      } catch (e) {
      }
    });
  }
  static void _send_connected_message(){
    _listeners.forEach((element) {
      try {
        element.call(OwnBluetoothState.CONNECTED);
      } catch (e) {
      }
    });
  }
}