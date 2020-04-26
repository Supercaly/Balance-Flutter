
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/floor/test_database_view.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/raw_measurement_data.dart';
import 'package:balance_app/model/sensor_data.dart';

class MeasureCountdownRepository {
  final MeasurementDatabase database;

  MeasureCountdownRepository(this.database);

  /// Creates a new [Measurement] with his own [RawMeasurementData]
  Future<Test> createNewMeasurement(List<SensorData> rawSensorData, bool eyesOpen) async {
    final measurementDao = database.measurementDao;
    final rawMeasDataDao = database.rawMeasurementDataDao;

    try {
      // Add a new Measurement
      final newMeasId = await measurementDao.insertMeasurement(
        Measurement.simple(
          creationDate: DateTime.now().millisecondsSinceEpoch,
          eyesOpen: eyesOpen,
        ),
      );

      // TODO: 26/04/20 Apply the SensorBias to all SensorData
      /*final accBias = await PreferenceManager.accelerometerBias;
      final gyroBias = await PreferenceManager.gyroscopeBias;
      Iterable<SensorData> sensorDataWithBias = rawSensorData.map((e) {
        double accX;
        double accY;
        double accZ;
        double gyroX;
        double gyroY;
        double gyroZ;

        if (e.accelerometerX != null)
          accX = e.accelerometerX + accBias.x;
        if (e.accelerometerY != null)
          accY = e.accelerometerY + accBias.y;
        if (e.accelerometerZ != null)
          accZ = e.accelerometerZ + accBias.z;

        if (e.gyroscopeX != null)
          gyroX = e.gyroscopeX + gyroBias.x;
        if (e.gyroscopeY != null)
          gyroY = e.gyroscopeY + gyroBias.y;
        if (e.gyroscopeZ != null)
          gyroZ = e.gyroscopeZ + gyroBias.z;

        return SensorData(
          e.timestamp,
          e.accuracy,
          accX,
          accY,
          accZ,
          gyroX,
          gyroY,
          gyroZ,
        );
      });*/

      // Store the SensorData in database as RawMeasurementData
      await rawMeasDataDao.insertRawMeasurements(rawSensorData.map((sd) =>
        RawMeasurementData.fromSensorData(newMeasId, sd)).toList());

      return await measurementDao.findTestById(newMeasId);
    } catch(e) {
      print("MeasureCountdownRepository.createNewMeasurement: Error $e");
      return Future.error(e);
    }
  }
}