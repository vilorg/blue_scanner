import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blue_scanner/data/models/device_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class MyBluetoothBloc extends Bloc<MyBluetoothEvent, MyBluetoothState> {
  MyBluetoothBloc() : super(BluetoothInitial()) {
    on<StartScanEvent>((event, emit) async {
      if (await FlutterBluePlus.isSupported == false) {
        emit(BluetoothNotSupported());
        return;
      }

      var statusBlue = await Permission.bluetooth.status;
      if (Platform.isAndroid) {
        var statusLocation = await Permission.bluetoothAdvertise.status;
        if (statusLocation.isDenied) {
          await Permission.bluetoothAdvertise.request();
          emit(BluetoothWithoutPermission());
          return;
        } else if (statusLocation.isPermanentlyDenied) {
          openAppSettings();
          emit(BluetoothWithoutPermission());
          return;
        }
      }

      if (statusBlue.isDenied) {
        await Permission.bluetooth.request();
        emit(BluetoothWithoutPermission());
        return;
      } else if (statusBlue.isPermanentlyDenied) {
        openAppSettings();
        emit(BluetoothWithoutPermission());
        return;
      }

      BluetoothAdapterState adapterState =
          await FlutterBluePlus.adapterState.first;

      if (adapterState == BluetoothAdapterState.on) {
        emit(BluetoothLoading());
        try {
          FlutterBluePlus.adapterState.listen((stateBlue) {
            if (stateBlue != BluetoothAdapterState.on) {
              emit(BluetoothNotConnected());
              return;
            }
          });

          await FlutterBluePlus.startScan(androidUsesFineLocation: true);
          var devicesStream = FlutterBluePlus.scanResults;
          await for (List<ScanResult> devices in devicesStream) {
            List<DeviceModel> deviceModels = devices.map((device) {
              return DeviceModel(
                name: device.device.platformName,
                macAddress: device.device.remoteId.str,
                rssi: device.rssi,
              );
            }).toList();
            emit(BluetoothLoaded(devices: deviceModels));
          }
        } catch (e) {
          openAppSettings();
          emit(const BluetoothError(message: 'Failed to scan devices'));
        }
      } else {
        if (Platform.isAndroid) {
          await FlutterBluePlus.turnOn();
        } else {
          emit(BluetoothNotConnected());
          return;
        }
      }
    });
  }
}
