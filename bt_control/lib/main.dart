import 'package:flutter/material.dart';
import 'package:bt_control/screens/connect.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BT control app',
      home: ConnectScreen(),
    );
  }
}
