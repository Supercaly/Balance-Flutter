
import 'package:balance_app/dao/raw_measurement_data_dao.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/raw_measurement.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();

  group("Database Tests", () {
    MeasurementDatabase database;
    RawMeasurementDataDao rawMeasurementDataDao;
    List<RawMeasurement> rawMeasurementsList = [
      RawMeasurement(),
      RawMeasurement(),
      RawMeasurement(),
      RawMeasurement(),
      RawMeasurement(),
      RawMeasurement(),
    ];

    setUp(() async {
      database = await $FloorMeasurementDatabase
        .inMemoryDatabaseBuilder()
        .build();
      rawMeasurementDataDao = database.rawMeasurementDataDao;
    });

    tearDown(() async {
      await database.close();
      database = null;
      rawMeasurementDataDao = null;
    });

    test("insert new raw measurement data", () async {
      final newIds = await rawMeasurementDataDao
        .insertRawMeasurements(rawMeasurementsList);
    });
    
    test("read raw measurements", () async {
      final newIds = await rawMeasurementDataDao
        .insertRawMeasurements(rawMeasurementsList);
    });
  });
}