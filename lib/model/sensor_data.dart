/// Class representing the single raw data captured from sensors
class SensorData {
  final int timestamp, 
    accuracy;
  final double accelerometerX, 
    accelerometerY, 
    accelerometerZ,
    gyroscopeX,
    gyroscopeY,
    gyroscopeZ;
  
  SensorData(
    this.timestamp,
    this.accuracy,
    this.accelerometerX,
    this.accelerometerY,
    this.accelerometerZ,
    this.gyroscopeX,
    this.gyroscopeY,
    this.gyroscopeZ
  );
}