part of 'bluetooth_bloc.dart';

abstract class MyBluetoothState extends Equatable {
  const MyBluetoothState();

  @override
  List<Object> get props => [];
}

class BluetoothInitial extends MyBluetoothState {}

class BluetoothLoading extends MyBluetoothState {}

class BluetoothLoaded extends MyBluetoothState {
  final List<DeviceModel> devices;

  const BluetoothLoaded({required this.devices});

  @override
  List<Object> get props => [devices];
}

class BluetoothError extends MyBluetoothState {
  final String message;

  const BluetoothError({required this.message});

  @override
  List<Object> get props => [message];
}

class BluetoothNotConnected extends MyBluetoothState {}

class BluetoothWithoutPermission extends MyBluetoothState {}

class BluetoothNotSupported extends MyBluetoothState {}
