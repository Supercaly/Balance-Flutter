
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

  Future<void> exportMeasurement(int measurementId) async{
    try {
      if (measurementId == null)
        throw Exception("Measurement id must not be null!");

      File file;
      // Create the file based on the platform
      if (Platform.isAndroid) {
        final baseDirectory = await getExternalStorageDirectories(type: StorageDirectory.documents);
        file = File('${baseDirectory[0].path}/test$measurementId.json');
      } else if (Platform.isIOS) {
        final baseDirectory = await getApplicationDocumentsDirectory();
        file = File('$baseDirectory/test$measurementId.json');
      } else
        throw Exception("This Platform [${Platform.operatingSystem}] is not supported!");

      print(file.path);

      final meas = await database.measurementDao.findMeasurementById(measurementId);
      final rawData = await database.rawMeasurementDataDao.findAllRawMeasDataForId(measurementId);
      final cogvData = await database.cogvDataDao.findAllCogvDataForId(measurementId);

      await file.writeAsString(
        jsonEncode({
          "measurement": meas.toJson(),
          "cogv": cogvData?.map((e) => e.toJson())?.toList(),
          "rawMeasurement": rawData?.map((e) => e.toJson())?.toList(),
        })
      );
    } catch(e) {
      print("Erorr: $e");
      return Future.error(e);
    }
  }
}