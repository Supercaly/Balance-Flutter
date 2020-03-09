
/// Class representing the single raw data captured from sensors
class SensorData {
  final int timestamp;
  final int accuracy;
  final double accelerometerX;
  final double accelerometerY;
  final double accelerometerZ;
  final double gyroscopeX;
  final double gyroscopeY;
  final double gyroscopeZ;

  SensorData(
    this.timestamp,
    this.accuracy,
    this.accelerometerX,
    this.accelerometerY,
    this.accelerometerZ,
    this.gyroscopeX,
    this.gyroscopeY,
    this.gyroscopeZ,
  );

  @override
  String toString() => "SensorData(timestamp=$timestamp, "
    "accuracy=$accuracy, "
    "accelerometerX=$accelerometerX, "
    "accelerometerY=$accelerometerY, "
    "accelerometerZ=$accelerometerZ, "
    "gyroscopeX=$gyroscopeX, "
    "gyroscopeY=$gyroscopeY, "
    "gyroscopeZ=$gyroscopeZ)";
}