import 'package:blue_scanner/data/blocs/bluetooth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:blue_scanner/presentation/screens/scanner_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BlueScannerApp());
}

class BlueScannerApp extends StatelessWidget {
  const BlueScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => MyBluetoothBloc(),
        child: const ScannerScreen(),
      ),
    );
  }
}
