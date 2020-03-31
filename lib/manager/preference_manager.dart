import 'package:balance_app/model/sensor_bias.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const _isFirstTimeLaunch = "IsFirstTimeLaunch";
  static const _isDeviceCalibrated = "IsDeviceCalibrated";
  static const _accelerometerBiasX = "AccelerometerBiasX";
  static const _accelerometerBiasY = "AccelerometerBiasY";
  static const _accelerometerBiasZ = "AccelerometerBiasZ";
  static const _gyroscopeBiasX = "GyroscopeBiasX";
  static const _gyroscopeBiasY = "GyroscopeBiasY";
  static const _gyroscopeBiasZ = "GyroscopeBiasZ";

  /// Is this the first time the app has been launched?
  static Future<bool> get isFirstTimeLaunch async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_isFirstTimeLaunch) ?? true;
  }

  /// Mark the first time launch as done
  static Future<void> firstLaunchDone() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(_isFirstTimeLaunch, false);
  }

  /// The device is already calibrated?
  ///
  /// Returns a [Future] of [true] if the device is
  /// already calibrated, [false] otherwise.
  static Future<bool> get isDeviceCalibrated async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_isDeviceCalibrated) ?? false;
  }

  /// Update the all sensors biases with fresh values
  ///
  /// Given an accelerometer [SensorBias] and a gyroscope
  /// [SensorBias] update their values into the [SharedPreferences]
  /// and set [_isDeviceCalibrated] to true.
  static Future<void> updateSensorBiases(SensorBias accBias, SensorBias gyroBias) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(_isDeviceCalibrated, true);
    pref.setDouble(_accelerometerBiasX, accBias?.x);
    pref.setDouble(_accelerometerBiasY, accBias?.y);
    pref.setDouble(_accelerometerBiasZ, accBias?.z);
    pref.setDouble(_gyroscopeBiasX, gyroBias?.x);
    pref.setDouble(_gyroscopeBiasY, gyroBias?.y);
    pref.setDouble(_gyroscopeBiasZ, gyroBias?.z);
  }

  /// Return a [Future] with accelerometer [SensorBias]
  ///
  /// This method will return the accelerometer
  /// [SensorBias] stored in [SharedPreferences];
  /// if some value is null [0.0] will be passed instead.
  static Future<SensorBias> get accelerometerBias async {
    var pref = await SharedPreferences.getInstance();
    double accX = pref.getDouble(_accelerometerBiasX) ?? 0.0;
    double accY = pref.getDouble(_accelerometerBiasY) ?? 0.0;
    double accZ = pref.getDouble(_accelerometerBiasZ) ?? 0.0;
    return SensorBias(accX, accY, accZ);
  }

  /// Return a [Future] with gyroscope [SensorBias]
  ///
  /// This method will return the gyroscope
  /// [SensorBias] stored in [SharedPreferences];
  /// if some value is null [0.0] will be passed instead.
  static Future<SensorBias> get gyroscopeBias async {
    var pref = await SharedPreferences.getInstance();
    double gyroX = pref.getDouble(_gyroscopeBiasX) ?? 0.0;
    double gyroY = pref.getDouble(_gyroscopeBiasY) ?? 0.0;
    double gyroZ = pref.getDouble(_gyroscopeBiasZ) ?? 0.0;
    return SensorBias(gyroX, gyroY, gyroZ);
  }
}