
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/raw_measurement_data.dart';
import 'package:balance_app/model/statokinesigram.dart';

/// Repository of the result screen
class ResultRepository {
  final MeasurementDatabase database;

  ResultRepository(this.database);

  /// Computes the statokinesigram from a [measurementId]
  Future<Statokinesigram> getResult(int measurementId) async {
    if (measurementId == null)
      return Future.error(ArgumentError("measurementId is null"));
    // TODO: 02/04/20 Put real code here

    Measurement meas = await database.measurementDao.findMeasurementById(measurementId);
    List<RawMeasurementData> rawMeas = await database.rawMeasurementDataDao.findAllRawMeasDataForId(measurementId);

    print("Found:");
    print(meas);
    print(rawMeas.length);
    final s = Statokinesigram();
    return Future.delayed(Duration(seconds: 4), () => s);
  }
}