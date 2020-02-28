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

  @override
  bool operator ==(other) =>
    other is SensorEvent &&
      other.timestamp == timestamp &&
      other.accuracy == accuracy &&
      other.x == x &&
      other.y == y &&
      other.z == z;

  @override
  int get hashCode {
    final int prime = 31;
    int result = 1;
    result = prime * result + timestamp.hashCode;
    result = prime * result + accuracy.hashCode;
    result = prime * result + x.hashCode;
    result = prime * result + y.hashCode;
    result = prime * result + z.hashCode;
    return result;
  }
}