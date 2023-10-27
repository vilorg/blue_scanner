import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothUtils {
  static Future<bool> checkBluetooth() async {
    return await FlutterBluePlus.isSupported;
  }

  static Future<bool> askBluetooth() async {
    return await FlutterBluePlus.isSupported;
  }

  // static Future<bool> установитьСоединениеСУстройством(DeviceIdentifier deviceId) async {
  //   FlutterBlue flutterBlue = FlutterBlue.instance;
  //   BluetoothDevice device = await flutterBlue.connect(deviceId);
  //   return device != null;
  // }

  // Добавьте другие методы, связанные с Bluetooth, по мере необходимости
}