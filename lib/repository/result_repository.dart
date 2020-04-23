
import 'dart:convert';
import 'dart:io';

import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/raw_measurement_data.dart';
import 'package:path_provider/path_provider.dart';

/// Repository of the result screen
class ResultRepository {
  final MeasurementDatabase database;

  ResultRepository(this.database);

  /// Computes the statokinesigram from a [measurementId]
  Future<Measurement> getResult(int measurementId) async {
    if (measurementId == null)
      return Future.error(ArgumentError("measurementId is null"));
    // TODO: 02/04/20 Put real code here

    Measurement meas = await database.measurementDao.findMeasurementById(measurementId);
    List<RawMeasurementData> rawMeas = await database.rawMeasurementDataDao.findAllRawMeasDataForId(measurementId);

    print("Found:");
    print(meas);
    print(rawMeas.length);
    return Future.delayed(Duration(seconds: 4), () => meas);
  }

  Future<void> exportMeasurement(Measurement measurement) async{
    try {
      if (measurement == null)
        throw Exception("Measurement must not be null");

      File file;
      if (Platform.isAndroid) {
        final baseDirectory = await getExternalStorageDirectories(type: StorageDirectory.documents);
        file = File('${baseDirectory[0].path}/test${measurement.id}.json');
      } else if (Platform.isIOS) {
        final baseDirectory = await getApplicationDocumentsDirectory();
        file = File('$baseDirectory/test${measurement.id}.json');
      } else
        throw Exception("This Platform is not supported!");

      print(file.path);

      final json = jsonEncode({
        "id": measurement.id,
        "creationDate": measurement.creationDate,
        "eyesOpen": measurement.eyesOpen,
      });
      file.writeAsString(json);
    } catch(e) {
      print("Erorr: $e");
      return Future.error(e);
    }
  }
}