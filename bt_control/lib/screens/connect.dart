import 'package:bt_control/screens/control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    final bt = FlutterBluetoothSerial.instance;

    await bt.requestEnable();
    
    final list = await bt.getBondedDevices();
    setState(() => devices = list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect to Device"),),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final d = devices[index];
          return ListTile(
            title: Text(d.name ?? 'Unknown'),
            subtitle: Text(d.address),
            trailing: Icon(Icons.bluetooth),
            onTap: () async {
              final connection = await BluetoothConnection.toAddress(d.address);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ControlScreen(connection: connection,),
                )
              );
            },

          );
        },
      ),
    );
  }
}