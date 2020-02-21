
/// Class representing a single sensor event
class SensorEvent {
  /// Timestamp
  final int timestamp;
  /// Accuracy of the sensor
  final int accuracy;
  /// value for x axes
  final double x;
  /// value for y axes
  final double y;
  /// value for z axes
  final double z;

  SensorEvent(
    this.timestamp,
    this.accuracy,
    this.x,
    this.y,
    this.z
    );

  @override
  String toString() => "SensorEvent{timestamp:$timestamp, accuracy:$accuracy, x:$x, y:$y, z:$z}";
}