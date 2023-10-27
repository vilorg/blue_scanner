import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blue_scanner/presentation/widgets/device_card.dart';
import 'package:blue_scanner/data/blocs/bluetooth_bloc.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue Scanner'),
      ),
      body: BlocBuilder<MyBluetoothBloc, MyBluetoothState>(
        builder: (context, state) {
          if (state is BluetoothInitial) {
            return const Center(
                child: Text('Press the scan button to start scanning'));
          } else if (state is BluetoothLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BluetoothLoaded) {
            final devices = state.devices;
            return ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return DeviceCard(device: devices[index]);
              },
            );
          } else if (state is BluetoothError) {
            return Center(child: Text(state.message));
          } else if (state is BluetoothNotConnected) {
            return const Center(
              child: Text("Включите блютюз"),
            );
          } else if (state is BluetoothWithoutPermission) {
            return const Center(
              child: Text("Разрешите использовать блютуз"),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<MyBluetoothBloc>(context).add(StartScanEvent());
        },
        child: const Icon(Icons.bluetooth_searching),
      ),
    );
  }
}
