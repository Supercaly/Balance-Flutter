
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/raw_measurement_data.dart';
import 'package:balance_app/model/sensor_data.dart';

class MeasureCountdownRepository {
  final MeasurementDatabase database;

  MeasureCountdownRepository(this.database);

  /// Creates a new [Measurement] with his own [RawMeasurementData]
  Future<int> createNewMeasurement(List<SensorData> rawSensorData, bool eyesOpen) async {
    final measurementDao = database.measurementDao;
    final rawMeasDataDao = database.rawMeasurementDataDao;

    try {
      final newMeasId = await measurementDao.insertMeasurement(
        Measurement(
          creationDate: DateTime
            .now()
            .millisecondsSinceEpoch,
          eyesOpen: eyesOpen,
        )
      );

      await rawMeasDataDao.insertRawMeasurements(
        rawSensorData
          .map((sd) => RawMeasurementData.fromSensorData(newMeasId, sd))
          .toList()
      );

      return newMeasId;
    } catch(e) {
      print("MeasureCountdownRepository.createNewMeasurement: Error $e");
      return Future.error(e);
    }
  }
}