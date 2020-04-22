
/// Class representing a sensor bias
///
/// A sensor bias is a tuple of values (x,y,z)
/// used to calibrate the senors; each sensor
/// has a SensorBias
class SensorBias {
  final double x, y, z;

  SensorBias(this.x, this.y, this.z);

  @override
  String toString() => "SensorBias(x: $x, y:$y, z:$z)";
}