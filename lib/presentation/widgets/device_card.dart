import 'package:flutter/material.dart';
import 'package:blue_scanner/data/models/device_model.dart';

class DeviceCard extends StatelessWidget {
  final DeviceModel device;

  const DeviceCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(device.name),
        subtitle: Text(device.macAddress),
        trailing: Text('RSSI: ${device.rssi}'),
      ),
    );
  }
}
