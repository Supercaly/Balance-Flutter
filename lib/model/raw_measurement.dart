
import 'package:floor/floor.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/sensor_data.dart';

@Entity(
  tableName: "measurements_data",
  foreignKeys: [
    ForeignKey(
      entity: Measurement,
      parentColumns: ["id"],
      childColumns: ["measurement_id"],
      onDelete: ForeignKeyAction.CASCADE,
      onUpdate: ForeignKeyAction.CASCADE,
    )
  ]
)
class RawMeasurement {
  @PrimaryKey(autoGenerate: true) final int id;
  @ColumnInfo(name: "measurement_id", nullable: false) final int measurementId;
  @ColumnInfo() final int timestamp;
  @ColumnInfo() final int accuracy;
  @ColumnInfo(name: "accelerometer_x") final double accelerometerX;
  @ColumnInfo(name: "accelerometer_y") final double accelerometerY;
  @ColumnInfo(name: "accelerometer_z") final double accelerometerZ;
  @ColumnInfo(name: "gyroscope_x") final double gyroscopeX;
  @ColumnInfo(name: "gyroscope_y") final double gyroscopeY;
  @ColumnInfo(name: "gyroscope_z") final double gyroscopeZ;

  RawMeasurement({
    this.id,
    this.measurementId,
    this.timestamp,
    this.accuracy,
    this.accelerometerX,
    this.accelerometerY,
    this.accelerometerZ,
    this.gyroscopeX,
    this.gyroscopeY,
    this.gyroscopeZ,
  });

  factory RawMeasurement.fromSensorData(int measurementId, SensorData sensorData) {
    return RawMeasurement(
      measurementId: measurementId,
      timestamp:sensorData.timestamp,
      accuracy: sensorData.accuracy,
      accelerometerX: sensorData.accelerometerX,
      accelerometerY: sensorData.accelerometerY,
      accelerometerZ: sensorData.accelerometerZ,
      gyroscopeX: sensorData.gyroscopeX,
      gyroscopeY: sensorData.gyroscopeY,
      gyroscopeZ: sensorData.gyroscopeZ,
    );
  }
}