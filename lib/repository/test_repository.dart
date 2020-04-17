
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/raw_measurement.dart';
import 'package:balance_app/model/sensor_data.dart';

class TestRepository {
  final MeasurementDatabase _database;

  TestRepository(this._database);

  Future<int> createNewMeasurement(List<SensorData> rawSensorData, bool eyesOpen) async {
    final measurementDao = _database.measurementDao;
    final rawMeasDataDao = _database.rawMeasurementDataDao;

    final newMeasId = await measurementDao.insertMeasurement(
      Measurement(
        creationDate: DateTime.now().millisecondsSinceEpoch,
        eyesOpen: eyesOpen,
      )
    );

    print("Salvato nuovo: $newMeasId");

    final rawDataList = rawSensorData.map((e) => RawMeasurement.fromSensorData(newMeasId, e));
    final a = await rawMeasDataDao.insertRawMeasurements(rawDataList);

    print("data: $a");
    return newMeasId;
  }
}