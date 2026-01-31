import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ControlScreen extends StatelessWidget {
  final BluetoothConnection connection;
  
  const ControlScreen({required this.connection});

  void send(String cmd) {
    connection.output.add(
      Uint8List.fromList(utf8.encode("$cmd\n"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BT control"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("Front"),
            onPressed: () => send("F"),
          ),
          ElevatedButton(
            child: Text("Back"),
            onPressed: () => send("B"),
          ),
          ElevatedButton(
            child: Text("Left"),
            onPressed: () => send("L"),
          ),
          ElevatedButton(
            child: Text("Right"),
            onPressed: () => send("R"),
          ),
          ElevatedButton(
            child: Text("Stop"),
            onPressed: () => send("S"),
          )
        ],
      ),
    );
  }
}